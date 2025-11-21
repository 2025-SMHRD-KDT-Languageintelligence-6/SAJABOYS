<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>QR 코드 스캔</title>
    <link rel="stylesheet" href="/assets/css/main.css">
    <style>
        body { background:#f5fafc; }
        .qr-panel {
            max-width:600px; margin:2.5rem auto;
            background:#fff; border-radius:18px;
            box-shadow:0 4px 14px rgba(0,0,0,.12);
            padding:1.5rem;
        }
        .qr-video {
            width: 100%;
            height: 420px;   /* 기존 300px → 420px 로 확대 */
            background: #000;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            border-radius: 12px;
            margin-bottom: 1.2rem; /* 버튼과의 간격도 조금 증가 */
        }
        .qr-buttons { display:flex; justify-content:center; gap:.6rem; margin-bottom:1rem; }
        .back-btn { text-align:center; margin-top:1rem; }
    </style>
</head>
<body>

<div class="qr-panel">
    <h2>QR 코드 스캔</h2>
    <div class="qr-video" id="qrPreview">📷 카메라 미리보기</div>
    <div class="qr-buttons">
        <button class="button" id="startScanBtn">카메라 열기</button>
        <button class="button alt" id="mockScanBtn">스캔 완료 (테스트)</button>
    </div>
    <div class="back-btn">
        <button class="button" onclick="location.href='/stamp'">← 스탬프 현황으로 돌아가기</button>
    </div>
</div>

<script src="https://unpkg.com/html5-qrcode"></script>
<script>
    const fesIdx = new URLSearchParams(window.location.search).get('fesIdx') || 1; // 축제 번호, 테스트 기본값 1
    let qrScanner;

    document.getElementById('startScanBtn').onclick = () => {
        const qrPreview = document.getElementById('qrPreview');
        qrPreview.innerHTML = '';
        qrScanner = new Html5Qrcode("qrPreview");

        Html5Qrcode.getCameras().then(cameras => {
            if(cameras && cameras.length){
                qrScanner.start(
                    { facingMode: "environment" },
                    { fps:10, qrbox:250 },
                    qrMessage => {
                        // QR 스캔 성공 시 서버 전송
                        fetch('/stamp/add', {
                            method:'POST',
                            headers: {'Content-Type':'application/x-www-form-urlencoded'},
                            body: new URLSearchParams({ stampNumber: qrMessage, fesIdx: fesIdx })
                        })
                        .then(res=>res.json())
                        .then(data=>{
                            if(data){
                                alert("스탬프 적립 완료!");
                                location.href = `/stamp/detail?fesIdx=${fesIdx}`;
                            } else {
                                alert("적립 실패, 다시 시도하세요.");
                            }
                        });
                        qrScanner.stop();
                    },
                    errorMessage => { /* 스캔 실패 무시 */ }
                );
            } else alert("카메라를 찾을 수 없습니다.");
        }).catch(err => alert(err));
    };

    // 테스트 버튼
    document.getElementById('mockScanBtn').onclick = () => {
        fetch('/stamp/add', {
            method:'POST',
            headers:{'Content-Type':'application/x-www-form-urlencoded'},
            body: new URLSearchParams({ stampNumber: 1, fesIdx: fesIdx })
        })
        .then(res=>res.json())
        .then(data=>{
            if(data){
                alert("테스트 스탬프 적립 완료!");
                location.href = `/stamp/detail?fesIdx=${fesIdx}`;
            } else alert("적립 실패");
        });
    };
</script>

</body>
</html>

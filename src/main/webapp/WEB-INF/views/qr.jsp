<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>QR 코드 스캔</title>
    <link rel="stylesheet" href="/assets/css/main.css">
    <style>
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
    // QR 코드가 URL 전체를 반환하므로, 현재 페이지의 fesIdx는 사용하지 않도록 수정합니다.
    // const fesIdx = new URLSearchParams(window.location.search).get('fesIdx') || 1;
    let qrScanner;

    // URL 문자열에서 특정 쿼리 파라미터의 값을 추출하는 함수
    function getQueryParamFromUrl(url, param) {
        try {
            const urlObj = new URL(url);
            return urlObj.searchParams.get(param);
        } catch (e) {
            console.error("URL 파싱 오류:", e);
            return null;
        }
    }

    // 스캔 로직 실행 함수
    function executeScan(scannedUrl, isMock = false) {
        // 🚨 1단계: 스캔된 URL에서 fesIdx와 stampNumber를 추출
        const scannedFesIdx = getQueryParamFromUrl(scannedUrl, 'fesIdx');
        const scannedStampNumber = getQueryParamFromUrl(scannedUrl, 'stampNumber');

        // 추출된 값이 유효한지 확인
        if (!scannedFesIdx || !scannedStampNumber) {
            alert("QR 코드가 유효하지 않습니다. [fesIdx] 또는 [stampNumber]가 누락되었습니다.");
            return;
        }

        // 2단계: 서버의 /stamp/add (POST)로 추출된 값만 전송
        fetch('/stamp/add', {
            method:'POST',
            headers: {'Content-Type':'application/x-www-form-urlencoded'},
            // 🚨 추출된 숫자 값만 전달
            body: new URLSearchParams({ stampNumber: scannedStampNumber, fesIdx: scannedFesIdx })
        })
        .then(res => res.json())
        .then(data => {
            if (data) {
                alert((isMock ? "테스트 " : "") + "스탬프 적립 완료!");
                // 3단계: 적립 후 해당 축제의 상세 페이지로 이동
                location.href = `/stamp/detail?fesIdx=${scannedFesIdx}`;
            } else {
                alert((isMock ? "테스트 " : "") + "적립 실패. 이미 적립했거나 유효하지 않은 스탬프입니다.");
            }
        })
        .catch(error => {
            console.error('Fetch Error:', error);
            alert("서버 통신 오류가 발생했습니다.");
        });

        if (qrScanner) {
            qrScanner.stop().catch(err => console.error("스캐너 중지 오류:", err));
        }
    }

    document.getElementById('startScanBtn').onclick = () => {
        // ... (카메라 시작 로직은 그대로 유지) ...
        const qrPreview = document.getElementById('qrPreview');
        qrPreview.innerHTML = '';
        qrScanner = new Html5Qrcode("qrPreview");

        Html5Qrcode.getCameras().then(cameras => {
            if(cameras && cameras.length){
                qrScanner.start(
                    { facingMode: "environment" },
                    { fps:10, qrbox:250 },
                    // 🚨 스캔 성공 시, 추출 로직을 담은 executeScan 함수 호출
                    scannedUrl => executeScan(scannedUrl, false),
                    errorMessage => { /* 스캔 실패 무시 */ }
                );
            } else alert("카메라를 찾을 수 없습니다.");
        }).catch(err => alert(err));
    };

    // 테스트 버튼 (모바일 카메라에서 얻은 실제 URL 값 사용)
    document.getElementById('mockScanBtn').onclick = () => {
        // 모바일에서 스캔했을 때 얻은 텍스트를 그대로 사용합니다.
        const mockUrl = "/stamp/scan?fesIdx=1&stampNumber=4";
        executeScan(mockUrl, true);
    };
</script>

</body>
</html>

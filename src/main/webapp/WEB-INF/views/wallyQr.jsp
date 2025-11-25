<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>월리 QR 코드 스캔</title>
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
    <h2>월리 QR 코드 스캔</h2>
    <div class="qr-video" id="qrPreview">📷 카메라 미리보기</div>
    <div class="qr-buttons">
        <button class="button" id="startScanBtn">카메라 열기</button>
        <button class="button alt" id="mockScanBtn">스캔 완료 (테스트)</button>
    </div>
    <div class="back-btn">
        <button class="button" onclick="location.href='/main'">← 메인으로 돌아가기</button>
    </div>
</div>

<script src="https://unpkg.com/html5-qrcode"></script>
<script>
    let qrScanner;

    // URL 문자열에서 특정 쿼리 파라미터의 값을 추출하는 함수
    function getQueryParamFromUrl(scannedUrl, param) {
        if (!scannedUrl) return null;

        let absoluteUrl;

        // 스캔된 URL이 상대 경로로 시작하면, 현재 페이지의 origin을 붙여 절대 경로로 만듭니다.
        if (scannedUrl.startsWith('/')) {
            absoluteUrl = window.location.origin + scannedUrl;
        } else {
            absoluteUrl = scannedUrl;
        }

        try {
            // 절대 경로로 파싱을 시도합니다.
            const urlObj = new URL(absoluteUrl);
            return urlObj.searchParams.get(param);
        } catch (e) {
            console.error("URL 파싱 오류:", e, "원본 URL:", scannedUrl);
            return null;
        }
    }

    // 스캔 로직 실행 함수 (POST 요청 로직 제거)
    function executeScan(scannedUrl) {

        // 1단계: 유효성 검사 (QR이 올바른 형식인지 확인)
        // 이 검사를 통과하지 못하면 /scan으로 이동하지 않습니다.
        const scannedFesIdx = getQueryParamFromUrl(scannedUrl, 'fesIdx');
        const scannedGameResult = getQueryParamFromUrl(scannedUrl, 'gameResult');

        if (!scannedFesIdx || !scannedGameResult) {
            alert("QR 코드가 유효하지 않습니다. [fesIdx] 또는 [gameResult]가 누락되었습니다.");
            return;
        }

        // 스캐너 중지
        if (qrScanner) {
            qrScanner.stop().catch(err => console.error("스캐너 중지 오류:", err));
        }

        // 🚨 2단계: 핵심 수정! POST 대신 GET 요청으로 페이지를 이동시킵니다.
        // 이 요청이 @GetMapping("/scan") 컨트롤러를 호출하여 적립 및 결과 페이지 표시를 완료합니다.
        location.href = scannedUrl;
    }

    document.getElementById('startScanBtn').onclick = () => {
        const qrPreview = document.getElementById('qrPreview');
        qrPreview.innerHTML = '';
        qrScanner = new Html5Qrcode("qrPreview");

        Html5Qrcode.getCameras().then(cameras => {
            if(cameras && cameras.length){
                qrScanner.start(
                    { facingMode: "environment" },
                    { fps:10, qrbox:250 },
                    // 스캔 성공 시, 해당 URL로 즉시 이동
                    scannedUrl => executeScan(scannedUrl),
                    errorMessage => { /* 스캔 실패 무시 */ }
                );
            } else alert("카메라를 찾을 수 없습니다.");
        }).catch(err => alert(err));
    };

    // 테스트 버튼 (GET 요청으로 처리)
    document.getElementById('mockScanBtn').onclick = () => {
        // 현재 수동으로 성공한 조합과 다른 새로운 번호로 테스트해보세요.
        const mockUrl = "/stamp/scan?fesIdx=1&gameResult=1";
        executeScan(mockUrl);
    };
</script>

</body>
</html>

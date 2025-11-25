<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>왈리 QR 코드 생성 | 추적자</title>

    <link rel="stylesheet" href="/assets/css/main.css" />

    <style>

        .qrgen-wrap{
          min-height:100dvh;
          display:flex;
          align-items:center;
          justify-content:center;
          padding:3rem 1rem;
        }
        .qrgen-card{
          width:100%;
          max-width:900px;
          border-radius:12px;
          display:grid;
          grid-template-columns: minmax(0,1.4fr) minmax(260px,1fr);
          gap:1.5rem;
        }
        .qrgen-card h2{
          margin-top:0;
          margin-bottom:.5rem;
          font-weight:800;
        }
        .qr-form-group{
          margin-bottom:.9rem;
        }
        .qr-form-group label{
          display:block;
          font-size:.9rem;
          font-weight:600;
          margin-bottom:.25rem;
        }
        .qr-form-group small{
          display:block;
          font-size:.8rem;
          color:#777;
          margin-top:.2rem;
        }
        .qr-row-inline{
          display:flex;
          gap:.5rem;
          align-items:center;
          flex-wrap:wrap;
        }
        .qr-actions{
          margin-top:1.1rem;
          display:flex;
          flex-wrap:wrap;
          gap:.5rem;
        }
        .qr-actions .button{
          min-width:140px;
        }
        .qr-preview-wrap{
          border-radius:12px;
          border:2px dashed #cfd8e3;
          background:#f7fbff;
          padding:1.2rem;
          text-align:center;
          display:flex;
          flex-direction:column;
          justify-content:space-between;
          gap:1rem;
        }
        .qr-preview-box{
          min-height:220px;
          display:flex;
          align-items:center;
          justify-content:center;
        }
        #qrcode{
          display:inline-block;
        }
        .qr-preview-empty{
          font-size:.9rem;
          color:#777;
        }
        .qr-info{
          font-size:.8rem;
          color:#777;
          line-height:1.5;
        }
        .qr-download-btn{
          margin-top:.3rem;
        }

        @media (max-width:860px){
          .qrgen-card{
            grid-template-columns:1fr;
          }
        }
    </style>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>
</head>
<body class="is-preload">

<div id="site-header"></div>
<script src="/assets/js/header.js"></script>

<div id="page-wrapper">
    <main class="qrgen-wrap">
        <section class="box qrgen-card">

            <div>
                <h2>QR 코드 생성기</h2>

                <div class="qr-form-group">
                    <label for="fesNo">축제 번호</label>
                    <input type="text" id="fesNo" style="width:100%;" placeholder="축제 번호를 입력하세요" autocomplete="off">
                </div>

                <div class="qr-form-group">
                    <label for="gameResult">윌리 여부(0은 가짜, 1은 진짜)</label>
                    <input type="text" id="gameResult" style="width:100%;" placeholder="0은 가짜, 1은 진짜" autocomplete="off">
                </div>

                <div class="qr-form-group">
                    <label for="qrLabel">QR 라벨 (파일명/출력 메모)</label>
                    <input type="text" id="qrLabel" placeholder="예) 축제1_스탬프3" style="width:100%;">
                </div>

                <div class="qr-form-group">
                    <label for="qrSize">QR 크기 (px)</label>
                    <input type="number" id="qrSize" value="240" min="120" max="600" step="20" style="width:100%;">
                </div>

                <div class="qr-actions">
                    <button type="button" class="button" id="generateBtn">QR 생성</button>
                    <button type="button" class="button alt" id="clearBtn">초기화</button>
                </div>
            </div>

            <div class="qr-preview-wrap">
                <div class="qr-preview-box">
                    <div id="qrcode">
                        <div class="qr-preview-empty">
                            생성된 QR이 없습니다.<br>
                            항목 입력 후 <strong>“QR 생성”</strong>을 누르세요.
                        </div>
                    </div>
                </div>

                <div>
                    <div class="qr-info" id="qrInfo">
                        · 생성 후 PNG 저장 가능
                    </div>
                    <div class="qr-download-btn">
                        <a id="downloadLink" href="#" download="qrcode.png"
                           class="button small" style="display:none;">
                            PNG 다운로드
                        </a>
                    </div>
                </div>
            </div>

        </section>
    </main>
</div>

<script>
document.addEventListener("DOMContentLoaded", () => {
    let qr;

    const qrDiv      = document.getElementById("qrcode");
    const downloadEl = document.getElementById("downloadLink");
    const infoEl     = document.getElementById("qrInfo");

    // QR 생성 버튼
    document.getElementById("generateBtn").addEventListener("click", () => {
        // 1. 입력 필드 요소 자체를 가져오기
        const fesEl = document.getElementById("fesNo");
        const wallyEl = document.getElementById("gameResult");

        // 2. 값 가져오기: type="text"이므로 .value를 그대로 사용
        const fes = fesEl.value.trim();
        const wally = wallyEl.value.trim();

        // 3. 필수 입력값 체크 및 사용자 경고
        if (!fes || !wally) {
            let msg = "다음 항목은 필수 입력입니다. 확인해 주세요:\n";
            if (!fes) msg += " - 축제 번호\n";
            if (!wally) msg += " - 스탬프 번호\n";
            alert(msg);

            if (!fes) fesEl.focus();
            else if (!wally) wallyEl.focus();

            return; // QR 생성 중단
        }

        const label = document.getElementById("qrLabel").value.trim() || "qrcode";
        let size = parseInt(document.getElementById("qrSize").value, 10) || 240;

        // 최소/최대 체크
        if (size < 120) size = 120;
        if (size > 600) size = 600;

        // 4. URL 생성: 🚨 템플릿 리터럴 대신 문자열 연결(+) 사용
        const baseUrl = "/wally/scan?fesIdx=";
        const url = baseUrl + fes + "&gameResult=" + wally;
        console.log("생성할 URL:", url);

        // QR 초기화
        qrDiv.innerHTML = "";

        // QR 생성
        qr = new QRCode(qrDiv, {
            text: url,
            width: size,
            height: size,
            correctLevel: QRCode.CorrectLevel.H
        });

        // 다운로드 링크 설정
        setTimeout(() => {
            const img = qrDiv.querySelector("img") || qrDiv.querySelector("canvas");
            if (!img) return;

            let dataUrl = img.tagName === "IMG" ? img.src : img.toDataURL("image/png");

            downloadEl.href = dataUrl;
            downloadEl.download = (label || "qrcode") + ".png";
            downloadEl.style.display = "inline-block";

            infoEl.textContent = `QR이 생성되었습니다. URL: ${url}`;
        }, 200);
    });

    // 초기화 버튼
    document.getElementById("clearBtn").addEventListener("click", () => {
        document.getElementById("fesNo").value = "";
        document.getElementById("stampNo").value = "";
        document.getElementById("qrLabel").value = "";
        document.getElementById("qrSize").value = 240;

        qrDiv.innerHTML = `<div class="qr-preview-empty">생성된 QR이 없습니다.<br>항목 입력 후 <strong>“QR 생성”</strong>을 누르세요.</div>`;
        downloadEl.style.display = "none";
        infoEl.textContent = "· 생성 후 PNG 저장 가능";
    });
});
</script>

<script src="/assets/js/jquery.min.js"></script>
<script src="/assets/js/jquery.dropotron.min.js"></script>
<script src="/assets/js/browser.min.js"></script>
<script src="/assets/js/breakpoints.min.js"></script>
<script src="/assets/js/util.js"></script>
<script src="/assets/js/main.js"></script>
</body>
</html>
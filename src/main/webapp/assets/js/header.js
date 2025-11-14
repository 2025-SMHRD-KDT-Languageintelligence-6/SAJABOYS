// ===== header.js =====

// 페이지 DOM 준비되면 실행
document.addEventListener("DOMContentLoaded", () => {
  // 헤더를 삽입할 요소 찾기
  const headerTarget = document.getElementById("site-header");

  if (headerTarget) {
    fetch("/partials/header.html")      // header.html 경로
      .then(response => response.text())
      .then(data => {
        headerTarget.innerHTML = data;

        // 드롭다운 메뉴 재적용 (Verti dropotron 사용 시 필요)
        if (window.$ && $("#nav > ul").dropotron) {
          $("#nav > ul").dropotron({
            offsetY: -12
          });
        }
      })
      .catch(err => {
        headerTarget.innerHTML =
          `<div style="padding:10px;color:#c00;">헤더 로드 실패</div>`;
      });
  }
});

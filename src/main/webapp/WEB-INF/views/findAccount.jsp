<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- JSTL : 자바코드를 활용할 수 있게끔 만들어진 '커스텀 태그 라이브러리' --%>
<%-- JSTL사용법 1) dependency 추가 2)지시자를 이용해서 어떤 라이브러리 사용하는 것인지 명시 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>아이디 / 비밀번호 찾기 | 추적자</title>

  <!-- Verti 기본 CSS -->
  <link rel="stylesheet" href="/assets/css/main.css" />

  <style>
    /* 페이지 전용 스타일 */
    .find-wrap{
      min-height:100dvh;
      display:flex;
      align-items:center;
      justify-content:center;
      padding:3rem 1rem;
    }
    .find-card{
      width:100%;
      max-width:800px;
      border-radius:10px;
    }
    .title{
      text-align:center;
      font-weight:800;
      margin-bottom:1rem;
    }

    .tab-buttons{
      display:flex;
      margin-bottom:1.5rem;
      border-radius:999px;
      background:#f2f2f2;
      padding:0.25rem;
    }
    .tab-button{
      flex:1;
      text-align:center;
      padding:0.7rem 0.5rem;
      border-radius:999px;
      cursor:pointer;
      font-weight:700;
      font-size:0.95rem;
      border:none;
      background:transparent;
    }
    .tab-button.active{
      background:#0090c5;
      color:#fff;
    }

    .tab-panel{
      display:none;
    }
    .tab-panel.active{
      display:block;
    }

    .grid-2{
      display:grid;
      grid-template-columns:140px 1fr;
      gap:.75rem 1rem;
      align-items:center;
    }
    .grid-2 .full{ grid-column:1 / -1; }
    .muted{ color:#777; font-size:.9em; }
    .button.full{ width:100%; }
    .result-box{
      margin-top:0.75rem;
      padding:0.75rem 1rem;
      border-radius:8px;
      background:#f9f9f9;
      font-size:0.9rem;
    }
    .result-box strong{ color:#0090c5; }
    .error-msg{
      color:#ef4444;
      font-size:0.9rem;
      margin-top:0.5rem;
    }

    @media(max-width:736px){
      .grid-2{ grid-template-columns:1fr; }
    }
  </style>
</head>
<body class="is-preload">

  <!-- 공통 헤더 include -->
  <div id="site-header"></div>
  <script src="/assets/js/header.js"></script>

  <div id="page-wrapper">
    <main class="find-wrap">
      <section class="box find-card" aria-labelledby="findTitle">
        <h2 id="findTitle" class="title">아이디 / 비밀번호 찾기</h2>

        <!-- 탭 버튼 -->
        <div class="tab-buttons">
          <button type="button" class="tab-button active" data-target="tab-id">아이디 찾기</button>
          <button type="button" class="tab-button" data-target="tab-pw">비밀번호 찾기</button>
        </div>

        <!-- 아이디 찾기 -->
        <section id="tab-id" class="tab-panel active" aria-label="아이디 찾기">
          <!-- 실제 서비스에서는 action을 아이디 찾기 처리 URL로 변경 -->
          <form action="findId" method="post" novalidate>
            <div class="grid-2">
              <label for="name">이름</label>
              <input type="text" id="name" name="Name" placeholder="예) 홍길동" required />

              <label for="email">이메일</label>
              <input type="email" id="email" name="Email" placeholder="예) user@example.com" required />

              <!-- 또는 휴대폰으로 찾기 식으로 바꿔도 됨 -->
              <%--
              <label for="phone">휴대폰 번호</label>
              <input type="tel" id="phone" name="phone" placeholder="01012345678" />
              --%>

              <div class="full">
                <button type="submit" class="button full icon solid fa-search">아이디 찾기</button>
              </div>

              <div class="full">
                  <c:if test="${not empty foundId}">
                      <div class="result-box">
                          찾으신 아이디는 <strong>${foundId}</strong> 입니다.
                      </div>
                  </c:if>
                  <c:if test="${not empty idError}">
                      <div class="error-msg">${idError}</div>
                  </c:if>
              </div>
            </div>
          </form>
        </section>

        <!-- 비밀번호 찾기 -->
        <section id="tab-pw" class="tab-panel" aria-label="비밀번호 찾기">
          <!-- 실제 서비스에서는 action을 비밀번호 찾기(임시 비밀번호 발급 등) URL로 변경 -->
          <form action="findPw" method="post" novalidate>
            <div class="grid-2">
              <label for="uid">아이디</label>
              <input type="text" id="uid" name="UserId" placeholder="예) smart1234" required />

              <label for="emailPw">이메일</label>
              <input type="email" id="emailPw" name="Email" placeholder="회원가입 시 등록한 이메일" required />

              <div class="full muted">
                입력하신 정보로 임시 비밀번호를 발급하거나, 비밀번호 재설정 링크를 전송합니다.
              </div>

              <div class="full">
                <button type="submit" class="button full icon solid fa-unlock">비밀번호 찾기</button>
              </div>

              <!-- 서버에서 처리 결과를 넘겨줄 경우 -->
              <%
                String pwMsg = (String)request.getAttribute("pwMsg");
                String pwError = (String)request.getAttribute("pwError");
              %>
              <div class="full">
                <% if(pwMsg != null){ %>
                  <div class="result-box">
                    <%= pwMsg %>
                  </div>
                <% } else if(pwError != null){ %>
                  <div class="error-msg"><%= pwError %></div>
                <% } %>
              </div>
            </div>
          </form>
        </section>

      </section>
    </main>

    <!-- 푸터 -->
    <div id="footer-wrapper">
      <div class="container" id="footer">
        <div id="copyright">
          <ul class="menu">
            <li>&copy; 2025 RunBack</li>
            <li>Verti 테마 기반 커스텀</li>
          </ul>
        </div>
      </div>
    </div>
  </div>

  <!-- 탭 전환 스크립트 -->
  <script>
    const tabButtons = document.querySelectorAll(".tab-button");
    const tabPanels = document.querySelectorAll(".tab-panel");

    tabButtons.forEach(btn => {
      btn.addEventListener("click", () => {
        // 버튼 active 변경
        tabButtons.forEach(b => b.classList.remove("active"));
        btn.classList.add("active");

        // 패널 active 변경
        const targetId = btn.getAttribute("data-target");
        tabPanels.forEach(panel => {
          if(panel.id === targetId){
            panel.classList.add("active");
          }else{
            panel.classList.remove("active");
          }
        });
      });
    });
  </script>
</body>
</html>

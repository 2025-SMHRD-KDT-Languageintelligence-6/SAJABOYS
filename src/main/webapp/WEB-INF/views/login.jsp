<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- JSTL : 자바코드를 활용할 수 있게끔 만들어진 '커스텀 태그 라이브러리' --%>
<%-- JSTL사용법 1) dependency 추가 2)지시자를 이용해서 어떤 라이브러리 사용하는 것인지 명시 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>로그인 | 축제 게임</title>

    <!-- Verti 스타일 사용 (당신이 준 CSS 경로로 맞춰주세요) -->
    <link rel="stylesheet" href="assets/css/main.css" />
    <link rel="stylesheet" href="assets/css/fontawesome-all.min.css" />

    <style>
        /* 페이지 전용 보강 스타일 */
        .auth-wrap{
          min-height: 100dvh;
          display:flex; align-items:center; justify-content:center;
          padding: 3rem 1rem;
        }
        .auth-card{
          width:100%; max-width:420px;
          border-radius:10px;
        }
        .title{
          text-align:center; margin-bottom:1.2rem; font-weight:800;
        }
        .subtitle{
          text-align:center; color:#777; margin:-0.8rem 0 1.8rem 0;
        }
        .field + .field{ margin-top:0.75rem; }
        .helper{
          text-align:center; margin-top:1rem; font-size:.95em;
        }
        .helper a{ text-decoration:underline; }
        .brand{
          text-align:center; margin-bottom:.5rem; font-family:'Oleo Script', cursive;
          font-size:1.6rem; color:#ff4486;
        }
        .button.full{ width:100%; }
    </style>
</head>
<body class="is-preload">

<!-- 공통 헤더 include -->
<div id="site-header"></div>
<script src="/assets/js/header.js"></script>



<main class="auth-wrap">
    <section class="box auth-card" aria-labelledby="loginTitle">
        <div class="brand">추적자들</div>
        <h2 id="loginTitle" class="title">로그인</h2>
        <p class="subtitle" aria-hidden="true">아이디와 비밀번호를 입력해 주세요</p>

        <!-- 실제 서비스에서는 action을 로그인 처리 URL로 변경 -->
        <form id="loginForm" action="/login" method="post" novalidate>
            <div class="field">
                <label for="userid">아이디</label>
                <input type="text" id="userid" name="UserId" placeholder="아이디 입력" required autocomplete="username" />
            </div>

            <div class="field">
                <label for="userpw">비밀번호</label>
                <input type="password" id="userpw" name="PasswordHash" placeholder="비밀번호 입력" required autocomplete="current-password" />
            </div>

            <div class="field" style="margin-top:.5rem;">
                <label style="display:flex;align-items:center;gap:.5rem;">
                    <input type="checkbox" name="remember" style="width:auto;line-height:normal;" />
                    로그인 상태 유지
                </label>
            </div>

            <ul class="actions" style="margin-top:1.25rem;">
                <li style="width:100%;">
                    <button type="submit" class="button full icon solid fa-sign-in-alt">로그인</button>
                </li>
            </ul>

            <div class="helper">
                <a href="/find-account">아이디/비밀번호를 잊으셨나요?</a>
            </div>
            <div class="helper">
                아직 회원이 아니신가요?
                <a href="signup">회원가입 하러가기 &raquo;</a>
            </div>
        </form>
    </section>
</main>

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

<!-- 간단한 클라이언트 검증 -->
<script>
    document.getElementById('loginForm').addEventListener('submit', function(e){
      const id = document.getElementById('userid');
      const pw = document.getElementById('userpw');
      if(!id.value.trim()){
        alert('아이디를 입력해 주세요.');
        id.focus();
        e.preventDefault(); return;
      }
      if(!pw.value.trim()){
        alert('비밀번호를 입력해 주세요.');
        pw.focus();
        e.preventDefault(); return;
      }
      // TODO: 실제 제출 전 추가 로직(예: 로딩 표시) 가능
    });
</script>
</body>
</html>


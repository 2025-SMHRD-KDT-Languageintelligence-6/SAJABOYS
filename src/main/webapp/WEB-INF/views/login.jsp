<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- JSTL : 자바코드를 활용할 수 있게끔 만들어진 '커스텀 태그 라이브러리' --%>
<%-- JSTL사용법 1) dependency 추가 2)지시자를 이용해서 어떤 라이브러리 사용하는 것인지 명시 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>로그인 | 축제 게임</title>

    <!-- Verti 스타일 사용 (당신이 준 CSS 경로로 맞춰주세요) -->
    <link rel="stylesheet" href="${ctx}/assets/css/main.css" />
    <link rel="stylesheet" href="${ctx}/assets/css/login.css" />
    <link rel="stylesheet" href="${ctx}/assets/css/fontawesome-all.min.css" />


</head>
<body class="is-preload">

<!-- 공통 헤더 include -->
<div id="site-header"></div>
<script src="${ctx}/assets/js/header.js"></script>



<main class="auth-wrap">
    <section class="box auth-card" aria-labelledby="loginTitle">
        <div class="brand"></div>
        <h2 id="loginTitle" class="title">로그인</h2>
        <p class="subtitle" aria-hidden="true">아이디와 비밀번호를 입력해 주세요</p>

        <!-- 실제 서비스에서는 action을 로그인 처리 URL로 변경 -->
        <form id="loginForm" action="${ctx}/login" method="post" novalidate>
            <div class="field">
                <label for="userid">아이디</label>
                <input type="text" id="userid" name="UserId" placeholder="아이디 입력" required autocomplete="username" />
            </div>

            <div class="field">
                <label for="userpw">비밀번호</label>
                <input type="password" id="userpw" name="PasswordHash" placeholder="비밀번호 입력" required autocomplete="current-password" />
            </div>



            <ul class="actions" style="margin-top:1.25rem;">
                <li style="width:100%;">
                    <button type="submit" class="button full icon solid fa-sign-in-alt">로그인</button>
                </li>
            </ul>

            <div class="helper">
                <a href="findAccount">아이디/비밀번호를 잊으셨나요?</a>
            </div>
            <div class="helper">
                아직 회원이 아니신가요?
                <br>
                <a href="signup">회원가입 하러가기 &raquo;</a>
            </div>
        </form>
    </section>
</main>

<footer id="auth-footer">
    <div class="auth-footer-inner">
        <p class="auth-footer-brand">© chaser</p>
        <p class="auth-footer-desc">Festival Game Platform · Powered by Verti Theme</p>
    </div>
</footer>


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
<c:if test="${not empty msg}">
<script>
    alert("${msg}");
</script>
</c:if>
</body>
</html>


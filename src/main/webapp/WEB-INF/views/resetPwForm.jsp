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
  <title>비밀번호 변경 | 추적자</title>

  <!-- Verti 기본 CSS -->
  <link rel="stylesheet" href="assets/css/main.css" />

  <style>
    .pw-wrap{
      min-height:100dvh;
      display:flex;
      align-items:center;
      justify-content:center;
      padding:3rem 1rem;
      background:#f5fafc;
    }
    .pw-card{
      width:100%;
      max-width:520px;
      border-radius:14px;
      padding:2rem 2.2rem;
    }
    .pw-title{
      text-align:center;
      font-weight:800;
      font-size:1.6rem;
      margin-bottom:.4rem;
    }
    .pw-sub{
      text-align:center;
      font-size:.9rem;
      color:#666;
      margin-bottom:1.4rem;
    }
    .pw-form{
      display:flex;
      flex-direction:column;
      gap:1rem;
    }
    .pw-form label{
      font-weight:700;
      font-size:.9rem;
      margin-bottom:.2rem;
      display:block;
    }
    .pw-form input[type="password"]{
      width:100%;
      border-radius:8px;
      border:1px solid #ddd;
      padding:.55rem .7rem;
      font-size:.95rem;
    }
    .pw-form input[type="password"]:focus{
      border-color:#0090c5;
      outline:none;
    }
    .pw-error{
      font-size:.8rem;
      color:#e53935;
      display:none;
      margin-top:.2rem;
    }
    .pw-info{
      font-size:.8rem;
      color:#777;
      margin-top:.1rem;
    }
    .pw-btn-row{
      margin-top:1.4rem;
      display:flex;
      gap:.6rem;
      justify-content:flex-end;
      flex-wrap:wrap;
    }
    .pw-btn-row .button{
      min-width:120px;
      font-size:.95rem;
      padding:.55rem 0;
    }
  </style>
</head>
<body class="is-preload">

<div id="page-wrapper">

  <!-- 공통 헤더 include -->
  <div id="site-header"></div>
  <script src="assets/js/header.js"></script>

  <main class="pw-wrap">
    <section class="box pw-card">
      <h2 class="pw-title">비밀번호 변경</h2>
      

      <form id="pwForm" action="resetPw" method="post" novalidate class="pw-form">
      <input type="hidden" name="token" value="${token}">

        

        <!-- 새 비밀번호 -->
        <div>
          <label for="newPw">새 비밀번호</label>
          <input type="password" id="newPw" name="PasswordHash"
                 placeholder="영문/숫자/특수문자 8~20자"
                 required minlength="8" maxlength="20"
                 pattern="(?=.*[A-Za-z])(?=.*\d)(?=.*[~`!@#$%^&*()_\-+=\[\]{}|\\;:'\,./?]).{8,20}" />
          <div class="pw-info">영문, 숫자, 특수문자를 각각 1자 이상 포함해주세요.</div>
        </div>

        

        <!-- 버튼 영역 -->
        <div class="pw-btn-row">
          <button type="button" class="button alt" onclick="history.back()">취소</button>
          <button type="submit" class="button">비밀번호 변경</button>
        </div>

      </form>
    </section>
  </main>

  <!-- 푸터 -->
  <div id="footer-wrapper">
    <div class="container" id="footer">
      <div id="copyright">
        <ul class="menu">
          <li>&copy; 2025 RunBack</li>
          <li>추적자 · 비밀번호 변경</li>
        </ul>
      </div>
    </div>
  </div>

</div>



</body>
</html>

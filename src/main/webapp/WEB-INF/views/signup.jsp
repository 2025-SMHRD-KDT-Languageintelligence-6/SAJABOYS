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
    <title>회원가입 | 축제 게임</title>

    <!-- Verti 기본 CSS (사용자가 준 main.css 경로로 연결) -->
    <link rel="stylesheet" href="/assets/css/main.css" />

    <style>
        /* 페이지 전용 보강 스타일 */
        .signup-wrap{
          min-height: 100dvh;
          display:flex; align-items:center; justify-content:center;
          padding: 3rem 1rem;
        }
        .signup-card{
          width:100%; max-width:1000px;
          border-radius:10px;
        }
        .title{ text-align:center; font-weight:800; margin-bottom:1rem; }
        .grid-2{ display:grid; grid-template-columns:160px 1fr; gap:.75rem 1rem; align-items:center; }
        .grid-2 .full { grid-column:1 / -1; }
        .row-inline{ display:flex; gap:.5rem; align-items:center; }
        .button.full{ width:100%; }
        .muted{ color:#777; font-size:.9em; }
        .error{ color:#ef4444; font-size:.9em; margin-top:.25rem; display:none; }
        @media (max-width:736px){ .grid-2{ grid-template-columns:1fr; } }
    </style>
</head>
<body class="is-preload">


<!-- Header -->
<div id="header-wrapper">
    <header id="header" class="container">

        <!-- Logo -->
        <div id="logo">
            <h1><a href="main">추적자</a></h1>
            <span>지역축제 술레잡기 게임</span>
        </div>

        <!-- Nav -->
        <nav id="nav">
            <ul>
                <li class="current"><a href="main">Home</a></li>
                <li>
                    <a href="/1_Game.html">게임창</a>
                    <ul>
                        <li><a href="#">좀비게임</a></li>
                        <li><a href="#">윌리를 찾아라</a></li>
                        <li><a href="#">경찰과 도둑</a></li>
                        <li><a href="#">거점점령전</a></li>
                        <li>
                            <a href="/1_1_5Rule.html">룰 북</a>
                            <ul>
                                <li><a href="/1_1_1zombie.html">좀비게임</a></li>
                                <li><a href="/1_1_2wily.html">윌리를 찾아라</a></li>
                                <li><a href="/1_1_3police.html">경찰과 도둑</a></li>
                                <li><a href="/1_1_4occupy.html">거점점령전</a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li><a href="#">스템프 투어창</a></li>
                <li><a href="/right-sidebar.html">축제 장</a></li>
                <li><a href="/no-sidebar.html">커뮤니티</a></li>
                <li><a href="login">로그인/회원가입</a></li>
            </ul>
        </nav>

    </header>
</div>


<div id="page-wrapper">
    <main class="signup-wrap">
        <section class="box signup-card" aria-labelledby="signupTitle">
            <h2 id="signupTitle" class="title">회원가입</h2>

            <!-- 실제 서비스에서는 action을 회원가입 처리 URL로 변경 -->
            <form id="signupForm" action="join" method="post" novalidate>
                <div class="grid-2">

                    <!-- 아이디 -->
                    <label for="uid">*아이디</label>
                    <div class="row-inline">
                        <input type="text" id="uid" name="UserId" placeholder="예) smart"
                               required minlength="4" maxlength="16"
                               pattern="[a-zA-Z0-9_]{4,16}" style="flex:1" />
                        <button type="button" class="button alt" id="checkBtn">중복체크</button>
                    </div>


                    <!-- 비밀번호 -->

                    <label for="pw">*비밀번호</label>
                    <div>
                        <input type="password" id="pw" name="PasswordHash" placeholder="영문/숫자/특수문자 8~20자"
                               required minlength="8" maxlength="20"
                               pattern="(?=.*[A-Za-z])(?=.*\d)(?=.*[~`!@#$%^&*()_\-+=\[\]{}|\\;:'\,./?]).{8,20}" />
                    </div>

                    <!-- 비밀번호 확인 -->
                    <label for="pw2">*비밀번호 재확인</label>
                    <div>
                        <input type="password" id="pw2" placeholder="비밀번호를 다시 입력"
                               required minlength="8" maxlength="20" />
                        <div id="pwErr" class="error">비밀번호가 일치하지 않습니다.</div>
                    </div>

                    <!-- 이름 -->
                    <label for="name">*이름</label>
                    <input type="text" id="name" name="Name" placeholder="예) 홍길동" required />

                    <!-- Nickname -->
                                <label for="nickname">*닉네임</label>
                                <input type="text" id="nickname" name="Nickname" placeholder="예) 피카츄" required />

                    <!-- 성별 -->
                    <label for="gender">*성별</label>
                    <select id="gender" name="Gender" required>
                        <option value="">선택</option>
                        <option value="M">남성</option>
                        <option value="W">여성</option>
                        <option value="N">기타/선택안함</option>
                    </select>

                    <!-- 이메일 (필수) -->
                    <label for="emailLocal">이메일</label>
                    <div class="row-inline">
                        <input type="text" id="emailLocal" name="emailLocal" placeholder="아이디" required style="max-width:200px;">
                        <span>@</span>
                        <input type="text" id="emailDomain" name="emailDomain" placeholder="도메인 입력" required style="flex:1;max-width:100px;">
                        <select id="domainSel" class="alt">
                            <option value="">직접입력</option>
                            <option value="gmail.com">gmail.com</option>
                            <option value="naver.com">naver.com</option>
                            <option value="daum.net">daum.net</option>
                            <option value="kakao.com">kakao.com</option>
                            <option value="outlook.com">outlook.com</option>
                        </select>
                    </div>

                    <script>
                        // 이메일 도메인 선택 처리
                        const domainSel = document.getElementById('domainSel');
                        const emailDomain = document.getElementById('emailDomain');

                        // ✅ 페이지 로드 시 항상 입력 가능
                        emailDomain.readOnly = false;

                        domainSel.addEventListener('change', () => {
                          const selected = domainSel.value;
                          if (selected) {
                            // 선택된 도메인 자동 입력 및 읽기 전용 전환
                            emailDomain.value = selected;
                            emailDomain.readOnly = true;
                          } else {
                            // "직접입력" 선택 시 입력 가능하도록 복구
                            emailDomain.value = '';
                            emailDomain.readOnly = false;
                            emailDomain.focus();
                          }
                        });
                    </script>


                    <div class="full muted">*는 필수 입력 사항입니다.</div>

                    <!-- 생년월일 (선택) -->
                    <label for="birth">생년월일</label>
                    <input type="date" id="birth" name="BirthDate"/>

                    <!-- 휴대폰 (선택) -->
                    <label for="phone">핸드폰 번호</label>
                    <input type="tel" id="phone" name="Phone" placeholder="01011112222"
                           inputmode="numeric" pattern="^01[016789]\d{7,8}$"  />

                    <!-- 약관 동의(샘플) -->
                    <label for="agree">약관 동의</label>
                    <label class="row-inline" style="gap:.5rem;">
                        <input type="checkbox" id="agree" required style="width:auto;"> 이용약관 및 개인정보 처리방침에 동의합니다.
                    </label>

                    <!-- 제출 -->
                    <div class="full">
                        <button type="submit" class="button full icon solid fa-user-plus">회원가입</button>
                    </div>
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

<!-- 간단한 클라이언트 검증 & 유틸 -->
<script>
    // 이메일 도메인 선택
    const domainSel = document.getElementById('domainSel');
    const emailDomain = document.getElementById('emailDomain');
    domainSel.addEventListener('change', () => {
      if(domainSel.value){
        emailDomain.value = domainSel.value;
        emailDomain.readOnly = true;
      }else{
        emailDomain.readOnly = false;
        emailDomain.value = '';
      }
      emailDomain.focus();
    });

    // 아이디 중복체크 (데모용 모의)
    const usedIds = ['admin','test','smart1'];
    document.getElementById('checkBtn').addEventListener('click', () => {
      const v = document.getElementById('uid').value.trim();
      if(!v){ alert('아이디를 입력하세요.'); return; }
      if(!/^[a-zA-Z0-9_]{4,16}$/.test(v)){ alert('아이디 형식을 확인하세요.'); return; }
      if(usedIds.includes(v.toLowerCase())){
        alert('이미 사용중인 아이디입니다.');
      }else{
        alert('사용 가능한 아이디입니다.');
      }
    });

    // 비밀번호 일치 확인
    const pw = document.getElementById('pw');
    const pw2 = document.getElementById('pw2');
    const pwErr = document.getElementById('pwErr');
    function checkPw(){
      if(pw2.value && pw.value !== pw2.value){
        pwErr.style.display = 'block';
      }else{
        pwErr.style.display = 'none';
      }
    }
    pw.addEventListener('input', checkPw);
    pw2.addEventListener('input', checkPw);

    // 최종 제출 유효성 검사
    document.getElementById('signupForm').addEventListener('submit', function(e){
      // 기본 입력 검증
      if(!this.checkValidity()){
        alert('필수 항목을 확인해 주세요.');
        e.preventDefault();
        return;
      }
      // 비밀번호 확인
      if(pw.value !== pw2.value){
        alert('비밀번호가 일치하지 않습니다.');
        pw2.focus();
        e.preventDefault();
        return;
      }
      // 이메일 합치기 (백엔드 없이 전송 예시)
      const local = document.getElementById('emailLocal').value.trim();
      const domain = emailDomain.value.trim();
      const email = local + '@' + domain;
      // hidden 필드 생성하여 전송
      let hidden = document.getElementById('emailFull');
      if(!hidden){
        hidden = document.createElement('input');
        hidden.type = 'hidden';
        hidden.name = 'email';
        hidden.id = 'emailFull';
        this.appendChild(hidden);
      }
      hidden.value = email;
      //console.log('submit email:', email);
    });
</script>
</body>
</html>


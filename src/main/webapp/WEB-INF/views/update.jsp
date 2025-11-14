<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- JSTL : 자바코드를 활용할 수 있게끔 만들어진 '커스텀 태그 라이브러리' --%>
<%-- JSTL사용법 1) dependency 추가 2)지시자를 이용해서 어떤 라이브러리 사용하는 것인지 명시 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>회원 정보 수정 | 추적자</title>

    <!-- Verti 기본 CSS -->
    <link rel="stylesheet" href="/assets/css/main.css" />

    <style>
        /* 페이지 전용 스타일 */
        .profile-wrap{
          min-height:100dvh;
          display:flex;
          align-items:center;
          justify-content:center;
          padding:3rem 1rem;
        }
        .profile-card{
          width:100%;
          max-width:900px;
          border-radius:10px;
        }
        .title{
          text-align:center;
          font-weight:800;
          margin-bottom:1rem;
        }
        .grid-2{
          display:grid;
          grid-template-columns:160px 1fr;
          gap:.75rem 1rem;
          align-items:center;
        }
        .grid-2 .full{ grid-column:1 / -1; }
        .row-inline{ display:flex; gap:.5rem; align-items:center; }
        .muted{ color:#777; font-size:.9em; }
        .button.full{ width:100%; }
        .error{ color:#ef4444; font-size:.9em; margin-top:.25rem; display:none; }
        .btn-row{ display:flex; gap:.5rem; }
        .btn-row .button{ flex:1; }

        @media (max-width:736px){
          .grid-2{ grid-template-columns:1fr; }
        }
    </style>
</head>
<body class="is-preload">

<!-- 공통 헤더 include -->
<div id="site-header"></div>
<script src="/assets/js/header.js"></script>

<div id="page-wrapper">
    <main class="profile-wrap">
        <section class="box profile-card" aria-labelledby="profileTitle">
            <h2 id="profileTitle" class="title">회원 정보 수정</h2>

            <!-- 실제 서비스에서는 action을 수정 처리 URL로 변경 -->
            <form id="profileForm" action="update" method="post" novalidate>
                <div class="grid-2">

                    <!-- 아이디 (숨김) -->
                    <input type="hidden" name = "UserId" value="${user.userId}"/>

                    <!-- 기존 비밀번호 (숨김 작업중) -->
                    <input type="hidden" name = "UserId1" value="${user.userId}"/>


                    <!-- 비밀번호 (선택: 변경 시에만 입력) -->
                    <label for="pw">새 비밀번호 (선택)</label>
                    <div>
                        <input type="password" id="pw" name="PasswordHash"
                               placeholder="변경할 경우만 입력 (8~20자)"
                               minlength="8" maxlength="20"
                               pattern="(?=.*[A-Za-z])(?=.*\d)(?=.*[~`!@#$%^&*()_\-+=\[\]{}|\\;:'\",./?]).{8,20}" />
                        <div class="muted">비밀번호를 변경하지 않으려면 비워두세요.</div>
                    </div>

                    <!-- 비밀번호 확인 -->
                    <label for="pw2">새 비밀번호 재확인</label>
                    <div>
                        <input type="password" id="pw2" placeholder="새 비밀번호를 다시 입력" minlength="8" maxlength="20" />
                        <div id="pwErr" class="error">비밀번호가 일치하지 않습니다.</div>
                    </div>


                    <!-- 닉네임 -->
                    <label for="nickname">닉네임</label>
                    <input type="text" id="nickname" name="Nickname" placeholder="예) 피카츄" value="${user.nickname}" required />


                    <!-- 이메일 -->
                    <label for="email">이메일</label>
                    <input type="email" id="email" name="Email" placeholder="예) user@example.com"
                           value="${user.email}" required />

                    <!-- 생년월일 (선택) -->
                    <label for="birth">생년월일</label>
                    <input type="date" id="birth" name="BirthDate" value="${user.birthDate != null ? user.birthDate : ''}" />

                    <!-- 휴대폰 (선택) -->
                    <label for="phone">핸드폰 번호</label>
                    <input type="tel" id="phone" name="Phone" placeholder="01011112222"
                           inputmode="numeric" value="${user.phone}" pattern="^01[016789]\d{7,8}$" />

                    <!-- 약관 안내 -->
                    <label>약관</label>
                    <div class="muted">
                        회원정보 수정 시 <a href="/terms.html" target="_blank">이용약관</a> 및
                        <a href="/privacy.html" target="_blank">개인정보 처리방침</a>을 다시 한 번 확인해 주세요.
                    </div>

                    <!-- 버튼 영역 -->
                    <div class="full">
                        <div class="btn-row">
                            <button type="submit" class="button icon solid fa-save">정보 수정</button>
                            <button type="button" class="button alt" id="cancelBtn">취소</button>
                        </div>
                    </div>

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
                    <li>Verti 테마 기반 커스텀</li>
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- 간단 JS: 비밀번호 확인 및 취소 버튼 동작 -->
<script>
    const pw = document.getElementById('pw');
    const pw2 = document.getElementById('pw2');
    const pwErr = document.getElementById('pwErr');

    function checkPwMatch(){
      // 둘 다 비어 있으면(변경 안 함) 에러 숨김
      if(!pw.value && !pw2.value){
        pwErr.style.display = 'none';
        return;
      }
      // 하나라도 입력되어 있으면 비교
      if(pw.value && pw2.value && pw.value !== pw2.value){
        pwErr.style.display = 'block';
      }else{
        pwErr.style.display = 'none';
      }
    }

    pw.addEventListener('input', checkPwMatch);
    pw2.addEventListener('input', checkPwMatch);

    document.getElementById('profileForm').addEventListener('submit', function(e){
      // 비밀번호 입력이 일부만 되었을 때 처리
      if(pw.value || pw2.value){
        if(pw.value.length < 8 || pw.value.length > 20){
          alert('비밀번호는 8~20자여야 합니다.');
          pw.focus();
          e.preventDefault();
          return;
        }
        if(pw.value !== pw2.value){
          alert('새 비밀번호가 일치하지 않습니다.');
          pw2.focus();
          e.preventDefault();
          return;
        }
      }

      if(!this.checkValidity()){
        alert('입력 정보를 다시 확인해 주세요.');
        e.preventDefault();
      }
    });

    // 취소 버튼: 마이페이지나 이전 페이지로 이동
    document.getElementById('cancelBtn').addEventListener('click', () => {
      // 필요에 맞게 경로 수정
      window.location.href = "/update";
    });
</script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>
</html>

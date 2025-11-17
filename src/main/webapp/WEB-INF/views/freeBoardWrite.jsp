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
  <title>자유게시판 글쓰기 | 추적자</title>

  <!-- Verti 기본 CSS -->
  <link rel="stylesheet" href="assets/css/main.css" />

  <style>
    body{
      background:#f5fafc;
    }

    .write-wrap{
      max-width:900px;
      margin:2.5rem auto 3rem;
    }

    .write-header{
      margin-bottom:1rem;
    }
    .write-header h2{
      margin:0;
      font-size:1.8rem;
      font-weight:800;
    }
    .write-header p{
      margin:.2rem 0 0;
      font-size:.9rem;
      color:#777;
    }

    .write-box{
      background:#fff;
      border-radius:16px;
      box-shadow:0 4px 12px rgba(0,0,0,.15);
      padding:1.3rem 1.4rem 1.5rem;
    }

    .form-row{
      display:flex;
      gap:.75rem;
      margin-bottom:.8rem;
      align-items:center;
      flex-wrap:wrap;
      font-size:.95rem;
    }
    .form-row label{
      width:80px;
      font-weight:700;
    }
    .form-row input[type="text"],
    .form-row select{
      flex:1;
      min-width:0;
      border-radius:6px;
      border:1px solid #ccc;
      padding:.4rem .55rem;
    }

    .form-row textarea{
      flex:1;
      min-height:220px;
      border-radius:8px;
      border:1px solid #ccc;
      padding:.6rem .7rem;
      resize:vertical;
    }

    .form-row-small{
      display:flex;
      gap:.4rem;
      margin-bottom:.4rem;
      font-size:.85rem;
      color:#666;
      align-items:center;
      flex-wrap:wrap;
    }

    .attach-row{
      display:flex;
      gap:.6rem;
      align-items:center;
      flex-wrap:wrap;
      margin-top:.3rem;
    }
    .attach-row input[type="file"]{
      font-size:.85rem;
    }

    .btn-row{
      margin-top:1.1rem;
      display:flex;
      justify-content:flex-end;
      gap:.5rem;
      flex-wrap:wrap;
    }
    .btn-row .button{
      min-width:100px;
      font-size:.95rem;
      padding:.45rem 0;
    }

    @media(max-width:736px){
      .form-row{
        flex-direction:column;
        align-items:flex-start;
      }
      .form-row label{
        width:auto;
      }
    }
  </style>
</head>
<body class="is-preload">

<div id="page-wrapper">

  <!-- 공통 헤더 include -->
  <div id="site-header"></div>
  <script src="assets/js/header.js"></script>

  <!-- 글쓰기 영역 -->
  <main class="write-wrap">
    <header class="write-header">
      <h2>자유게시판 글쓰기</h2>
      <p>축제 이야기, 후기, 공략, 질문을 자유롭게 남겨보세요.</p>
    </header>

    <section class="write-box">
      <!-- 실제 서비스에서는 action / method 수정 -->
      <form id="freeWriteForm" action="/board/free/write" method="post" enctype="multipart/form-data">

        <!-- 분류 -->
        <div class="form-row">
          <label for="category">분류</label>
          <select id="category" name="category" required>
            <option value="">선택하세요</option>
            <option value="talk">잡담</option>
            <option value="review">축제후기</option>
            <option value="tip">공략/팁</option>
            <option value="qna">질문</option>
          </select>
        </div>

        <!-- 제목 -->
        <div class="form-row">
          <label for="title">제목</label>
          <input type="text" id="title" name="title"
                 placeholder="제목을 입력하세요" required />
        </div>

        <!-- 내용 -->
        <div class="form-row" style="align-items:flex-start;">
          <label for="content">내용</label>
          <textarea id="content" name="content"
                    placeholder="내용을 작성하세요. 축제 후기, 공략, 꿀팁, 질문 등 자유롭게 적어주세요."
                    required></textarea>
        </div>

        <!-- 첨부 기능 설명 -->
        <div class="form-row-small">
          <strong>첨부하기 :</strong>
          <span>이미지 · 일정 · 지도 정보를 함께 올릴 수 있어요. (UI만 구성, 연동은 추후 구현)</span>
        </div>

        <!-- 첨부 영역 -->
        <div class="form-row">
          <label>첨부</label>
          <div>
            <div class="attach-row">
              <button type="button" class="button alt">이미지 추가</button>
              <input type="file" name="imageFile" accept="image/*" />
            </div>
            <div class="attach-row">
              <button type="button" class="button alt">캘린더 추가</button>
              <input type="date" name="eventDate" />
            </div>
            <div class="attach-row">
              <button type="button" class="button alt">지도 위치 추가</button>
              <input type="text" name="place"
                     placeholder="예) 순천만국가정원, 중앙무대 앞" />
            </div>
          </div>
        </div>

        <!-- 버튼 영역 -->
        <div class="btn-row">
          <button type="button" class="button alt"
                  onclick="history.back();">
            목록으로
          </button>
          <button type="submit" class="button">
            게시하기
          </button>
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
          <li>추적자 · 자유게시판 글쓰기</li>
        </ul>
      </div>
    </div>
  </div>
</div>

<script>
  // 아주 간단한 프론트 유효성 체크 (추가로 하고 싶을 때)
  document.getElementById('freeWriteForm').addEventListener('submit', function(e){
    const category = document.getElementById('category').value;
    const title    = document.getElementById('title').value.trim();
    const content  = document.getElementById('content').value.trim();

    if(!category){
      alert('분류를 선택하세요.');
      e.preventDefault();
      return;
    }
    if(!title){
      alert('제목을 입력하세요.');
      e.preventDefault();
      return;
    }
    if(!content){
      alert('내용을 입력하세요.');
      e.preventDefault();
      return;
    }
    // 여기서부터는 서버로 전송
  });
</script>

</body>
</html>

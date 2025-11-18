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
  <title>자유게시판 | 추적자</title>

  <!-- Verti 기본 CSS -->
  <link rel="stylesheet" href="assets/css/main.css" />

  <style>
    body {
      background:#f5fafc;
    }

    .board-wrap{
      max-width:1100px;
      margin:2.5rem auto 3rem;
    }

    .board-header{
      display:flex;
      justify-content:space-between;
      align-items:flex-end;
      gap:1rem;
      margin-bottom:1rem;
      flex-wrap:wrap;
    }

    .board-title h2{
      margin:0;
      font-size:1.8rem;
      font-weight:800;
    }
    .board-title p{
      margin:.2rem 0 0;
      font-size:.9rem;
      color:#777;
    }

    .board-tools{
      display:flex;
      gap:.5rem;
      flex-wrap:wrap;
      align-items:center;
    }
    .board-tools select,
    .board-tools input{
      border-radius:6px;
      border:1px solid #ccc;
      padding:.35rem .5rem;
      font-size:.9rem;
    }
    .board-tools input{
      min-width:160px;
    }
    .board-tools button{
      font-size:.9rem;
      padding:.35rem .8rem;
    }

    .board-box{
      background:#fff;
      border-radius:16px;
      box-shadow:0 4px 12px rgba(0,0,0,.12);
      padding:1.2rem 1.4rem 1.4rem;
    }

    .board-table{
      width:100%;
      border-collapse:collapse;
      font-size:.9rem;
    }
    .board-table thead{
      background:#404248;
      color:#fff;
    }
    .board-table th,
    .board-table td{
      padding:.55rem .6rem;
      border-bottom:1px solid #eee;
      text-align:center;
    }
    .board-table td.title{
      text-align:left;
    }

    .board-table a{
      text-decoration:none;
    }

    .board-empty{
      text-align:center;
      padding:2rem 0;
      color:#666;
      font-size:.9rem;
    }

    .board-bottom{
      margin-top:1rem;
      display:flex;
      justify-content:space-between;
      align-items:center;
      flex-wrap:wrap;
      gap:.5rem;
    }

    .pagination{
      display:flex;
      gap:.25rem;
      align-items:center;
      font-size:.85rem;
    }
    .pagination button{
      padding:.2rem .55rem;
      font-size:.8rem;
    }
    .pagination .current{
      font-weight:700;
      color:#0090c5;
    }

    .write-btn{
      min-width:100px;
    }

    @media (max-width:736px){
      .board-table thead{
        display:none;
      }
      .board-table tr{
        display:block;
        border-bottom:1px solid #eee;
        margin-bottom:.6rem;
      }
      .board-table td{
        display:block;
        text-align:left;
        border:none;
        padding:.25rem 0;
      }
      .board-table td::before{
        content:attr(data-label);
        display:inline-block;
        width:70px;
        font-weight:700;
        color:#555;
      }
    }
  </style>
</head>
<body class="is-preload">

<div id="page-wrapper">

  <!-- 공통 헤더 include -->
  <div id="site-header"></div>
  <script src="assets/js/header.js"></script>

  <!-- 자유게시판 영역 -->
  <main class="board-wrap">
    <header class="board-header">
      <div class="board-title">
        <h2>자유게시판</h2>
        <p>축제 이야기, 잡담, 질문 등 자유롭게 소통해 보세요.</p>
      </div>
      <div class="board-tools">
        <select id="categorySelect">
          <option value="all">전체</option>
          <option value="talk">잡담</option>
          <option value="review">축제후기</option>
          <option value="tip">공략/팁</option>
          <option value="qna">질문</option>
        </select>
        <input type="text" id="searchKeyword" placeholder="제목/내용/작성자 검색" />
        <button type="button" class="button alt" id="searchBtn">검색</button>
      </div>
    </header>

    <section class="board-box">

      <!-- 게시판 리스트 -->
      <table class="board-table">
        <thead>
          <tr>
            <th style="width:60px;">번호</th>
            <th style="width:90px;">분류</th>
            <th>제목</th>
            <th style="width:100px;">작성자</th>
            <th style="width:120px;">작성일</th>
            <th style="width:70px;">조회</th>
          </tr>
        </thead>
        <tbody id="boardBody">
          <c:choose>
              <%-- 게시글이 있을 때 --%>
              <c:when test="${not empty list}">
                  <c:forEach var="row" items="${list}">
                      <tr>
                          <td data-label="번호">${row.snsIdx}</td>

                          <td data-label="분류">
                              <c:choose>
                                  <c:when test="${row.category == 'talk'}">잡담</c:when>
                                  <c:when test="${row.category == 'review'}">축제후기</c:when>
                                  <c:when test="${row.category == 'tip'}">공략/팁</c:when>
                                  <c:when test="${row.category == 'qna'}">질문</c:when>
                                  <c:otherwise>기타</c:otherwise>
                              </c:choose>
                          </td>

                          <td class="title" data-label="제목">
                              <a href="/sns/view/${row.snsIdx}">
                                  ${row.snsTitle}
                              </a>
                          </td>

                          <td data-label="작성자">${row.userIdx}</td>
                          <td data-label="작성일">${row.createdAt}</td>
                          <td data-label="조회">${row.snsViews}</td>
                      </tr>
                  </c:forEach>
              </c:when>

              <%-- 게시글이 없을 때 --%>
              <c:otherwise>
                  <tr>
                      <td colspan="6" class="board-empty">
                          등록된 게시글이 없습니다. 제일 첫 글의 주인공이 되어 보세요!
                      </td>
                  </tr>
              </c:otherwise>
          </c:choose>
        </tbody>
      </table>

      <!-- 게시글 없을 때 표시 (초기엔 display:none) -->
      <div id="emptyMsg" class="board-empty" style="display:none;">
        등록된 게시글이 없습니다. 제일 첫 글의 주인공이 되어 보세요!
      </div>

      <!-- 하단 영역: 페이지네이션 + 글쓰기 -->
      <div class="board-bottom">
        <div class="pagination">
          <button type="button">&laquo;</button>
          <button type="button">&lsaquo;</button>
          <span class="current">1</span>
          <button type="button">2</button>
          <button type="button">3</button>
          <button type="button">&rsaquo;</button>
          <button type="button">&raquo;</button>
        </div>

        <button type="button" class="button write-btn"
                onclick="location.href='4_1_FreeBoardWrite.html'">
          글쓰기
        </button>
      </div>
    </section>
  </main>

  <!-- 푸터 -->
  <div id="footer-wrapper">
    <div class="container" id="footer">
      <div id="copyright">
        <ul class="menu">
          <li>&copy; 2025 RunBack</li>
          <li>추적자 · 자유게시판</li>
        </ul>
      </div>
    </div>
  </div>
</div>

<script>
  // 검색 버튼 (데모용)
  document.getElementById('searchBtn').addEventListener('click', () => {
    const cat = document.getElementById('categorySelect').value;
    const q   = document.getElementById('searchKeyword').value.trim();
    if(!q){
      alert('검색어를 입력하세요.');
      return;
    }
    alert('[' + cat + '] 범위에서 "' + q + '" 검색 기능은\n서버 연동 시 구현 예정입니다.');
  });
</script>

</body>
</html>

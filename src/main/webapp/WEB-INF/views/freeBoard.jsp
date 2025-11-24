<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>자유게시판 | 추적자</title>

  <!-- 기본 CSS -->
  <link rel="stylesheet" href="/assets/css/main.css" />

  <style>
    .board-wrap{ max-width:1100px; margin:2.5rem auto 3rem; }
    .board-header{ display:flex; justify-content:space-between; align-items:flex-end; gap:1rem; margin-bottom:1rem; flex-wrap:wrap; }
    .board-title h2{ margin:0; font-size:1.8rem; font-weight:800; }
    .board-title p{ margin:.2rem 0 0; color:#464646; }
    .board-tools{ display:flex; gap:.5rem; flex-wrap:wrap; align-items:center; }
    .board-tools select,
    .board-tools input{ border-radius:6px; border:1px solid #ccc; padding:.35rem .5rem; font-size:.9rem; }
    .board-tools input{ min-width:160px; }
    .board-tools button{ font-size:.9rem; padding:.35rem .8rem; }
    .board-box{ background:#fff; border-radius:16px; box-shadow:0 4px 12px rgba(0,0,0,.12); padding:1.2rem 1.4rem 1.4rem; }
    .board-table{ width:100%; border-collapse:collapse;  }
    <!-- font-size:.9rem; -->
    .board-table thead{ background:#404248; color:#fff; }
    .board-table th,
    .board-table td{ padding:.55rem .6rem; border-bottom:1px solid #eee; text-align:center; }
    .board-table td.title{ text-align:left; }
    .board-table a{ text-decoration:none; font-weight: bold;}
    .board-empty{ text-align:center; padding:2rem 0; color:#666; font-size:.9rem; }
    .board-bottom{ margin-top:1rem; display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:.5rem; }
    .pagination{ display:flex; gap:.25rem; align-items:center; font-size:.85rem; }
    .pagination button{ padding:.2rem .55rem; font-size:.8rem; }
    .pagination .current{ font-weight:700; color:#0090c5; }
    .write-btn{ min-width:100px; }

    @media (max-width:736px){
      .board-table thead{ display:none; }
      .board-table tr{ display:block; border-bottom:1px solid #eee; margin-bottom:.6rem; }
      .board-table td{ display:block; text-align:left; border:none; padding:.25rem 0; }
      .board-table td::before{ content:attr(data-label); display:inline-block; width:70px; font-weight:700; color:#555; }
    }
  </style>
</head>
<body class="is-preload">

<div id="page-wrapper">

  <!-- 공통 헤더 include -->
  <div id="site-header"></div>
  <script src="/assets/js/header.js"></script>

  <!-- 자유게시판 영역 -->
  <main class="board-wrap">
    <header class="board-header">
      <div class="board-title">
        <h2>자유게시판</h2>
        <p>축제 이야기, 잡담, 질문 등 자유롭게 소통해 보세요.</p>
      </div>
      <div class="board-tools">
        <select id="categorySelect">
          <option value="전체">전체</option>
          <option value="잡담">잡담</option>
          <option value="축제후기">축제후기</option>
          <option value="공략/팁">공략/팁</option>
          <option value="질문">질문</option>
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
            <c:when test="${not empty list}">
              <c:forEach var="row" items="${list}">
                <tr>
                  <td data-label="번호">${row.snsIdx}</td>
                  <td data-label="분류">
                    <c:choose>
                      <c:when test="${row.category == '잡담'}">잡담</c:when>
                      <c:when test="${row.category == '축제후기'}">축제후기</c:when>
                      <c:when test="${row.category == '공략/팁'}">공략/팁</c:when>
                      <c:when test="${row.category == '질문'}">질문</c:when>
                      <c:otherwise>기타</c:otherwise>
                    </c:choose>
                  </td>
                  <td class="title" data-label="제목">
                    <a href="/sns/view/${row.snsIdx}">
                      ${row.snsTitle}
                    </a>
                  </td>
                  <td data-label="작성자">${row.userNickname}</td>
                  <td data-label="작성일">
                    <fmt:parseDate value="${row.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate" />
                    <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd" />
                  </td>
                  <td data-label="조회">${row.snsViews}</td>
                </tr>
              </c:forEach>
            </c:when>
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

      <!-- 하단 영역 (페이징) -->
      <div class="board-bottom">
        <div class="pagination">
          <a href="?page=1"><button type="button">&laquo;</button></a>
          <c:choose>
            <c:when test="${currentPage > 1}">
              <a href="?page=${currentPage - 1}"><button type="button">&lsaquo;</button></a>
            </c:when>
            <c:otherwise>
              <button type="button" disabled>&lsaquo;</button>
            </c:otherwise>
          </c:choose>
          <c:forEach var="i" begin="1" end="${totalPage}">
            <c:choose>
              <c:when test="${currentPage == i}">
                <span class="current">${i}</span>
              </c:when>
              <c:otherwise>
                <a href="?page=${i}"><button type="button">${i}</button></a>
              </c:otherwise>
            </c:choose>
          </c:forEach>
          <c:choose>
            <c:when test="${currentPage < totalPage}">
              <a href="?page=${currentPage + 1}"><button type="button">&rsaquo;</button></a>
            </c:when>
            <c:otherwise>
              <button type="button" disabled>&rsaquo;</button>
            </c:otherwise>
          </c:choose>
          <a href="?page=${totalPage}"><button type="button">&raquo;</button></a>
        </div>
        <button type="button" class="button write-btn" onclick="location.href='/sns/write'">글쓰기</button>
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
document.getElementById('searchBtn').addEventListener('click', () => {
  const category = document.getElementById('categorySelect').value;
  const keyword = document.getElementById('searchKeyword').value.trim();

  const params = new URLSearchParams();

  // category가 전체가 아니면 URL에 추가
  if(category && category !== '전체') {
    params.append('category', category);
  }

  // keyword가 비어 있지 않으면 q 파라미터 추가
  if(keyword) {
    params.append('q', keyword);
  }

  // 페이지 1로 이동
  window.location.href = '/sns?' + params.toString();
});
</script>
</body>
</html>
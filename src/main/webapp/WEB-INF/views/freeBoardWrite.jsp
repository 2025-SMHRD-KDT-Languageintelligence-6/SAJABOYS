<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>자유게시판 글쓰기 | 추적자</title>

  <link rel="stylesheet" href="/assets/css/main.css" />

  <style>
    .write-wrap { max-width: 900px; margin: 2.5rem auto 3rem; }
    .write-header { margin-bottom: 1rem; }
    .write-header h2 { margin: 0; font-size: 1.8rem; font-weight: 800; }
    .write-header p { margin: .2rem 0 0; font-size: .9rem; color: #777; }
    .write-box { background: #fff; border-radius: 16px; box-shadow: 0 4px 12px rgba(0, 0, 0, .15); padding: 1.3rem 1.4rem 1.5rem; }
    .form-row { display: flex; gap: .75rem; margin-bottom: .8rem; align-items: center; flex-wrap: wrap; font-size: .95rem; }
    .form-row label { width: 80px; font-weight: 700; }
    .form-row input[type="text"], .form-row select { flex: 1; min-width: 0; border-radius: 6px; border: 1px solid #ccc; padding: .4rem .55rem; }
    .form-row textarea { flex: 1; min-height: 220px; border-radius: 8px; border: 1px solid #ccc; padding: .6rem .7rem; resize: vertical; }
    .form-row-small { display: flex; gap: .4rem; margin-bottom: .4rem; font-size: .85rem; color: #666; align-items: center; flex-wrap: wrap; }
    .attach-row { display: flex; gap: .6rem; align-items: center; flex-wrap: wrap; margin-top: .3rem; }
    .file-preview { margin-top: 1rem; display: flex; gap: 10px; flex-wrap: wrap; }
    .file-preview img { width: 100px; height: 100px; object-fit: cover; border-radius: 8px; position: relative; }
    .file-preview .remove-btn { position: absolute; top: 5px; right: 5px; background-color: rgba(0,0,0,0.5); color: white; border: none; border-radius: 50%; width: 20px; height: 20px; text-align: center; cursor: pointer; }
    .btn-row { margin-top: 1.1rem; display: flex; justify-content: flex-end; gap: .5rem; flex-wrap: wrap; }
    .btn-row .button { min-width: 100px; font-size: .95rem; padding:.45rem 0; }
    @media (max-width: 736px) {
      .form-row { flex-direction: column; align-items: flex-start; }
      .form-row label { width: auto; }
    }
  </style>
</head>
<body class="is-preload">

<%
  boolean isEdit = (request.getAttribute("sns") != null);
%>
<c:set var="isEdit" value="<%=isEdit%>" />

<div id="page-wrapper">
  <div id="site-header"></div>
  <script src="assets/js/header.js"></script>

  <main class="write-wrap">
    <header class="write-header">
      <h2>자유게시판 <c:choose><c:when test="${isEdit}">수정</c:when><c:otherwise>글쓰기</c:otherwise></c:choose></h2>
      <p>축제 이야기, 후기, 공략, 질문을 자유롭게 남겨보세요.</p>
    </header>

    <section class="write-box">
      <form id="freeWriteForm" action="/sns/write" method="post" enctype="multipart/form-data">

        <!-- 글 idx (수정일 때만) -->
        <input type="hidden" name="snsIdx" value="${isEdit ? sns.snsIdx : 0}" />

        <!-- 작성자 ID -->
        <input type="hidden" name="userIdx" value="${sessionScope.user.userIdx}" />

        <!-- 분류 -->
        <div class="form-row">
          <label for="category">분류</label>
          <select id="category" name="category" required>
            <option value="">선택하세요</option>
            <option value="잡담" ${isEdit && sns.category=='잡담'?'selected':''}>잡담</option>
            <option value="축제후기" ${isEdit && sns.category=='축제후기'?'selected':''}>축제후기</option>
            <option value="공략/팁" ${isEdit && sns.category=='공략/팁'?'selected':''}>공략/팁</option>
            <option value="질문" ${isEdit && sns.category=='질문'?'selected':''}>질문</option>
          </select>
        </div>

        <!-- 제목 -->
        <div class="form-row">
          <label for="title">제목</label>
          <input type="text" id="title" name="snsTitle" placeholder="제목을 입력하세요"
                 value="${isEdit ? sns.snsTitle : ''}" required />
        </div>

        <!-- 내용 -->
        <div class="form-row" style="align-items:flex-start;">
          <label for="content">내용</label>
          <textarea id="content" name="snsContent" placeholder="내용을 작성하세요." required>${isEdit ? sns.snsContent : ''}</textarea>
        </div>

        <!-- 첨부 설명 -->
        <div class="form-row-small">
          <strong>첨부하기 :</strong>
          <span>이미지 · 일정 · 지도 정보를 함께 올릴 수 있어요.</span>
        </div>

        <!-- 첨부 버튼 -->
        <div class="form-row">
          <label>첨부</label>
          <div class="attach-row">
            <button type="button" class="button alt" id="addImageButton">이미지 추가</button>
          </div>
        </div>

        <!-- 기존 첨부 파일 미리보기 -->
        <div class="file-preview" id="filePreview">
          <c:if test="${isEdit && not empty sns.fileList}">
            <c:forEach var="file" items="${sns.fileList}">
              <div style="position: relative;">
                <img src="/upload/${file.filePath}" alt="${file.fileName}" />
                <button type="button" class="remove-btn" onclick="this.parentElement.remove()">X</button>
              </div>
            </c:forEach>
          </c:if>
        </div>

        <!-- 버튼 -->
        <div class="btn-row">
          <button type="button" class="button alt" onclick="history.back();">목록으로</button>
          <button type="submit" class="button">
            <c:choose><c:when test="${isEdit}">수정하기</c:when><c:otherwise>게시하기</c:otherwise></c:choose>
          </button>
        </div>

      </form>
    </section>
  </main>

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
  // 이미지 추가
  document.getElementById('addImageButton').addEventListener('click', function() {
    const input = document.createElement('input');
    input.type = 'file';
    input.name = 'files';
    input.accept = 'image/*';
    input.style.display = 'none';

    input.addEventListener('change', function(event) {
      const files = event.target.files;
      const previewContainer = document.getElementById('filePreview');

      for (let i=0; i<files.length; i++){
        const file = files[i];
        const reader = new FileReader();
        reader.onload = function(e){
          const div = document.createElement('div');
          div.style.position = 'relative';

          const img = document.createElement('img');
          img.src = e.target.result;
          div.appendChild(img);

          const removeButton = document.createElement('button');
          removeButton.textContent = 'X';
          removeButton.type = 'button';
          removeButton.classList.add('remove-btn');
          removeButton.onclick = function(){ div.remove(); }
          div.appendChild(removeButton);

          previewContainer.appendChild(div);
        };
        reader.readAsDataURL(file);
      }
    });

    document.querySelector('.attach-row').appendChild(input);
    input.click();
  });
</script>

</body>
</html>

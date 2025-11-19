<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>자유게시판 글보기 | 추적자</title>

    <!-- Verti 기본 CSS -->
    <link rel="stylesheet" href="assets/css/main.css" />

    <style>
        body { background:#f5fafc; }
        .view-wrap { max-width:900px; margin:2.5rem auto 3rem; }
        .view-header { margin-bottom:1rem; }
        .view-header h2 { margin:0; font-size:1.8rem; font-weight:800; }
        .view-header p { margin:.2rem 0 0; font-size:.9rem; color:#777; }
        .view-box { background:#fff; border-radius:18px; box-shadow:0 4px 14px rgba(0,0,0,.12); padding:1.5rem 1.6rem 1.3rem; }
        .post-top { border-bottom:1px solid #e3e8ef; padding-bottom:.8rem; margin-bottom:1rem; }
        .post-title { font-size:1.4rem; font-weight:800; margin-bottom:.4rem; word-break:keep-all; }
        .post-meta-row { display:flex; justify-content:space-between; flex-wrap:wrap; font-size:.85rem; color:#666; gap:.4rem; }
        .post-meta-left span, .post-meta-right span { margin-right:.6rem; }
        .tag-badge { display:inline-block; padding:.15rem .5rem; border-radius:999px; background:#e1f3ff; color:#0076b6; font-size:.8rem; margin-right:.4rem; }
        .post-content { min-height:160px; line-height:1.7; font-size:.95rem; color:#333; white-space:pre-line; margin-bottom:1rem; }
        .attach-area { border-top:1px dashed #dde3ec; padding-top:.7rem; font-size:.85rem; color:#555; }
        .attach-area strong { margin-right:.4rem; }
        .attach-area a { text-decoration:underline; }
        .view-btn-row { margin-top:1.2rem; display:flex; justify-content:flex-end; gap:.4rem; flex-wrap:wrap; }
        .view-btn-row .button { min-width:90px; font-size:.9rem; padding:.45rem 0; }
        /* 댓글 영역 */
                .comment-wrap{
                  margin-top:2rem;
                  background:#fff;
                  border-radius:16px;
                  box-shadow:0 4px 14px rgba(0,0,0,.08);
                  padding:1.2rem 1.4rem 1.4rem;
                }
                .comment-header{
                  display:flex;
                  justify-content:space-between;
                  align-items:center;
                  margin-bottom:.8rem;
                  font-size:.95rem;
                }
                .comment-header h3{
                  margin:0;
                  font-size:1.1rem;
                  font-weight:800;
                }
                .comment-header span{
                  font-size:.85rem;
                  color:#666;
                }

                .comment-list{
                  margin-bottom:1rem;
                  max-height:260px;
                  overflow-y:auto;
                }

                .comment-item{
                  border-bottom:1px solid #e9edf3;
                  padding:.55rem 0;
                  font-size:.9rem;
                }
                .comment-meta{
                  display:flex;
                  justify-content:space-between;
                  margin-bottom:.15rem;
                  color:#666;
                  font-size:.8rem;
                }
                .comment-author{
                  font-weight:700;
                }
                .comment-body{
                  color:#333;
                  white-space:pre-line;
                }

                .comment-form{
                  border-top:1px solid #dde3ec;
                  padding-top:.7rem;
                }

                .comment-form-row{
                  display:flex;
                  gap:.5rem;
                  flex-wrap:wrap;
                }
                .comment-form-row textarea{
                  flex:1;
                  min-height:70px;
                  border-radius:8px;
                  border:1px solid #ccc;
                  padding:.5rem .6rem;
                  resize:vertical;
                  font-size:.9rem;
                }
                .comment-form-row .button{
                  min-width:90px;
                  height:40px;
                  align-self:flex-end;
                  font-size:.9rem;
                  padding:0;
                }

                @media (max-width:736px){
                  .post-meta-row{
                    flex-direction:column;
                    align-items:flex-start;
                  }
                  .comment-form-row{
                    flex-direction:column;
                  }
                  .comment-form-row .button{
                    width:100%;
                    height:42px;
                  }
                }
    </style>
</head>
<body class="is-preload">

<div id="page-wrapper">

    <!-- 공통 헤더 include -->
    <div id="site-header"></div>
    <script src="assets/js/header.js"></script>

    <main class="view-wrap">

        <!-- 상단 설명 -->
        <header class="view-header">
            <h2>자유게시판</h2>
            <p>축제, 게임, 일상 등 어떤 이야기든 자유롭게 나눠보세요.</p>
        </header>

        <!-- 글 상세 박스 -->
        <section class="view-box">

            <!-- 제목 + 메타 정보 -->
            <div class="post-top">
                <div class="post-title">${sns.snsTitle}</div>
                <div style="margin-bottom:.3rem;">
                    <span class="tag-badge">${sns.category}</span>
                </div>

                <div class="post-meta-row">
                    <div class="post-meta-left">
                        <span>작성자 : <strong>${sns.userNickname}</strong></span>
                        <span>분류 : ${sns.category}</span>
                    </div>
                    <div class="post-meta-right">
                        <span>작성일 : ${sns.createdAt}</span>
                        <span>조회수 : ${sns.snsViews}</span>
                    </div>
                </div>
            </div>

            <!-- 본문 내용 -->
            <div class="post-content">
                ${sns.snsContent}

                <!-- 첨부 파일 영역: 이미지가 본문에 삽입되도록 -->
                <c:if test="${not empty sns.fileList}">
                    <p><strong>첨부 이미지:</strong></p>
                    <c:forEach var="file" items="${sns.fileList}">
                        <c:if test="${fn:contains(file.fileName, '.jpg') || fn:contains(file.fileName, '.jpeg') || fn:contains(file.fileName, '.png') || fn:contains(file.fileName, '.gif')}">
                            <!-- 이미지 파일일 경우 본문에 삽입 -->
                            <img src="/upload/${file.filePath}" alt="${file.fileName}" style="max-width:100%; height:auto; margin-top:10px;">
                        </c:if>
                    </c:forEach>
                </c:if>
            </div>

            <!-- 첨부 파일 영역 -->
            <div class="attach-area">
                <c:if test="${not empty sns.fileList}">
                    <p><strong>첨부 파일 :</strong></p>
                    <ul>
                        <c:forEach var="file" items="${sns.fileList}">
                            <li>
                                <a href="/upload/${file.filePath}" target="_blank">
                                    ${file.fileName}
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </c:if>
                <c:if test="${empty sns.fileList}">
                    <p>첨부 파일이 없습니다.</p>
                </c:if>
            </div>

            <!-- 하단 버튼들 -->
            <div class="view-btn-row">
                <button type="button" class="button alt" onclick="location.href='/sns'">목록</button>

                <!-- 로그인한 사용자가 글 작성자인 경우에만 수정/삭제 버튼 표시 -->
                <c:if test="${not empty sessionScope.user and sessionScope.user.userIdx == sns.userIdx}">
                    <!-- 수정 버튼 -->
                    <button type="button" class="button alt"
                            onclick="location.href='/sns/write?snsIdx=${sns.snsIdx}'">수정</button>

                    <!-- 삭제 버튼 -->
                    <form action="/sns/delete/${sns.snsIdx}" method="post" style="display:inline;">
                        <button type="submit" class="button alt"
                                onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
                    </form>
                </c:if>
            </div>
            </section>
            <!-- 댓글 영역 -->
                <section class="comment-wrap">
                    <div class="comment-header">
                        <h3>댓글</h3>
                        <span>총 <strong>3</strong>개</span>
                    </div>

                    <!-- 댓글 리스트 -->
                    <div class="comment-list">

                        <div class="comment-item">
                            <div class="comment-meta">
                                <div>
                                    <span class="comment-author">루피</span> · <span>2025-11-14 13:45</span>
                                </div>
                                <div>좋아요 2</div>
                            </div>
                            <div class="comment-body">
                                저도 오늘 축제 가요!
                                3시 입구 쪽에서 만나면 될까요?
                            </div>
                        </div>

                        <div class="comment-item">
                            <div class="comment-meta">
                                <div>
                                    <span class="comment-author">조로</span> · <span>2025-11-14 14:02</span>
                                </div>
                                <div>좋아요 1</div>
                            </div>
                            <div class="comment-body">
                                거점 탐험전은 처음인데 같이 해도 되나요? 😅
                            </div>
                        </div>

                        <div class="comment-item">
                            <div class="comment-meta">
                                <div>
                                    <span class="comment-author">나미</span> · <span>2025-11-14 14:10</span>
                                </div>
                                <div>좋아요 0</div>
                            </div>
                            <div class="comment-body">
                                오늘 바람 좀 불어요. 따뜻하게 입고 오세요!
                            </div>
                        </div>

                    </div>

                    <!-- 댓글 작성 -->
                    <div class="comment-form">
                        <div class="comment-form-row">
                            <textarea id="commentText" placeholder="댓글을 입력하세요. 예) 오늘 몇 시에 만날까요?"></textarea>
                            <button type="button" class="button" id="commentSubmit">등록</button>
                        </div>
                    </div>
                </section>


    </main>

    <!-- 푸터 -->
    <div id="footer-wrapper">
        <div class="container" id="footer">
            <div id="copyright">
                <ul class="menu">
                    <li>&copy; 2025 RunBack</li>
                    <li>추적자 · 자유게시판 글보기</li>
                </ul>
            </div>
        </div>
    </div>
</div>

<script>
    // 댓글 등록 (데모용)
    document.getElementById('commentSubmit').addEventListener('click', function(){
        const text = document.getElementById('commentText').value.trim();
        if(!text){
            alert('댓글을 입력하세요.');
            return;
        }
        alert('댓글이 등록되었습니다! (실제 저장은 서버 연동 후 구현)');
        document.getElementById('commentText').value = '';
    });
</script>

</body>
</html>

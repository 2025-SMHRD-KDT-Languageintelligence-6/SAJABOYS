<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>자유게시판 글보기 | 추적자</title>
    <link rel="stylesheet" href="/assets/css/main.css" />

    <style>
        /* (생략: CSS 스타일은 유지) */
        :root {
            --indent-unit-pc: 40px;
            --indent-unit-mobile: 20px;
            --base-padding: 10px;
        }

        .view-wrap { max-width:900px; margin:2.5rem auto 3rem; }
        .view-header { margin-bottom:1rem; }
        .view-header h2 { margin:0; font-size:1.8rem; font-weight:800; }
        .view-header p { margin:.2rem 0 0; font-size:.9rem; color:#777; }
        .view-box { background:#fff; border-radius:18px; box-shadow:0 4px 14px rgba(0,0,0,.12); padding:1.5rem 1.6rem 1.3rem; }
        .post-top { border-bottom:1px solid #e3e8ef; padding-bottom:.8rem; margin-bottom:1rem; }
        .post-title { font-size:1.4rem; font-weight:800; margin-bottom:.4rem; word-break:keep-all; }
        .post-meta-row { display:flex; justify-content:space-between; flex-wrap:wrap; font-size:.85rem; color:#666; gap:.4rem; }
        .post-meta-left span, .post-meta-right span { margin-right:.6rem; }

        .tag-badge.chat { background: #d4f7d4; color: #2d7a2d; }
        .tag-badge.festival { background: #ffe0e0; color: #b60000; }
        .tag-badge.tips { background: #e0f7ff; color: #0076b6; }
        .tag-badge.question { background: #fff4d1; color: #b66d00; }
        .tag-badge { display:inline-block; padding:.15rem .5rem; border-radius:999px; font-size:.8rem; margin-right:.4rem; }

        .post-content { min-height:160px; line-height:1.7; font-size:.95rem; color:#333; white-space:pre-line; margin-bottom:1rem; }
        .attach-area { border-top:1px dashed #dde3ec; padding-top:.7rem; font-size:.85rem; color:#555; }
        .attach-area strong { margin-right:.4rem; }
        .attach-area a { text-decoration:underline; }
        .view-btn-row { margin-top:1.2rem; display:flex; justify-content:flex-end; gap:.4rem; flex-wrap:wrap; }
        .view-btn-row .button { min-width:90px; font-size:.9rem; padding:.45rem 0; }

        /* 댓글 & 대댓글 */
        .comment-wrap { margin-top:2rem; background:#fff; border-radius:16px; box-shadow:0 4px 14px rgba(0,0,0,.08); padding:1.2rem 1.4rem 1.4rem; }
        .comment-header { display:flex; justify-content:space-between; align-items:center; margin-bottom:.8rem; font-size:.95rem; }
        .comment-header h3 { margin:0; font-size:1.1rem; font-weight:800; }
        .comment-header span { font-size:.85rem; color:#666; }

        .comment-list { margin-bottom:1rem; max-height:400px; overflow-y:auto; }

        /* 댓글 기본 스타일 */
        .comment-item {
            padding: .55rem 0;
            border-bottom:1px solid #e9edf3;
            font-size:.9rem;
            position: relative;
            transition: all 0.3s ease;
            padding-left: var(--base-padding);
        }

        /* 대댓글 시각적 구분 - 배경색만 남김 */
        .comment-item.reply-item {
            background-color: #f8fafd;
            border-radius: 6px;
        }

        /* 무제한 레벨 들여쓰기 */
        .comment-item[data-level] {
            padding-left: calc(var(--base-padding) + (var(--indent-unit-pc) * var(--data-level, 0)));
        }

        /* 댓글 메타 및 작성일/답글 버튼 위치 수정 */
        .comment-meta {
            display:flex;
            justify-content:space-between;
            align-items: flex-start;
            margin-bottom:.15rem;
            color:#666;
            font-size:.8rem;
        }

        .comment-meta-right {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            position: absolute;
            right: 0;
            top: 0.55rem;
            font-size: 0.8rem;
            line-height: 1.2;
        }

        /* 작성자 스타일 */
        .comment-author {
            font-weight:700;
            color:#0076b6;
        }

        /* 작성일 (dateSpan) 스타일 */
        .comment-date {
            color:#666;
            margin-right: 10px;
        }

        /* 답글 버튼 (replyBtn) 스타일 */
        .reply-btn {
            cursor:pointer;
            color:#0076b6;
            font-size:0.85rem;
            margin-top: 5px;
            margin-right: 10px;
            user-select:none;
        }
        .reply-btn:hover {
            text-decoration: underline;
        }

        /* 삭제 버튼 스타일 */
        .delete-btn {
            cursor: pointer;
            color: #b60000;
            font-size: 0.85rem;
            margin-top: 5px;
            margin-right: 10px;
            margin-left: 10px;
            user-select: none;
        }
        .delete-btn:hover {
            text-decoration: underline;
        }

        .comment-body {
            color:#333;
            white-space:pre-line;
            word-break: break-word;
        }

        /* 댓글 작성 폼 (생략: 변경 없음) */
        .comment-form {
            border-top:1px solid #dde3ec;
            padding-top:.7rem;
        }
        .comment-form-row {
            display:flex;
            gap:.5rem;
            flex-wrap:wrap;
        }
        .comment-form-row textarea {
            flex:1;
            min-height:70px;
            border-radius:8px;
            border:1px solid #ccc;
            padding:.5rem .6rem;
            resize:vertical;
            font-size:.9rem;
            font-family: inherit;
        }
        .comment-form-row .button {
            min-width:90px;
            height:40px;
            align-self:flex-end;
            font-size:.9rem;
            padding:0;
            background:#0076b6;
            color:#fff;
            border:none;
            border-radius: 6px;
            transition: background-color 0.3s ease;
        }
        .comment-form-row .button:hover {
            background:#005a91;
        }

        /* 반응형 */
        @media (max-width:736px){
            .post-meta-row{ flex-direction:column; align-items:flex-start; }
            .comment-form-row{ flex-direction:column; }
            .comment-form-row .button{ width:100%; height:42px; }

            /* 모바일 환경에서 들여쓰기 조정 */
            .comment-item[data-level] {
                padding-left: calc(var(--base-padding) + (var(--indent-unit-mobile) * var(--data-level, 0)));
            }
        }
    </style>
</head>
<body class="is-preload">

<div id="page-wrapper">

    <div id="site-header"></div>
    <script src="/assets/js/header.js"></script>

    <main class="view-wrap">
        <header class="view-header">
            <h2>자유게시판</h2>
            <p>축제, 게임, 일상 등 어떤 이야기든 자유롭게 나눠보세요.</p>
        </header>

        <section class="view-box">
            <div class="post-top">
                <div class="post-title">${sns.snsTitle}</div>
                <div style="margin-bottom:.3rem;">
                    <c:set var="categoryClass">
                        <c:choose>
                            <c:when test="${sns.category == '잡담'}">chat</c:when>
                            <c:when test="${sns.category == '축제후기'}">festival</c:when>
                            <c:when test="${sns.category == '공략/팁'}">tips</c:when>
                            <c:when test="${sns.category == '질문'}">question</c:when>
                            <c:otherwise>chat</c:otherwise>
                        </c:choose>
                    </c:set>
                    <span class="tag-badge ${categoryClass}">${sns.category}</span>
                </div>

                <div class="post-meta-row">
                    <div class="post-meta-left">
                        <span>작성자 : <strong>${sns.userNickname}</strong></span>
                    </div>
                    <div class="post-meta-right">
                        <span>작성일 : ${sns.createdAt}</span>
                        <span>조회수 : ${sns.snsViews}</span>
                    </div>
                </div>
            </div>

            <div class="post-content">${sns.snsContent}</div>

            <c:if test="${not empty sns.fileList}">
                <div class="attach-area">
                    <p><strong>첨부 이미지:</strong></p>
                    <c:forEach var="file" items="${sns.fileList}">
                        <c:if test="${fn:contains(file.fileName, '.jpg') or fn:contains(file.fileName, '.jpeg') or fn:contains(file.fileName, '.png') or fn:contains(file.fileName, '.gif')}">
                            <img src="/upload/${file.filePath}" alt="${file.fileName}" style="max-width:100%; height:auto; margin-top:10px;">
                        </c:if>
                    </c:forEach>
                </div>

                <div class="attach-area">
                    <p><strong>첨부 파일 :</strong></p>
                    <ul>
                        <c:forEach var="file" items="${sns.fileList}">
                            <li><a href="/upload/${file.filePath}" target="_blank">${file.fileName}</a></li>
                        </c:forEach>
                    </ul>
                </div>
            </c:if>

            <div class="view-btn-row">
                <button type="button" class="button alt" onclick="location.href='/sns'">목록</button>
                <c:if test="${not empty sessionScope.user and sessionScope.user.userIdx == sns.userIdx}">
                    <button type="button" class="button alt" onclick="location.href='/sns/write?snsIdx=${sns.snsIdx}'">수정</button>
                    <form action="/sns/delete/${sns.snsIdx}" method="post" style="display:inline;">
                        <button type="submit" class="button alt" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
                    </form>
                </c:if>
            </div>
        </section>
        <section class="comment-wrap">
            <div class="comment-header">
                <h3>댓글</h3>
                <span>총 <strong id="commentCount">0</strong>개</span>
            </div>

            <div class="comment-list" id="commentList"></div>

            <c:if test="${not empty sessionScope.user}">
                <div class="comment-form">
                    <div class="comment-form-row">
                        <textarea id="commentText" placeholder="댓글을 입력하세요. (답글을 달 때는 맨션 @작성자 를 포함해주세요)"></textarea>
                        <button type="button" class="button" id="commentSubmit">등록</button>
                    </div>
                </div>
            </c:if>
            <c:if test="${empty sessionScope.user}">
                <p style="margin-top:0.5rem; color:#666;">댓글 작성은 로그인 후 가능합니다.</p>
            </c:if>
        </section>
    </main>

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
const snsIdx = ${sns.snsIdx};
// 🚨🚨🚨 EL 안정성 확보를 위해 String으로 받은 후 JavaScript에서 Number로 변환합니다.
// 세션이 없으면 '0'을 출력합니다.
const sessionUserIdx = '${not empty sessionScope.user ? sessionScope.user.userIdx : 0}';
const sessionUser = Number(sessionUserIdx); // 숫자로 변환하여 비교에 사용

// 댓글 삭제 함수
function deleteComment(commentIdx) {

    var deleteUrl = "/comment/delete/" + commentIdx;

    if (!confirm('정말 이 댓글을 삭제하시겠습니까?')) {
        return;
    }

    fetch(deleteUrl, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
    })
    .then(res => res.text())
    .then(result => {
        if (result === 'success') {
            alert('댓글이 삭제되었습니다.');
            loadComments(); // 댓글 목록 새로고침
        } else {
            alert('댓글 삭제에 실패했습니다. 서버 응답을 확인하세요.');
            console.error('댓글 삭제 실패 응답:', result);
        }
    })
    .catch(error => {
        console.error('댓글 삭제 요청 중 오류 발생:', error);
        alert('댓글 삭제 중 통신 오류가 발생했습니다.');
    });
}


// 댓글 렌더링 함수 (수정됨: 삭제 댓글 처리 로직 추가)
function renderComment(c, parentElement, level = 0) {
    const div = document.createElement('div');
    div.className = 'comment-item';

    const currentLevel = parseInt(level) || 0;
    div.dataset.level = currentLevel;
    div.style.setProperty('--data-level', currentLevel);

    if(currentLevel > 0) {
        div.classList.add('reply-item');
        if (currentLevel >= 1) {
            const levelClass = currentLevel;
            div.classList.add('reply-level-' + levelClass);
        }
    }

    const metaDiv = document.createElement('div');
    metaDiv.className = 'comment-meta';

    // ------------------------------------------------------------------
    // 🚨🚨🚨 삭제된 댓글 처리 로직 시작
    // c.isDeleted 필드나 commentContent가 비어있으면 삭제된 것으로 간주합니다.
    const isCommentDeleted = c.isDeleted === true || !c.commentContent;

    if (isCommentDeleted) {
        // 1. 작성자 및 메타 정보
        const authorWrapper = document.createElement('span');
        authorWrapper.className = 'comment-author-wrapper';
        const authorSpan = document.createElement('span');
        authorSpan.className = 'comment-author';
        authorSpan.textContent = (currentLevel > 0 ? '↳ ' : '') + '삭제됨';
        authorWrapper.appendChild(authorSpan);

        const rightMetaDiv = document.createElement('div');
        rightMetaDiv.className = 'comment-meta-right';

        metaDiv.appendChild(authorWrapper);
        metaDiv.appendChild(rightMetaDiv);
        div.appendChild(metaDiv);


        // 2. 본문 내용 대신 '삭제된 댓글입니다.' 표시
        const bodyDiv = document.createElement('div');
        bodyDiv.className = 'comment-body';
        bodyDiv.style.color = '#777';
        bodyDiv.style.fontStyle = 'italic';
        bodyDiv.textContent = '삭제된 댓글입니다.';
        div.appendChild(bodyDiv);

        parentElement.appendChild(div);

        // 자식 댓글만 재귀 호출하여 구조를 유지합니다.
        if(c.children && c.children.length > 0) {
            c.children.forEach(child => renderComment(child, parentElement, currentLevel + 1));
        }
        return; // 현재 댓글 처리를 여기서 종료 (답글/삭제 버튼 생성 방지)
    }
    // 🚨🚨🚨 삭제된 댓글 처리 로직 끝
    // ------------------------------------------------------------------

    // 1. 삭제되지 않은 댓글의 메타 정보
    const authorWrapper = document.createElement('span');
    authorWrapper.className = 'comment-author-wrapper';

    const authorSpan = document.createElement('span');
    authorSpan.className = 'comment-author';

    const displayName = c.userNickname || '익명';
    authorSpan.textContent = (currentLevel > 0 ? '↳ ' : '') + displayName;

    authorWrapper.appendChild(authorSpan);


    const rightMetaDiv = document.createElement('div');
    rightMetaDiv.className = 'comment-meta-right';

    const dateSpan = document.createElement('span');
    dateSpan.className = 'comment-date';
    dateSpan.textContent = c.createdAt || '';

    rightMetaDiv.appendChild(dateSpan);


    // 2. 답글 버튼 & 삭제 버튼
    if(sessionUser > 0) { // sessionUser가 0보다 클 때만 (로그인 상태)
        // 답글 버튼
        const replyBtn = document.createElement('span');
        replyBtn.className = 'reply-btn';
        replyBtn.dataset.idx = c.commentIdx;
        const replyTargetNickname = c.userNickname;

        if (replyTargetNickname) {
            replyBtn.dataset.nickname = replyTargetNickname;
        }

        replyBtn.textContent = '답글';
        replyBtn.addEventListener('click', () => {
            const parentInput = document.getElementById('commentText');
            let targetNickname = replyBtn.dataset.nickname;

            if (targetNickname) {
                const cleanNickname = String(targetNickname).replace(/\s/g, '').trim();
                if (cleanNickname) {
                    parentInput.value = '@' + cleanNickname + ' ';
                    parentInput.dataset.parent = c.commentIdx;
                } else {
                    parentInput.value = '';
                    alert("답글 대상 닉네임이 유효하지 않아 맨션 기능을 사용할 수 없습니다. 답글 내용은 직접 입력해주세요.");
                    parentInput.dataset.parent = c.commentIdx;
                }
            } else {
                parentInput.value = '';
                alert("해당 댓글은 '익명'으로 작성되어 맨션 기능을 사용할 수 없습니다. 답글 내용은 직접 입력해주세요.");
                parentInput.dataset.parent = c.commentIdx;
            }
            parentInput.focus();
        });
        rightMetaDiv.appendChild(replyBtn);

        // 삭제 버튼 로직 추가 (본인이 작성한 댓글일 경우만 표시)
        if (sessionUser === c.userIdx) {
            const deleteBtn = document.createElement('span');
            deleteBtn.className = 'delete-btn';
            deleteBtn.dataset.idx = c.commentIdx;
            deleteBtn.textContent = '삭제';
            deleteBtn.addEventListener('click', () => {
                 deleteComment(c.commentIdx);
            });
            rightMetaDiv.appendChild(deleteBtn);
        }
    }


    // 3. 메타 정보와 본문 결합
    metaDiv.appendChild(authorWrapper);
    metaDiv.appendChild(rightMetaDiv);


    const bodyDiv = document.createElement('div');
    bodyDiv.className = 'comment-body';
    bodyDiv.textContent = c.commentContent || '';

    div.appendChild(metaDiv);
    div.appendChild(bodyDiv);

    parentElement.appendChild(div);

    // 자식 댓글 재귀 호출
    if(c.children && c.children.length > 0) {
        c.children.forEach(child => renderComment(child, parentElement, currentLevel + 1));
    }
}

// 댓글 총 개수 계산 (대댓글 포함)
function countCommentsRecursively(comments) {
    let count = comments.length;
    comments.forEach(c => {
        if(c.children) {
            count += countCommentsRecursively(c.children);
        }
    });
    return count;
}

// 댓글 불러오기
function loadComments() {
    fetch(`/comment/${snsIdx}`)
        .then(res => res.json())
        .then(list => {
            const listBox = document.getElementById('commentList');
            listBox.innerHTML = '';
            list.forEach(c => renderComment(c, listBox));

            document.getElementById('commentCount').innerText = countCommentsRecursively(list);
        })
        .catch(error => {
            console.error('댓글 로드 중 오류 발생:', error);
            document.getElementById('commentList').innerHTML = '<p style="color:#b60000;">댓글을 불러올 수 없습니다.</p>';
        });
}

loadComments(); // 최초 로드

// 댓글 등록
const commentSubmit = document.getElementById('commentSubmit');
if(commentSubmit) {
    commentSubmit.addEventListener('click', () => {
        const textArea = document.getElementById('commentText');
        let text = textArea.value.trim();
        if(!text) {
            alert('댓글을 입력하세요.');
            return;
        }

        let parentIdx = textArea.dataset.parent || null;
        let contentToSend = text;

        // 멘션 제거 로직
        if (parentIdx) {
            const mentionRegex = /^@\w+\s/;
            contentToSend = text.replace(mentionRegex, '').trim();
        }

        if(parentIdx && contentToSend.length === 0) {
            alert('댓글 내용을 입력하세요.');
            return;
        }

        if(contentToSend.length === 0 && text.startsWith('@')) {
             alert('댓글 내용을 입력하세요.');
             return;
        }

        fetch('/comment/add', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({
                snsIdx: snsIdx,
                commentContent: contentToSend,
                parentIdx: parentIdx
            })
        })
        .then(res => res.text())
        .then(result => {
            if(result === 'loginRequired') {
                alert('로그인이 필요합니다.');
                return;
            }
            if(result === 'success') {
                textArea.value = '';
                textArea.removeAttribute('data-parent'); // 부모 인덱스 초기화
                loadComments();
            } else {
                alert('댓글 등록에 실패했습니다. 결과: ' + result);
            }
        })
        .catch(error => {
            console.error('댓글 등록 오류:', error);
            alert('댓글 등록 중 오류가 발생했습니다.');
        });
    });
}
</script>

</body>
</html>
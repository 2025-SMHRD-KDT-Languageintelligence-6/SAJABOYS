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
  <title>커뮤니티 | 추적자</title>

  <!-- Verti 기본 CSS (컨텍스트 경로 반영) -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css" />

  <style>
    body{ background:#f5fafc; }

    .community-layout{
      max-width:1200px;
      margin:2rem auto;
      display:grid;
      grid-template-columns:260px minmax(0,1fr);
      gap:1.5rem;
    }

    /* ===== 왼쪽 사이드바 ===== */
    .side-panel{
      background:#fff;
      border-radius:16px;
      box-shadow:0 4px 12px rgba(0,0,0,.12);
      padding:1rem 1.2rem;
      display:flex;
      flex-direction:column;
      gap:1rem;
      font-size:.9rem;
    }
    .side-title{
      font-weight:800;
      margin-bottom:.4rem;
      border-bottom:2px solid #ddd;
      padding-bottom:.3rem;
    }
    .side-box{
      margin-bottom:.8rem;
    }

    .search-row{
      display:flex;
      gap:.3rem;
      align-items:center;
      margin-top:.2rem;
    }
    .search-row input{
      flex:1;
      padding:.3rem .4rem;
      border-radius:6px;
      border:1px solid #ccc;
    }
    .search-row button{
      font-size:.8rem;
      padding:.35rem .6rem;
    }

    .list-simple li{
      padding:.15rem 0;
    }

    .my-info{
      display:flex;
      align-items:center;
      gap:.7rem;
      margin-top:.3rem;
    }
    .my-info-avatar{
      width:32px;
      height:32px;
      border-radius:50%;
      background:#333;
    }

    /* ===== 오른쪽 메인 ===== */
    .main-panel{
      display:flex;
      flex-direction:column;
      gap:1rem;
    }

    .top-filter{
      background:#fff;
      border-radius:16px;
      box-shadow:0 4px 12px rgba(0,0,0,.12);
      padding:.8rem 1.2rem;
      display:flex;
      align-items:center;
      justify-content:space-between;
      flex-wrap:wrap;
      gap:.6rem;
    }

    .top-filter-left{
      display:flex;
      align-items:center;
      gap:.5rem;
      font-size:.95rem;
    }
    .top-filter-left select{
      min-width:160px;
    }

    /* 탭 메뉴 */
    .tabs{
      background:#fff;
      border-radius:16px 16px 0 0;
      box-shadow:0 4px 0 rgba(0,0,0,.04);
      padding:0 1.2rem;
      display:flex;
      gap:1.5rem;
      border-bottom:1px solid #eee;
    }
    .tab-btn{
      padding:.7rem 0;
      cursor:pointer;
      font-weight:700;
      border-bottom:3px solid transparent;
    }
    .tab-btn.active{
      border-color:#0090c5;
      color:#0090c5;
    }

    /* 글쓰기 + 게시글 영역 */
    .content-box{
      background:#fff;
      border-radius:0 0 16px 16px;
      box-shadow:0 6px 16px rgba(0,0,0,.08);
      padding:1.2rem 1.2rem 1.6rem;
      display:flex;
      flex-direction:column;
      gap:1.2rem;
    }

    .write-form{
      border-radius:12px;
      padding:1rem;
      background:#f8fbff;
      border:1px solid #d8e6f5;
    }
    .write-row{
      display:flex;
      gap:.6rem;
      margin-bottom:.6rem;
      flex-wrap:wrap;
    }
    .write-row label{
      min-width:60px;
      font-weight:700;
      font-size:.9rem;
    }
    .write-row input[type="text"]{
      flex:1;
      padding:.35rem .5rem;
      border-radius:6px;
      border:1px solid #ccc;
    }
    .write-row select{
      min-width:150px;
    }
    .write-row textarea{
      flex:1;
      min-height:80px;
      padding:.4rem .5rem;
      border-radius:6px;
      border:1px solid #ccc;
      resize:vertical;
    }
    .write-tools{
      display:flex;
      justify-content:space-between;
      align-items:center;
      flex-wrap:wrap;
      gap:.6rem;
    }
    .write-icons{
      display:flex;
      gap:.4rem;
      flex-wrap:wrap;
    }
    .tool-btn{
      font-size:.85rem;
      padding:.3rem .6rem;
    }
    .write-submit{
      min-width:110px;
    }

    /* 게시글 카드 */
    .post-card{
      border-radius:18px;
      padding:1rem;
      margin-top:.4rem;
      background:#e6f9ff;
    }
    .post-header{
      display:flex;
      justify-content:space-between;
      align-items:center;
      margin-bottom:.4rem;
      font-size:.9rem;
    }
    .post-author{
      display:flex;
      align-items:center;
      gap:.3rem;
      font-weight:700;
    }
    .post-author-icon{
      width:18px;
      height:18px;
      border-radius:50%;
      background:#ff9800;
    }
    .post-title{
      font-weight:700;
      margin-bottom:.4rem;
    }
    .post-body{
      background:#fff;
      border-radius:10px;
      padding:.7rem;
      display:grid;
      grid-template-columns:150px minmax(0,1fr);
      gap:.7rem;
      border:1px solid #cde6f2;
    }
    .post-body img{
      width:100%;
      border-radius:8px;
    }
    .post-actions{
      margin-top:.4rem;
      font-size:.8rem;
      text-align:center;
      color:#555;
    }
    .post-actions span{
      margin:0 .4rem;
      cursor:pointer;
    }

    .post-card.alt{
      background:#ffeede;
    }

    .hidden{ display:none; }

    @media (max-width:980px){
      .community-layout{
        grid-template-columns:1fr;
      }
      .post-body{
        grid-template-columns:1fr;
      }
    }
  </style>
</head>
<body class="is-preload">

<div id="page-wrapper">

  <!-- header include (JS로 로드) -->
  <div id="site-header"></div>
  <script src="${pageContext.request.contextPath}/assets/js/header.js"></script>

  <!-- 메인 레이아웃 -->
  <main class="community-layout">

    <!-- ===== 왼쪽 사이드바 ===== -->
    <aside class="side-panel">

      <!-- 검색창 -->
      <section class="side-box">
        <div class="side-title">[ 홈 / 로그인 ]</div>
        <div class="search-row">
          <input type="text" id="searchInput" placeholder="검색어를 입력하세요" />
          <button type="button" class="button alt" id="searchBtn">검색</button>
        </div>
      </section>

      <!-- 알림 -->
      <section class="side-box">
        <div class="side-title">[ 알림 ]</div>
        <ul class="list-simple">
          <li>나에게 온 메일 2건</li>
          <li>댓글 알림 5건</li>
          <li>새 커뮤니티 초대 1건</li>
        </ul>
      </section>

      <!-- 친구 창 -->
      <section class="side-box">
        <div class="side-title">[ 친구 창 ]</div>
        <ul class="list-simple">
          <li>루피</li>
          <li>조로</li>
          <li>나미</li>
          <li>우솝</li>
        </ul>
      </section>

      <!-- 커뮤니티 그룹 창 -->
      <section class="side-box">
        <div class="side-title">[ 커뮤니티 그룹 창 ]</div>
        <ul class="list-simple">
          <li># 순천 축제 후기방</li>
          <li># 좀비 아포칼립스 팀</li>
          <li># 월리를찾아라 공략</li>
        </ul>
      </section>

      <!-- 내 정보 -->
      <section class="side-box">
        <div class="side-title">[ 내 정보 ]</div>
        <div class="my-info">
          <div class="my-info-avatar"></div>
          <div>
            <strong>현우 님</strong><br/>
            포인트 12,340점
          </div>
        </div>
        <div style="margin-top:.6rem;font-size:.85rem;">
          <a href="${pageContext.request.contextPath}/7_MyPage.jsp">[마이페이지]</a><br/>
          <a href="${pageContext.request.contextPath}/5_Login.jsp">[로그인]</a> /
          <a href="${pageContext.request.contextPath}/5_1Signup.jsp">[회원가입]</a>
        </div>
      </section>

    </aside>

    <!-- ===== 오른쪽 메인 영역 ===== -->
    <section class="main-panel">

      <!-- 상단: 커뮤니티 별 보기 / 만들기 -->
      <div class="top-filter">
        <div class="top-filter-left">
          <strong>커뮤니티 별로 보기 :</strong>
          <select id="communityFilter">
            <option value="all">전체</option>
            <option value="hot">지금 뜨는 커뮤니티</option>
            <option value="sub">구독한 커뮤니티</option>
            <option value="review">축제 후기</option>
            <option value="tip">게임 공략</option>
          </select>
        </div>
        <div>
          <button type="button" class="button alt" id="createCommBtn">
            커뮤니티 만들기
          </button>
        </div>
      </div>

      <!-- 탭 -->
      <div class="tabs">
        <div class="tab-btn active" data-tab="hot">지금 뜨는 커뮤니티</div>
        <div class="tab-btn" data-tab="sub">구독한 커뮤니티</div>
        <div class="tab-btn" data-tab="all">전체 게시물 보기</div>
      </div>

      <!-- 내용 박스 -->
      <div class="content-box">

        <!-- 글쓰기 창 -->
        <section class="write-form">
          <div class="write-row">
            <label for="postTitle">제목</label>
            <input type="text" id="postTitle" placeholder="제목을 입력하세요" />
          </div>
          <div class="write-row">
            <label for="postCommunity">커뮤니티</label>
            <select id="postCommunity">
              <option>커뮤니티 선택</option>
              <option>순천만가요제</option>
              <option>좀비 아포칼립스 팀</option>
              <option>거점 탐험전 랭킹전</option>
              <option>월리를 찾아라 팬클럽</option>
            </select>
          </div>
          <div class="write-row">
            <label for="postBody">글쓰기</label>
            <textarea id="postBody" placeholder="축제 후기, 공략, 질문 등을 자유롭게 작성하세요."></textarea>
          </div>
          <div class="write-tools">
            <div class="write-icons">
              <button type="button" class="button alt tool-btn">이미지 추가</button>
              <button type="button" class="button alt tool-btn">캘린더 추가</button>
              <button type="button" class="button alt tool-btn">지도 추가</button>
            </div>
            <button type="button" class="button write-submit" id="postSubmit">
              게시하기
            </button>
          </div>
        </section>

        <!-- 게시글 리스트 (탭에 따라 필터) -->
        <section id="postList">

          <!-- 예시 게시글 1 : 지금 뜨는 + 구독 둘 다 -->
          <article class="post-card" data-type="hot sub">
            <div class="post-header">
              <div class="post-author">
                <div class="post-author-icon"></div>
                <span>최강루피</span>
              </div>
              <div>포인트 : 3000</div>
            </div>
            <div class="post-title">오늘 나랑 놀 사람~ 3명만</div>
            <div class="post-body">
              <img src="${pageContext.request.contextPath}/images/sample-map.jpg" alt="지도 예시" />
              <div>
                <p>순천만 국가정원에서 거점 탐험전 같이 돌 사람 모집합니다!
                   빨간 원 표시된 곳이 오늘 미션 지역이에요.</p>
                <p style="font-size:.8rem;color:#666;">커뮤니티: 거점 탐험전 랭킹전</p>
              </div>
            </div>
            <div class="post-actions">
              <span>[댓글]</span>
              <span>[공유하기]</span>
              <span>[좋아요]</span>
              <span>[조회수 152]</span>
            </div>
          </article>

          <!-- 예시 게시글 2 : 지금 뜨는 전용 -->
          <article class="post-card alt" data-type="hot">
            <div class="post-header">
              <div class="post-author">
                <div class="post-author-icon" style="background:#ff5722;"></div>
                <span>10도루조로</span>
              </div>
              <div>포인트 : 3000</div>
            </div>
            <div class="post-title">투머치 런 좀 누가 같이 해줘요</div>
            <div class="post-body">
              <img src="${pageContext.request.contextPath}/images/sample-run.jpg" alt="게임 이미지" />
              <div>
                <p>좀비 아포칼립스 모드 하드 난이도 도전할 분~
                   초보도 환영합니다. 규칙부터 알려드려요.</p>
                <p style="font-size:.8rem;color:#666;">커뮤니티: 좀비 아포칼립스 팀</p>
              </div>
            </div>
            <div class="post-actions">
              <span>[댓글]</span>
              <span>[공유하기]</span>
              <span>[좋아요]</span>
              <span>[조회수 89]</span>
            </div>
          </article>

          <!-- 예시 게시글 3 : 구독 전용 -->
          <article class="post-card" data-type="sub">
            <div class="post-header">
              <div class="post-author">
                <div class="post-author-icon" style="background:#4caf50;"></div>
                <span>나미짱</span>
              </div>
              <div>포인트 : 2100</div>
            </div>
            <div class="post-title">이번 주말 월리를 찾아라 포인트 공략</div>
            <div class="post-body">
              <img src="${pageContext.request.contextPath}/images/sample-wally.jpg" alt="월리 이미지" />
              <div>
                <p>QR 미션은 시간이 중요!
                   먼저 맵 왼쪽 상단 포토존부터 찍고, 중앙 푸드존으로 이동하는 동선 추천합니다.</p>
                <p style="font-size:.8rem;color:#666;">커뮤니티: 월리를 찾아라 팬클럽</p>
              </div>
            </div>
            <div class="post-actions">
              <span>[댓글]</span>
              <span>[공유하기]</span>
              <span>[좋아요]</span>
              <span>[조회수 63]</span>
            </div>
          </article>

        </section>

      </div> <!-- content-box 끝 -->

    </section>
  </main>

  <!-- 푸터 -->
  <div id="footer-wrapper">
    <div class="container" id="footer">
      <div id="copyright">
        <ul class="menu">
          <li>&copy; 2025 RunBack</li>
          <li>추적자 · 커뮤니티 페이지</li>
        </ul>
      </div>
    </div>
  </div>
</div>

<script>
  // 탭 전환
  const tabBtns = document.querySelectorAll('.tab-btn');
  const posts   = document.querySelectorAll('#postList .post-card');

  function applyTab(tab){
    tabBtns.forEach(b => b.classList.toggle('active', b.dataset.tab === tab));
    posts.forEach(p => {
      if(tab === 'all') {
        p.classList.remove('hidden');
      } else {
        const types = (p.dataset.type || '').split(' ');
        p.classList.toggle('hidden', !types.includes(tab));
      }
    });
  }

  tabBtns.forEach(btn => {
    btn.addEventListener('click', () => applyTab(btn.dataset.tab));
  });

  // 초기 탭
  applyTab('hot');

  // 검색 버튼 (데모용 알림)
  document.getElementById('searchBtn').addEventListener('click', () => {
    const q = document.getElementById('searchInput').value.trim();
    if(!q) { alert('검색어를 입력하세요.'); return; }
    alert('"' + q + '" 로 검색 기능은 추후 서버 연동 예정입니다.');
  });

  // 커뮤니티 만들기 (데모)
  document.getElementById('createCommBtn').addEventListener('click', () => {
    const name = prompt('새로 만들 커뮤니티 이름을 입력하세요.');
    if(name){
      alert('커뮤니티 "' + name + '" 생성 요청이 접수되었습니다. (데모)');
    }
  });

  // 게시하기 (간단히 alert만)
  document.getElementById('postSubmit').addEventListener('click', () => {
    const title = document.getElementById('postTitle').value.trim();
    const comm  = document.getElementById('postCommunity').value;
    const body  = document.getElementById('postBody').value.trim();

    if(!title || comm === '커뮤니티 선택' || !body){
      alert('제목, 커뮤니티, 글 내용을 모두 입력해 주세요.');
      return;
    }
    alert('게시물이 등록되었습니다! (실제 저장은 서버 연동 후 구현)');
    document.getElementById('postTitle').value = '';
    document.getElementById('postBody').value  = '';
  });
</script>
</body>
</html>

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
    <title>축제 장 | 추적자</title>

    <!-- Verti 기본 CSS -->
    <link rel="stylesheet" href="assets/css/main.css" />

    <style>
        body{ background:#f5fafc; }

        .festival-layout{
          max-width:1200px;
          margin:2rem auto;
          padding:0 1rem;
        }

        .festival-main{
          display:flex;
          flex-direction:column;
          gap:1.5rem;
        }

        .section-box{
          background:#fff;
          border-radius:18px;
          box-shadow:0 4px 12px rgba(0,0,0,.12);
          padding:1.2rem 1.5rem 1.6rem;
        }
        .section-header{
          display:flex;
          justify-content:space-between;
          align-items:flex-end;
          margin-bottom:1rem;
          gap:.5rem;
          flex-wrap:wrap;
        }
        .section-header h2{
          margin:0;
          font-size:1.4rem;
          font-weight:800;
        }
        .section-header small{
          font-size:.85rem;
          color:#777;
        }

        /* ===== 필터 ===== */
        .filter-bar{
          display:flex;
          flex-wrap:wrap;
          gap:.75rem 1.5rem;
          margin-bottom:1rem;
          font-size:.9rem;
          align-items:center;
        }
        .filter-group{
          display:flex;
          flex-wrap:wrap;
          gap:.4rem;
          align-items:center;
        }
        .filter-group label{
          font-weight:600;
        }
        .filter-group select{
          min-width:120px;
          padding:.25rem .5rem;
          border-radius:999px;
          border:1px solid #cbd5e1;
          font-size:.9rem;
          background:#f8fafc;
        }

        /* 카드 공통 (포스터 그리드) */
        .card-grid{
          display:grid;
          grid-template-columns:repeat(auto-fit,minmax(230px,1fr));
          gap:1.2rem;
        }
        .festival-card{
          border-radius:18px;
          overflow:hidden;
          background:#f8fbff;
          border:1px solid #d8e6f5;
          display:flex;
          flex-direction:column;
          cursor:pointer;
          transition:transform .22s ease, box-shadow .22s ease, border-color .22s ease;
        }
        .festival-card:hover{
          transform:translateY(-4px);
          box-shadow:0 10px 22px rgba(15,118,178,.25);
          border-color:#60a5fa;
        }

        .poster{
          width:100%;
          height:220px;
          background-image:linear-gradient(135deg,#ffd54f,#ffb74d);
          display:flex;
          align-items:center;
          justify-content:center;
          font-size:.9rem;
          color:#333;
          transition:transform .25s ease, box-shadow .25s ease, filter .25s ease;
        }
        .festival-card:hover .poster{
          transform:scale(1.04);
          filter:brightness(1.03);
          box-shadow:0 8px 18px rgba(0,0,0,.25);
        }

        .festival-body{
          padding:.75rem .9rem 1rem;
          display:flex;
          flex-direction:column;
          gap:.35rem;
        }
        .festival-name{
          font-weight:800;
          font-size:1rem;
        }
        .festival-meta{
          font-size:.85rem;
          color:#555;
          line-height:1.6;
        }
        .tag-row{
          display:flex;
          flex-wrap:wrap;
          gap:.3rem;
          margin-top:.25rem;
        }
        .tag{
          display:inline-block;
          padding:.1rem .5rem;
          border-radius:999px;
          font-size:.75rem;
          background:#0090c5;
          color:#fff;
        }
        .tag.sub{
          background:#e2e8f0;
          color:#1f2933;
        }

        /* 최근 다녀간 축제 스타일 */
        .recent-list{
          display:flex;
          flex-direction:column;
          gap:.8rem;
        }
        .recent-item{
          display:flex;
          gap:.7rem;
          padding:.6rem .5rem;
          border-radius:10px;
          background:#fdf7ec;
          border:1px solid #ffe0a3;
          position:relative;
        }
        .recent-thumb{
          width:90px;
          height:70px;
          border-radius:8px;
          background:#ffcc80;
          display:flex;
          align-items:center;
          justify-content:center;
          font-size:.8rem;
        }
        .recent-body{
          flex:1;
          font-size:.9rem;
        }
        .recent-body .name{
          font-weight:700;
          margin-bottom:.1rem;
        }
        .recent-body .meta{
          font-size:.8rem;
          color:#555;
        }

        @media(max-width:980px){
          .festival-layout{
            padding:0 1rem 2rem;
          }
        }
    </style>
</head>
<body class="is-preload">

<div id="page-wrapper">

    <!-- 상단 공통 헤더 -->
    <div id="header-wrapper">
        <header id="header" class="container">
            <div id="logo">
                <h1><a href="index.html">추적자</a></h1>
                <span>지역축제 술레잡기 게임</span>
            </div>
            <nav id="nav">
                <ul>
                    <li><a href="index.html">Home</a></li>
                    <li><a href="1_Game.html">게임창</a></li>
                    <li><a href="2_Stamp.html">스템프 투어창</a></li>
                    <li class="current"><a href="3_Festival.html">축제 장</a></li>
                    <li><a href="4_Community.html">커뮤니티</a></li>
                    <li><a href="5_Login.html">로그인/회원가입</a></li>
                </ul>
            </nav>
        </header>
    </div>

    <!-- 메인 레이아웃 -->
    <main class="festival-layout">
        <section class="festival-main">

            <!-- 오늘 갈만한 축제 -->
            <section class="section-box" id="todaySection">
                <div class="section-header">
                    <div>
                        <h2>오늘 갈만한 축제</h2>
                        <small id="todayLabel"></small>
                    </div>

                    <!-- 카테고리 필터 -->
                    <div class="filter-bar">
                        <div class="filter-group">
                            <label for="filterTheme">테마</label>
                            <select id="filterTheme">
                                <option value="">전체</option>
                                <option value="먹거리">먹거리</option>
                                <option value="문화유산">문화유산</option>
                                <option value="음악">음악</option>
                                <option value="자연">자연</option>
                                <option value="전통">전통</option>
                                <option value="해양">해양</option>
                            </select>
                        </div>

                        <div class="filter-group">
                            <label for="filterRegion">지역</label>
                            <select id="filterRegion">
                                <option value="">전체</option>
                                <option value="순천">순천</option>
                                <option value="광양">광양</option>
                                <option value="여수">여수</option>
                            </select>
                        </div>

                        <div class="filter-group">
                            <label for="filterStatus">기간</label>
                            <select id="filterStatus">
                                <option value="">전체</option>
                                <option value="예정">예정</option>
                                <option value="진행중">진행중</option>
                                <option value="마감">마감</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="card-grid">
                    <!-- 카드 1 -->
                    <article class="festival-card"
                             data-theme="음악,자연"
                             data-region="순천"
                             data-status="진행중">
                        <div class="poster">포스터 이미지</div>
                        <div class="festival-body">
                            <div class="festival-name">순천만 국가정원 별빛축제</div>
                            <div class="festival-meta">
                                날짜 : 오늘 ~ 24:00<br>
                                장소 : 순천만국가정원 메인무대<br>
                                분류 : 야간/불꽃/가족
                            </div>
                            <div class="tag-row">
                                <span class="tag">오늘 열리는 축제</span>
                                <span class="tag sub">테마: 음악·자연</span>
                                <span class="tag sub">지역: 순천</span>
                                <span class="tag sub">기간: 진행중</span>
                            </div>
                        </div>
                    </article>

                    <!-- 카드 2 -->
                    <article class="festival-card"
                             data-theme="자연,전통"
                             data-region="순천"
                             data-status="진행중">
                        <div class="poster">포스터 이미지</div>
                        <div class="festival-body">
                            <div class="festival-name">순천만 갈대축제</div>
                            <div class="festival-meta">
                                날짜 : 오늘 하루<br>
                                장소 : 순천만습지 일원<br>
                                분류 : 자연/산책
                            </div>
                            <div class="tag-row">
                                <span class="tag">오늘 열리는 축제</span>
                                <span class="tag sub">테마: 자연·전통</span>
                                <span class="tag sub">지역: 순천</span>
                                <span class="tag sub">기간: 진행중</span>
                            </div>
                        </div>
                    </article>

                    <!-- 카드 3 -->
                    <article class="festival-card"
                             data-theme="먹거리,음악"
                             data-region="순천"
                             data-status="예정">
                        <div class="poster">포스터 이미지</div>
                        <div class="festival-body">
                            <div class="festival-name">순천청년 푸드트럭 페스티벌</div>
                            <div class="festival-meta">
                                날짜 : 오늘 12:00 ~ 22:00<br>
                                장소 : 조례호수공원<br>
                                분류 : 푸드/공연
                            </div>
                            <div class="tag-row">
                                <span class="tag">오늘 열리는 축제</span>
                                <span class="tag sub">테마: 먹거리·음악</span>
                                <span class="tag sub">지역: 순천</span>
                                <span class="tag sub">기간: 예정</span>
                            </div>
                        </div>
                    </article>

                    <!-- 필요하면 여기부터 추천 결과 카드 추가하면 됨 -->
                </div>
            </section>
        </section>


    </main>

    <!-- 푸터 -->
    <div id="footer-wrapper">
        <div class="container" id="footer">
            <div id="copyright">
                <ul class="menu">
                    <li>&copy; 2025 RunBack</li>
                    <li>추적자 · 축제 장</li>
                </ul>
            </div>
        </div>
    </div>
</div>

<script>
    // 오늘 날짜 표시
    (function(){
      const label = document.getElementById('todayLabel');
      const today = new Date();
      const y = today.getFullYear();
      const m = ('0' + (today.getMonth()+1)).slice(-2);
      const d = ('0' + today.getDate()).slice(-2);
      label.textContent = `오늘 날짜 : ${y}-${m}-${d}`;
    })();

    // ===== 카테고리 필터 =====
    const themeSel  = document.getElementById('filterTheme');
    const regionSel = document.getElementById('filterRegion');
    const statusSel = document.getElementById('filterStatus');

    function filterFestivals(){
      const t = themeSel.value;
      const r = regionSel.value;
      const s = statusSel.value;

      document.querySelectorAll('.festival-card').forEach(card => {
        const cardThemes = (card.dataset.theme || '').split(',').map(v => v.trim());
        const cardRegion = (card.dataset.region || '').trim();
        const cardStatus = (card.dataset.status || '').trim();

        let visible = true;

        if(t && !cardThemes.includes(t)) visible = false;
        if(r && cardRegion !== r)        visible = false;
        if(s && cardStatus !== s)        visible = false;

        card.style.display = visible ? '' : 'none';
      });
    }

    [themeSel, regionSel, statusSel].forEach(sel => {
      sel.addEventListener('change', filterFestivals);
    });

    // 초기 필터 적용
    filterFestivals();
</script>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
          background:#eee;
          display:flex;
          align-items:center;
          justify-content:center;
          overflow:hidden;
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

        @media(max-width:980px){
          .festival-layout{
            padding:0 1rem 2rem;
          }
        }
    </style>
</head>
<body class="is-preload">

<div id="page-wrapper">

    <!-- 공통 헤더 include -->
    <div id="site-header"></div>
    <script src="/assets/js/header.js"></script>

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

                <!-- ===== 축제 카드 리스트 (DB 기반) ===== -->
                <div class="card-grid">

                    <c:forEach var="f" items="${festivalList}">
                        <article class="festival-card"
                                 data-theme="${f.theme}"
                                 data-region="${f.region}"
                                 data-status="${f.status}">

                            <!-- 포스터 -->
                            <div class="poster">
                                <img src="/img/festival/${f.fesIdx}.jpg"
                                     onerror="this.src='/img/festival/default.jpg'"
                                     style="width:100%; height:100%; object-fit:cover;">
                            </div>

                            <!-- 본문 -->
                            <div class="festival-body">
                                <div class="festival-name">${f.fesName}</div>

                                <div class="festival-meta">
                                    날짜 : ${f.startDate} ~ ${f.endDate}<br>
                                    장소 : ${f.addr}<br>
                                    입장료 : ${f.fee}
                                </div>

                                <div class="tag-row">
                                    <span class="tag">오늘 열리는 축제</span>
                                    <span class="tag sub">테마: ${f.theme}</span>
                                    <span class="tag sub">지역: ${f.region}</span>
                                    <span class="tag sub">기간: ${f.status}</span>
                                </div>
                            </div>

                        </article>
                    </c:forEach>

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
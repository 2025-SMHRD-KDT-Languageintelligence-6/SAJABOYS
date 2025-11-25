<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>월리 | 진행 현황</title>

    <link rel="stylesheet" href="/assets/css/main.css" />
    <style>
        .stamp-panel{
          max-width:1100px;
          margin:2.5rem auto 3rem;
          background:#fff;
          border-radius:18px;
          box-shadow:0 4px 14px rgba(0,0,0,.12);
          padding:1.3rem 1.4rem 1.6rem;
        }

        h2{ font-weight:800;margin:0 0 .5rem; }
        .panel-desc{ color:#666;margin-bottom:1rem;font-size:.9rem; }

        .stamp-grid{
          display:grid;
          grid-template-columns:repeat(5,1fr);
          gap:.8rem;
          margin-top:.8rem;
        }

        .stamp-cell-link {
            display: block;
            text-decoration: none;
            color: inherit;
        }

        .stamp-cell{
          position:relative;
          border-radius:14px;
          border:2px dashed #cfd8e3;
          padding-top:100%;
          background:#fafbff;
          overflow:hidden;
        }

        .stamp-inner{
          position:absolute;
          inset:0;
          display:flex;
          flex-direction:column;
          align-items:center;
          justify-content:center;
          color:#777;
          font-size:.85rem;
        }

        .stamp-number{ font-weight:800;font-size:1rem; }
        .stamp-label{ font-size:.78rem; }

        .stamp-cell.collected{
          border-color:#2ecc71;
          background:#e8fff1;
          border-style:solid;
          box-shadow:0 0 0 2px rgba(46,204,113,.3) inset;
        }

        .stamp-cell.collected .stamp-number{ color:#1f9d57; }
        .stamp-cell.collected .stamp-label::after{
          content:" ✔";
          color:#1f9d57;
          font-weight:800;
        }

        .stamp-progress-wrapper {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-top: 1rem;
        }

        .stamp-progress{ font-size:.95rem; }
        .stamp-bar-wrap{
          width:100%; background:#e5edf7;
          border-radius:999px; overflow:hidden;
          height:12px; margin-top:.4rem;
        }

        .stamp-bar{
          width:0; height:100%;
          background:#0090c5;
          transition:.3s ease;
        }

        .reward-box{
          max-width:1100px;
          margin:1.3rem auto;
          background:#fff8e6;
          border-radius:16px;
          border:1px solid #ffd37a;
          box-shadow:0 3px 10px rgba(0,0,0,.08);
          padding:1rem 1.3rem;
          display:flex;
          justify-content:space-between;
          flex-wrap:wrap;
          gap:1rem;
        }

        .reward-btn{
          background:#ff9800;
          color:#fff;
          min-width:160px;
          padding:.6rem 0;
        }

        .go-scan{
          margin: 0;
        }

        .go-scan button {
            margin-left: 0.5rem; /* 버튼 사이 간격 */
        }
    </style>
</head>
<body>

<div id="page-wrapper">
    <div id="site-header"></div>
    <script src="/assets/js/header.js"></script>

    <section class="stamp-panel">
        <h2>월리 현황</h2>
        <p class="panel-desc">월리를 찾아보세요!</p>

        <c:if test="${not empty gamingResults}">
            <div class="gaming-results">
                <h3>게임 결과</h3>
                <ul>
                    <c:forEach var="gaming" items="${gamingResults}">
                        <li>
                            <strong>축제 번호: </strong>${gaming.fesIdx}<br/>
                            <strong>게임 이름: </strong>${gaming.gameName}<br/>
                            <strong>게임 결과: </strong>${gaming.gameResult == 1 ? '성공' : '실패'}<br/>
                            <strong>적립 시간: </strong><fmt:formatDate value="${gaming.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" /><br/>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </c:if>

        <c:if test="${empty gamingResults}">
            <p>현재 게임 기록이 없습니다.</p>
        </c:if>
    </section>
</div>

</body>
</html>
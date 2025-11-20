<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>스탬프 투어 | 진행 현황</title>

    <link rel="stylesheet" href="/assets/css/main.css" />
    <style>
        body{ background:#f5fafc; }

        .stamp-panel{
          max-width:1100px;
          margin:2.5rem auto 3rem;
          background:#fff;
          border-radius:18px;
          box-shadow:0 4px 14px rgba(0,0,0,.12);
          padding:1.3rem 1.4rem 1.6rem;
        }

        h2{ font-size:1.5rem;font-weight:800;margin:0 0 .5rem; }
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

        .stamp-progress{ margin-top:1rem;font-size:.95rem; }
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

        .hidden{ display:none; }

        .go-scan{
          text-align:right;
          margin-top:1.3rem;
        }

    </style>
</head>
<body>

<div id="page-wrapper">
    <div id="site-header"></div>
    <script src="/assets/js/header.js"></script>

    <section class="stamp-panel">
        <h2>스탬프 투어 진행 현황</h2>
        <p class="panel-desc">QR코드를 통해 스탬프를 수집하세요!</p>

        <c:set var="percent" value="${totalCount > 0 ? collectedCount / totalCount * 100 : 0}" />

        <div class="stamp-progress">
            <span>완료한 축제 : <strong id="stampCountText">${collectedCount} / ${totalCount}</strong></span>
            <div class="stamp-bar-wrap">
                <div class="stamp-bar" id="stampBar" style="width:${percent}%"></div>
            </div>
        </div>

        <div class="stamp-grid" id="stampGrid">
            <c:forEach var="status" items="${festivalStatuses}">
                <c:set var="isCompleted" value="${status.completed != 0}" />
                <!-- 축제 클릭 시 해당 축제의 fesIdx 값을 detail로 넘김 -->
                <a href="/stamp/detail?fesIdx=${status.fesIdx}" class="stamp-cell-link">
                    <div class="stamp-cell <c:if test='${isCompleted}'>collected</c:if>">
                        <div class="stamp-inner">
                            <div class="stamp-number">${status.fesIdx}</div>
                            <div class="stamp-label">축제 ${status.fesIdx}</div>
                        </div>
                    </div>
                </a>
            </c:forEach>
        </div>

        <div class="go-scan">
            <button class="button alt" onclick="location.href='qr.html'">QR 코드 스캔하기 →</button>
        </div>

        <c:if test="${collectedCount == totalCount && totalCount > 0}">
            <section id="rewardSection" class="reward-box">
                <div>
                    <strong>축하합니다! 스탬프 투어 모두 완료 🎉</strong>
                    <p>상품 교환 부스 또는 온라인 교환 페이지로 이동하세요.</p>
                </div>
                <button type="button" class="button reward-btn" onclick="location.href='rewardExchange.html'">상품 교환하기</button>
            </section>
        </c:if>
    </section>
</div>

</body>
</html>
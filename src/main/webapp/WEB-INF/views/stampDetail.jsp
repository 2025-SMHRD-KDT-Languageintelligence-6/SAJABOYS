<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>스탬프 투어 | ${festival.fesName}</title>
    <link rel="stylesheet" href="/assets/css/main.css">
    <style>
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
        .go-scan{ text-align:right; margin-top:1.3rem; }
    </style>
</head>
<body>

<div id="page-wrapper">
    <div id="site-header"></div>
    <script src="/assets/js/header.js"></script>

    <section class="stamp-panel">
        <h2>${festival.fesName}</h2>

        <!-- 필요 스탬프 / 수집 스탬프 -->
        <p class="panel-desc">
            수집 스탬프: <strong>${fn:length(collectedStamps)}</strong>개 /
            총 스탬프: <strong>${festival.stampCount}</strong>개
        </p>

        <!-- 축제 상세 정보 -->
        <div class="stamp-info">
            <p><strong>지역:</strong> ${festival.region}</p>
            <p><strong>주소:</strong> ${festival.addr}</p>
            <p><strong>기간:</strong>
                <fmt:formatDate value="${festival.startDate}" pattern="yyyy.MM.dd"/>
                ~
                <fmt:formatDate value="${festival.endDate}" pattern="yyyy.MM.dd"/>
            </p>
            <p><strong>테마:</strong> ${festival.theme}</p>
            <p><strong>전화:</strong> ${festival.tel}</p>
        </div>

        <!-- 스탬프 그리드 -->
        <h3>스탬프 현황</h3>
        <div class="stamp-grid">
            <c:forEach begin="1" end="${festival.stampCount}" varStatus="loop">
                <c:set var="isCollected" value="false" />
                <c:forEach var="stamp" items="${collectedStamps}">
                    <c:if test="${stamp.stampNumber == loop.index}">
                        <c:set var="isCollected" value="true" />
                    </c:if>
                </c:forEach>

                <div class="stamp-cell ${isCollected ? 'collected' : ''}">
                    <div class="stamp-inner">
                        <div class="stamp-number">${loop.index}</div>
                        <div class="stamp-label">스탬프 ${loop.index}</div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="go-scan">
            <button class="button alt" onclick="location.href='/stamp'">← 목록으로 돌아가기</button>
            <button class="button" onclick="location.href='/stamp/qr'">QR 코드 스캔하기 →</button>
        </div>
    </section>
</div>

</body>
</html>
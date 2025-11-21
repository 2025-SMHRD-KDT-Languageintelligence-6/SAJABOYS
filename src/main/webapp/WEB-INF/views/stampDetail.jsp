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
    <link rel="stylesheet" href="/assets/css/stamp.css">

</head>
<body>

<div id="page-wrapper">
    <div id="site-header"></div>
    <script src="/assets/js/header.js"></script>

    <section class="stamp-panel">
        <h2>${festival.fesName}</h2>

        <!-- 필요 스탬프 / 수집 스탬프 -->
        <p class="panel-desc stamp-summary">
            <span class="stamp-collected">
                    <i class="fas fa-check-circle"></i>
            수집 스탬프: <strong>${fn:length(collectedStamps)}</strong>개 /

            </span>
            <span class="stamp-total">
                    <i class="fas fa-star"></i>
            총 스탬프: <strong>${festival.stampCount}</strong>개
            </span>
        </p>

        <!-- 축제 상세 정보 -->
        <div class="stamp-detail-card">
            <div class="detail-row">
                <span class="label"><i class="fas fa-map-marker-alt"></i> 지역</span>
                <span class="value">${festival.region}</span>
            </div>

            <div class="detail-row">
                <span class="label"><i class="fas fa-location-dot"></i> 주소</span>
                <span class="value">${festival.addr}</span>
            </div>

            <div class="detail-row">
                <span class="label"><i class="fas fa-calendar"></i> 기간</span>
                <span class="value">
                    <fmt:formatDate value="${festival.startDate}" pattern="yyyy.MM.dd"/>
                    ~
                    <fmt:formatDate value="${festival.endDate}" pattern="yyyy.MM.dd"/>
                </span>
            </div>

            <div class="detail-row">
                <span class="label"><i class="fas fa-tags"></i> 테마</span>
                <span class="value">${festival.theme}</span>
            </div>

            <div class="detail-row">
                <span class="label"><i class="fas fa-phone"></i> 전화</span>
                <span class="value">${festival.tel}</span>
            </div>
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
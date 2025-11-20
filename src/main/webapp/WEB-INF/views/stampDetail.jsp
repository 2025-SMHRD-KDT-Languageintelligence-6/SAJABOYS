<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>스탬프 투어 | ${festival.fesName}</title>
    <link rel="stylesheet" href="/assets/css/main.css" />
    <style>
        /* 스타일링 생략 (위와 동일) */
    </style>
</head>
<body>

<div id="page-wrapper">
    <div id="site-header"></div>
    <script src="/assets/js/header.js"></script>

    <section class="stamp-panel">
        <h2>${festival.fesName}</h2>
        <p class="panel-desc">필요 스탬프: <strong>${festival.StampCount}</strong>개 / 수집 스탬프: ${fn:length(collectedStamps)}개</p>

        <div class="stamp-info">
            <p><strong>지역:</strong> ${festival.Region}</p>
            <p><strong>주소:</strong> ${festival.Addr}</p>
            <p><strong>기간:</strong>
                <fmt:formatDate value="${festival.StartDate}" pattern="yyyy.MM.dd"/>
                ~
                <fmt:formatDate value="${festival.EndDate}" pattern="yyyy.MM.dd"/>
            </p>
            <p><strong>테마:</strong> ${festival.Theme}</p>
            <p><strong>전화:</strong> ${festival.Tel}</p>
        </div>

        <h3>수집 스탬프 목록 (${fn:length(collectedStamps)} / <strong>${festival.stampCount}</strong>)</h3>

        <div class="stamp-grid" id="stampDetailGrid">
            <c:forEach begin="1" end="${festival.stampCount}" varStatus="loop">
                <c:set var="isCollected" value="false" />

                <c:forEach var="stamp" items="${collectedStamps}">
                    <c:if test="${stamp.stampNumber == loop.index}">
                        <c:set var="isCollected" value="true" />
                    </c:if>
                </c:forEach>

                <div class="stamp-cell <c:if test='${isCollected}'>collected</c:if>">
                    <div class="stamp-inner">
                        <div class="stamp-number">${loop.index}</div>
                        <div class="stamp-label">스탬프 ${loop.index}</div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="action-buttons">
            <button class="button alt" onclick="location.href='/stamp'">← 목록으로 돌아가기</button>
            <button class="button" onclick="location.href='/qr.html'">QR 코드 스캔하기 (스탬프 찍기) →</button>
        </div>
    </section>
</div>

</body>
</html>

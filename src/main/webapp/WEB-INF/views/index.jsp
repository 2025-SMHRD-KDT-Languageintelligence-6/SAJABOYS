<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<!--
  Verti by HTML5 UP
  커스텀: 추적자들(축제 술레잡기 사이트) 메인 페이지
-->
<html lang="ko">
<head>
    <title>추적자들(축제 술레잡기 사이트)</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />

    <!-- Verti 기본 CSS -->
    <link rel="stylesheet" href="/assets/css/main.css" />
    <link rel="stylesheet" href="/assets/css/index.css" />
    <link rel="stylesheet" href="/assets/css/main-festival3.css" />

    <!-- Swiper CSS -->
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
</head>

<body class="is-preload homepage">

    <!-- =================== HEADER =================== -->
    <div id="site-header"></div>
    <script src="/assets/js/header.js"></script>



        <!-- =================== MAIN WRAPPER =================== -->
        <div id="main-wrapper">
            <div class="container">
                <div class="row gtr-200">
                    <!-- ===== 왼쪽: 월리 + 축제 추천 ===== -->
                    <div class="col-8 col-12-medium">
                        <!-- 오늘의 월리 -->
                        <section class="box wally-section">
                            <div class="wally-layout">

                                <!-- 이미지 영역 -->
                                <div class="wally-image-wrap">
                                    <div class="wally-title-bar">
                                        오늘의 월리
                                    </div>
                                    <img src="/images/wally.png"
                                         alt="오늘의 월리"
                                         class="wally-image" />
                                </div>

                                <!-- 버튼/텍스트 영역 -->
                                <div class="wally-actions">
                                    <div class="wally-found-card">
                                        <h3>월리를 찾았다!</h3>
                                        <button type="button" class="wally-camera-btn" onclick="location.href='/stamp/qr'">
                                            카메라 열기
                                        </button>
                                    </div>

                                    <div class="wally-btn-group">
                                        <a href="/gameSelect" class="button alt">
                                            다른 게임을 하러가기
                                        </a>

                                        <a href="#" class="button">
                                            Game Rule
                                        </a>
                                    </div>

                                    <!-- 서브 이미지 제목 -->
                                    <h4 class="wally-sub-h4" >
                                        윌리가 있는 축제장
                                    </h4>

                                    <div class="wally-sub-image">
                                        <img src="/img/festival/121.png"
                                             alt="윌리가 있는 축제 정보"
                                             onerror="this.src='/images/no-image.png';" />
                                    </div>
                                </div>

                            </div>
                        </section>


                    </div>

                    <!-- ===== 오른쪽: 채팅 박스 ===== -->
                    <div class="col-4 col-12-medium">
                        <section class="gr-chat-box">
                            <h3>채팅</h3>

                            <div id="chatMessages" class="gr-chat-messages">
                                <div style="margin-bottom: 5px;">박현우닉넴님이 입장했습니다.</div>
                            </div>

                            <div class="gr-chat-input-wrap">
                                <input type="text" id="chatInput" placeholder="메시지 입력..." class="gr-chat-input" onkeypress="handleEnter(event)">
                                <button id="sendBtn" class="gr-chat-send-btn" onclick="sendMessage()">전송</button>
                            </div>
                        </section>
                    </div>
                </div>
            </div>
        </div>

    	<!--================ 축제 ================================================-->

    	<div id="main-wrapper2">
    	<h2>이런 축제 어떠세요?</h2>
    		<section class="festival-section">

    			<div class="festival-grid">
                    <!-- 머신러닝 추천 결과가 있을 때 -->
                    <c:if test="${not empty recommendList}">
                        <c:forEach var="f" items="${recommendList}">
                            <div class="festival-card">
                                <img class="festival-img"
                                     src="/img/festival/<fmt:formatNumber value='${f.fesIdx}' pattern='000'/>.png"
                                     alt="${f.fesName}"
                                     onerror="this.src='/images/no-image.png';"/>
                            </div>
                        </c:forEach>
                    </c:if>


    			<a href="/festival" class="button icon fa-file-alt">더 많은 축제 보러가기</a>
    		</section>

        </div>




    <!-- =================== FOOTER =================== -->
    <div id="footer-wrapper">
        <footer id="footer" class="container">
            <div class="row">
                <div class="col-3 col-6-medium col-12-small">
                    <section class="widget links">
                        <h3>About 추적자들</h3>
                        <ul class="style2">
                            <li><a href="#">서비스 소개</a></li>
                            <li><a href="#">팀 소개</a></li>
                            <li><a href="#">전남 축제 데이터 출처</a></li>
                            <li><a href="#">이용 가이드</a></li>
                        </ul>
                    </section>
                </div>

                <div class="col-3 col-6-medium col-12-small">
                    <section class="widget links">
                        <h3>축제/게임</h3>
                        <ul class="style2">
                            <li><a href="#">진행 중인 게임</a></li>
                            <li><a href="#">지난 축제 기록</a></li>
                            <li><a href="#">랭킹 보드</a></li>
                            <li><a href="#">자주 묻는 질문</a></li>
                        </ul>
                    </section>
                </div>

                <div class="col-3 col-6-medium col-12-small">
                    <section class="widget links">
                        <h3>정책</h3>
                        <ul class="style2">
                            <li><a href="#">이용약관</a></li>
                            <li><a href="#">개인정보 처리방침</a></li>
                            <li><a href="#">위치기반 서비스 약관</a></li>
                        </ul>
                    </section>
                </div>

                <div class="col-3 col-6-medium col-12-small">
                    <section class="widget contact last">
                        <h3>Contact Us</h3>
                        <ul>
                            <li><a href="#" class="icon brands fa-twitter"><span class="label">Twitter</span></a></li>
                            <li><a href="#" class="icon brands fa-facebook-f"><span class="label">Facebook</span></a></li>
                            <li><a href="#" class="icon brands fa-instagram"><span class="label">Instagram</span></a></li>
                        </ul>
                        <p>
                            전남 어딘가의 축제 현장<br />
                            (예시 주소) 1234 Festival Road<br />
                            010-0000-0000
                        </p>
                    </section>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                    <div id="copyright">
                        <ul class="menu">
                            <li>&copy; 추적자들. All rights reserved.</li>
                            <li>Design base: <a href="http://html5up.net">HTML5 UP Verti</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </footer>
    </div>

    <!-- =================== SCRIPTS =================== -->

    <!-- Swiper JS -->
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

    <!-- Verti 기본 JS -->
    <script src="/assets/js/jquery.min.js"></script>
    <script src="/assets/js/jquery.dropotron.min.js"></script>
    <script src="/assets/js/browser.min.js"></script>
    <script src="/assets/js/breakpoints.min.js"></script>
    <script src="/assets/js/util.js"></script>
    <script src="/assets/js/main.js"></script>

    <!-- Swiper 초기화 -->
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var galleryTop = new Swiper('.gallery-top', {
                spaceBetween: 10,
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev'
                },
                loop: true,
                loopedSlides: 5
            });

            var galleryThumbs = new Swiper('.gallery-thumbs', {
                spaceBetween: 10,
                centeredSlides: true,
                slidesPerView: 3,
                touchRatio: 0.2,
                slideToClickedSlide: true,
                loop: true,
                loopedSlides: 5
            });

            galleryTop.controller.control = galleryThumbs;
            galleryThumbs.controller.control = galleryTop;
        });
    </script>

</body>
</html>

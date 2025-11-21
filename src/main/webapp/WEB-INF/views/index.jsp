<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
    <link rel="stylesheet" href="/assets/css/main-festival3.css" />

    <!-- Swiper CSS -->
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
</head>

<body class="is-preload homepage">

    <!-- =================== HEADER =================== -->
    <!-- header.js 가 /partials/header.html 을 로드한다고 가정 -->
    <div id="site-header"></div>
    <script src="/assets/js/header.js"></script>

    <!-- =================== BANNER : 메인 액션 =================== -->
    <div id="banner-wrapper">
        <div id="banner" class="box container">
            <div class="row">
                <div class="col-7 col-12-medium">
                    <h2>바로 게임하러가자~</h2>
                    <p>전남 곳곳에서 열리는 축제를 배경으로 실시간 술래잡기 게임을 즐겨보세요.</p>
                </div>
                <div class="col-5 col-12-medium">
                    <ul>
                        <li>
                            <a href="/1_Game.html"
                               class="button large icon solid fa-arrow-circle-right">
                                Game Start!
                            </a>
                        </li>
                        <li>
                            <a href="/1_1Rule.html"
                               class="button alt large icon solid fa-question-circle">
                                Game Rule
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <!-- =================== 자유 채팅 영역 =================== -->
    <div id="features-wrapper">
        <div class="container">
            <!-- 가운데 정렬 -->
            <div class="row aln-center">
                <div class="col-4 col-12-medium">
                    <section class="box feature">
                        <div class="inner">
                            <header>
                                <h2>자유채팅</h2>
                                <p>[88명 참여중]</p>
                            </header>
                            <p>
                                축제 현장 후기, 게임 공략, 팀원 모집 등 자유롭게 이야기를 나눠보세요.
                                (실제 채팅 기능은 추후 연동 예정)
                            </p>
                        </div>
                    </section>
                </div>
            </div>
        </div>
    </div>

    	<!-- 축제 -->

    	<div id="main-wrapper">
    	<h3>이런 축제 어떠세요?</h3>
    		<section class="festival-section">

    			<div class="festival-grid">
    				<div class="festival-card">
    					<img class="festival-img" src="/images/pic01.jpg" alt="전남 축제 포스터 1"
    						onerror="this.src='/images/no-image.png';">
    				</div>

    				<div class="festival-card">
    					<img class="festival-img" src="/images/pic01.jpg" alt="전남 축제 포스터 2"
    						onerror="this.src='/images/no-image.png';">
    				</div>

    				<div class="festival-card">
    					<img class="festival-img" src="/images/pic01.jpg" alt="전남 축제 포스터 3"
    						onerror="this.src='/images/no-image.png';">
    				</div>
    			</div>

    			<a href="#" class="button icon fa-file-alt">더 많은 축제 보러가기</a>
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

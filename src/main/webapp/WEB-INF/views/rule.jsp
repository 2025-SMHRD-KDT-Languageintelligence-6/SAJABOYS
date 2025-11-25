<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <title>축제 게임 룰북 허브 · Verti 스타일</title>
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <!-- Verti CSS (사용자가 준 css 파일 경로로 교체) -->
    <link rel="stylesheet" href="/assets/css/main.css" />
    <!-- Font Awesome -->
    <link rel="stylesheet" href="/assets/css/fontawesome-all.min.css" />
</head>
<body class="is-preload">
    <div id="site-header"></div>
    <script src="/assets/js/header.js"></script>
<div id="page-wrapper">

    <!-- Header -->
    <div id="header-wrapper">
        <header id="header" class="container">
            <!-- 필요하면 여기 로고/네비게이션 삽입 -->

        </header>
    </div>

    <!-- 배너 -->
    <div id="banner-wrapper">
        <div class="container">
            <section id="banner" class="box">
                <header>
                    <h2>축제 게임 룰북 허브</h2>
                    <p>좀비 아포칼립스 · 월리를 찾아라 · 도둑과 경찰</p>
                </header>
            </section>
        </div>
    </div>

    <!-- 룰북 3종 소개 -->
    <div id="features-wrapper">
        <div class="container" id="features">
            <div class="row gtr-50">

                <!-- 1. 좀비 아포칼립스 -->
                <div class="col-4 col-12-medium">
                    <section class="box feature">
                        <a href="/rule/zombie" class="image featured" aria-label="좀비 아포칼립스">
                            <img src="images/zombie.png" alt="좀비 아포칼립스 표지" />
                        </a>
                        <div class="inner">
                            <header>
                                <h2>🧟‍♀️ 좀비 아포칼립스</h2>
                                <p>5~10명 · 30~60분 · 생존 추격전</p>
                            </header>
                            <p>
                                생존자 vs 좀비의 서바이벌 게임입니다.
                                좀비는 감염을 넓히고, 생존자는 감염을 피하며 제한 시간까지 살아남아야 합니다.
                                QR과 지도, GPS를 활용해 감염/회복·위치 정보가 실시간으로 반영됩니다.
                            </p>
                            <ul class="actions">
                                <li><a href="/rule/zombie" class="button icon solid fa-book-open">룰북 보기</a></li>
                            </ul>
                        </div>
                    </section>
                </div>

                <!-- 2. 월리를 찾아라 -->
                <div class="col-4 col-12-medium">
                    <section class="box feature">
                        <a href="/rule/wally" class="image featured" aria-label="월리를 찾아라">
                            <img src="images/where's wally.png" alt="월리를 찾아라 표지" />
                        </a>
                        <div class="inner">
                            <header>
                                <h2>🧭 월리를 찾아라!</h2>
                                <p>인원 무제한 · 시간 무제한 · 탐색/인증</p>
                            </header>
                            <p>
                                축제장 곳곳에 숨겨진 ‘월리’ 포인트를 찾아 QR로 인증하는 탐색형 게임입니다.
                                힌트 지도, 위치 정보, 포토 인증을 활용해 가족·연인·친구 누구나 가볍게 즐길 수 있습니다.
                            </p>
                            <ul class="actions">
                                <li><a href="/rule/wally" class="button icon solid fa-book-open">룰북 보기</a></li>
                            </ul>
                        </div>
                    </section>
                </div>

                <!-- 3. 경찰과 도둑 -->
                <div class="col-4 col-12-medium">
                    <section class="box feature">
                        <a href="/rule/police" class="image featured" aria-label="경찰과 도둑">
                            <img src="images/police.png" alt="경찰과 도둑 표지" />
                        </a>
                        <div class="inner">
                            <header>
                                <h2>🚓 경찰과 도둑</h2>
                                <p>4명 이상 · 30~60분 · 팀 기반 추격전</p>
                            </header>
                            <p>
                                선행 출발한 도둑팀과 이를 추격하는 경찰팀의 실시간 추격 게임입니다.
                                도둑은 주어진 시간 동안 잡히지 않으면 승리하고, 경찰은 지도와 QR 체포 규칙을 활용해
                                도둑을 잡아야 합니다.
                            </p>
                            <ul class="actions">
                                <li><a href="/rule/police" class="button icon solid fa-book-open">룰북 보기</a></li>
                            </ul>
                        </div>
                    </section>
                </div>

            </div>
        </div>
    </div>

    <!-- 비교 섹션 -->
    <div id="main-wrapper">
        <div class="container">
            <div class="row">
                <div class="col-12" id="compare">
                    <section class="box">
                        <header>
                            <h2>⚖️ 게임별 빠른 비교</h2>
                            <p>운영 조건과 기능을 한눈에 비교할 수 있습니다.</p>
                        </header>
                        <div class="table-wrapper">
                            <table>
                                <thead>
                                <tr>
                                    <th>구분</th>
                                    <th>좀비 아포칼립스</th>
                                    <th>월리를 찾아라</th>
                                    <th>경찰과 도둑</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <th>권장 인원</th>
                                    <td>5~10명</td>
                                    <td>무제한</td>
                                    <td>4명 이상</td>
                                </tr>
                                <tr>
                                    <th>진행 시간</th>
                                    <td>30~60분</td>
                                    <td>무제한</td>
                                    <td>30~60분</td>
                                </tr>
                                <tr>
                                    <th>핵심 메커닉</th>
                                    <td>감염/생존, 추격</td>
                                    <td>탐색/인증, 힌트</td>
                                    <td>추격/체포, 팀전</td>
                                </tr>
                                <tr>
                                    <th>주요 기능</th>
                                    <td>지도 · QR · 랭킹</td>
                                    <td>QR · GPS · 사진 인증</td>
                                    <td>지도 · QR · 타이머/로그</td>
                                </tr>
                                <tr>
                                    <th>추천 장소</th>
                                    <td>공원 · 캠핑장 · 운동장</td>
                                    <td>축제장 전역</td>
                                    <td>실내/야외(은신 공간 有)</td>
                                </tr>
                                <tr>
                                    <th>하이라이트</th>
                                    <td>긴장감 있는 생존전</td>
                                    <td>포토 스팟 · 인증샷</td>
                                    <td>역할 플레이 · 전략 요소</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </section>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer (필요하면 Verti 푸터 include) -->
    <div id="footer-wrapper">
        <div class="container" id="footer">
            <div id="copyright">
                <ul class="menu">
                    <li>&copy; 추적자들 프로젝트</li>
                    <li>Verti 테마 기반 커스텀</li>
                </ul>
            </div>
        </div>
    </div>

</div>

<!-- Verti 기본 스크립트 (경로 프로젝트에 맞게 수정) -->
<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/jquery.dropotron.min.js"></script>
<script src="/static/js/browser.min.js"></script>
<script src="/static/js/breakpoints.min.js"></script>
<script src="/static/js/util.js"></script>
<script src="/static/js/main.js"></script>

</body>
</html>

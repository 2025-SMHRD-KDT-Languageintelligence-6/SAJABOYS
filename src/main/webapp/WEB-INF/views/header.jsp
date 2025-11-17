<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- JSTL : 자바코드를 활용할 수 있게끔 만들어진 '커스텀 태그 라이브러리' --%>
<%-- JSTL사용법 1) dependency 추가 2)지시자를 이용해서 어떤 라이브러리 사용하는 것인지 명시 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!--헤더 파일을 폴더에 따로 담는게 좋아보임.-->



<!-- ===== header.jsp ===== -->
<!-- Header -->
<div id="header-wrapper">
    <header id="header" class="container">

        <!-- Logo -->
            <div id="logo">
                <h1><a href="main">추적자</a></h1>
                <span>지역축제 술레잡기 게임</span>
            </div>

        <!-- Nav -->
            <nav id="nav">
                <ul>
                    <li class="current"><a href="main">Home</a></li>
                    <li>
                        <a href="/html5up-verti/1_Game.html">게임창</a>
                        <ul>
                            <li><a href="#">좀비게임</a></li>
                            <li><a href="#">윌리를 찾아라</a></li>
                            <li><a href="#">경찰과 도둑</a></li>
                            <li><a href="#">거점점령전</a></li>
                            <li>
                                <a href="/html5up-verti/1_1_5Rule.html">룰 북</a>
                                <ul>
                                    <li><a href="/html5up-verti/1_1_1zombie.html">좀비게임</a></li>
                                    <li><a href="/html5up-verti/1_1_2wily.html">윌리를 찾아라</a></li>
                                    <li><a href="/html5up-verti/1_1_3police.html">경찰과 도둑</a></li>
                                    <li><a href="/html5up-verti/1_1_4occupy.html">거점점령전</a></li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li><a href="#">스템프 투어창</a></li>
                    <li><a href="/html5up-verti/right-sidebar.html">축제 장</a></li>
                    <li><a href="sns">커뮤니티</a></li>
                    <li>
                        <c:choose>
                            <c:when test = "${!empty user}">
                                <a href="update">개인정보수정</a>
                            </c:when>
                            <c:otherwise>
                            </c:otherwise>
                        </c:choose>
                    </li>
                    <li>
                        <c:choose>
                            <c:when test = "${!empty user}">
                                <a href="logout">로그아웃</a>
                            </c:when>
                            <c:otherwise>
                                <a href="login">로그인/회원가입</a>
                            </c:otherwise>
                        </c:choose>
                    </li>
                </ul>
            </nav>

    </header>
</div>

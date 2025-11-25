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
                <a href="/main">
                    <img src="/images/bg.png" style="width: 600px ;">
                </a>
                <nav id="nav">
                                <ul>
                                    <li><a href="/main">Home</a></li>
                                    <li>
                                        <a href="/gameSelect">게임</a>
                                        <ul>
                                            <li><a href="#">게임 룰</a></li>

                                        </ul>
                                    </li>
                                    <li><a href="/stamp">스탬프 투어</a></li>
                                    <li><a href="/festival">축제</a></li>
                                    <li><a href="/sns">커뮤니티</a></li>
                                    <li>
                                        <c:choose>
                                            <c:when test = "${!empty user}">
                                                <a href="/update">개인정보수정</a>
                                            </c:when>
                                            <c:otherwise>
                                            </c:otherwise>
                                        </c:choose>
                                    </li>
                                    <li>
                                        <c:choose>
                                            <c:when test = "${!empty user && user.admin}">
                                                <a href="/update">관리자</a>
                                            </c:when>
                                            <c:otherwise>
                                            </c:otherwise>
                                        </c:choose>
                                    </li>
                                    <li>
                                        <c:choose>
                                            <c:when test = "${!empty user}">
                                                <a href="/logout">로그아웃</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="/login">로그인/회원가입</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </li>
                                </ul>
                            </nav>
            </div>

        <!-- Nav -->


    </header>
</div>

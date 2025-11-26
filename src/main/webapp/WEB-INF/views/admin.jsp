<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>윌리를 찾아라 관리 | 추적자 관리자</title>

    <!-- Verti 기본 CSS -->
    <link rel="stylesheet" href="/assets/css/main.css" />

    <style>
        /* 메인 레이아웃 설정 */
        .wally-admin-layout {
            max-width: 1200px;
            margin: 2rem auto 3rem;
            padding: 0 1rem;
            display: grid;
            grid-template-columns: 1.3fr 1.7fr;
            gap: 1.5rem;
        }

        /* 각 패널 디자인 */
        .admin-panel {
            background: #ffffff;
            border-radius: 14px;
            padding: 1.4rem 1.6rem;
            box-shadow: 0 8px 20px rgba(15, 23, 42, 0.08);
        }

        .admin-panel + .admin-panel {
            margin-top: 1rem;
        }

        .admin-panel h2 {
            margin: 0 0 .6rem;
            font-size: 1.3rem;
            font-weight: 800;
        }

        .admin-panel p.sub {
            margin: 0 0 1rem;
            font-size: 0.9rem;
            color: #6b7280;
        }

        /* 필드 그룹 스타일 */
        .field-group {
            display: flex;
            flex-direction: column;
            gap: 0.35rem;
            margin-bottom: 1rem;
        }

        .field-group label {
            font-weight: 600;
            font-size: 0.95rem;
        }

        .field-group input[type="text"],
        .field-group input[type="number"],
        .field-group input[type="file"],
        .field-group textarea {
            font-size: 0.95rem;
            padding: 0.45rem 0.55rem;
            border-radius: 8px;
            border: 1px solid #d1d5db;
            background: #f9fafb;
        }

        .field-group small {
            font-size: 0.8rem;
            color: #9ca3af;
        }

        /* 버튼 행 스타일 */
        .btn-row {
            display: flex;
            flex-wrap: wrap;
            gap: 0.6rem;
            margin-top: 0.3rem;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0.45rem 0.9rem;
            border-radius: 999px;
            border: none;
            cursor: pointer;
            font-size: 0.9rem;
            font-weight: 600;
            text-decoration: none;
            white-space: nowrap;
        }

        .btn-primary {
            background: #fb923c;
            color: #fff;
        }

        .btn-secondary {
            background: #e5e7eb;
            color: #374151;
        }

        /* 썸네일 이미지 스타일 */
        .thumbnail {
            width: 100%;
            max-width: 220px;
            aspect-ratio: 3/4;
            border-radius: 12px;
            border: 1px dashed #d1d5db;
            background: #f9fafb;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.85rem;
            color: #9ca3af;
            overflow: hidden;
            margin-top: 0.4rem;
        }

        .thumbnail img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        /* QR 코드 미리보기 */
        .qr-preview {
            width: 140px;
            height: 140px;
            border-radius: 16px;
            border: 1px dashed #d1d5db;
            background: #f9fafb;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.85rem;
            color: #9ca3af;
            overflow: hidden;
            margin-top: 0.4rem;
        }

        .qr-preview img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }

        /* 오른쪽 영역 패널 */
        .wally-right-column .admin-panel {
            height: 100%;
        }

        /* 테이블 스타일 */
        .finder-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.9rem;
            margin-top: 0.5rem;
        }

        .finder-table thead {
            background: #f3f4f6;
        }

        .finder-table th,
        .finder-table td {
            border: 1px solid #e5e7eb;
            padding: 0.4rem 0.5rem;
            text-align: center;
        }

        .finder-table tbody tr:nth-child(even) {
            background: #f9fafb;
        }

        .festival-note {
            font-size: 0.8rem;
            color: #6b7280;
            margin-top: 0.25rem;
        }

        /* 반응형 디자인 */
        @media (max-width: 900px) {
            .wally-admin-layout {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body class="is-preload">

<div id="page-wrapper">

    <!-- (필요하다면 공용 헤더 include) -->
    <div id="site-header"></div>
    <script src="/assets/js/header.js"></script>

    <section class="container">


        <div class="wally-admin-layout">

            <!-- 좌측 : 윌리 & QR 관리 -->
            <div>

                <!-- 오늘의 윌리 설정 -->
                <div class="admin-panel">
                    <h2>1. 오늘의 윌리 설정</h2>
                    <p class="sub">INDEX 화면에 노출될 윌리 사진을 업로드합니다.</p>

                    <form id="wallyImageForm" method="post" enctype="multipart/form-data" action="/admin/wallyImage">
                        <div class="field-group">
                            <label for="wallyImage">윌리 사진 업로드</label>
                            <input type="file" id="wallyImage" name="wallyImage" accept="image/*" />
                            <small>※ 세로형(예: 3:4 비율)의 축제장 사진을 권장합니다.</small>
                        </div>

                        <div class="thumbnail" id="wallyImagePreview">
                            <!-- 현재 등록된 윌리 이미지가 있으면 <img src="..."> 로 채워주세요 -->
                            <c:if test="${not empty sessionScope.wallyImagePath}">
                                <img src="${sessionScope.wallyImagePath}" alt="오늘의 윌리" />
                            </c:if>
                            <c:if test="${empty sessionScope.wallyImagePath}">
                                현재 등록된 윌리 이미지 없음
                            </c:if>
                        </div>

                        <div class="btn-row">
                            <button type="submit" class="btn btn-primary">윌리 이미지 저장</button>
                        </div>
                    </form>
                </div>

                <!-- QR 코드 관리 -->
                <div class="admin-panel">
                    <h2>2. 축제 QR 코드</h2>
                    <button class="button alt" onclick="location.href='/stamp/createQr'">축제 QR 코드 생성하기</button>
                    <button class="button alt" onclick="location.href='/wally/createQr'">월리 QR 코드 생성하기</button>
                </div>
            </div>

            <!-- 우측 : 참여자 목록 & 축제 장소 -->
            <div class="wally-right-column">

                <div class="admin-panel">
                    <h2>3. 월리가 있는 축제 장소</h2>
                    <p class="sub">
                        오늘의 윌리가 숨어 있는 축제장을 지정합니다.<br>
                        <strong>※ 축제장 사진은 따로 업로드하지 않고, DB에서 검색해 가져옵니다.</strong>
                    </p>

                    <form id="wallyFestivalForm" method="post" action="/admin/festival">
                        <div class="field-group">
                            <label for="festivalName">축제장 이름</label>
                            <input type="text" id="festivalName" name="festivalName" placeholder="예) 순천 불빛축제" />
                        </div>

                        <div class="field-group">
                            <label for="festivalId">축제장 번호 (DB 키값)</label>
                            <input type="number" id="festivalId" name="festivalId" placeholder="예) 103 (tb_festival.fes_idx)" />
                            <p class="festival-note">
                                · 입력한 축제장 번호로 DB에서 축제 정보를 조회하여 INDEX &lt;윌리가 있는 축제장&gt; 영역에 자동 반영됩니다.
                            </p>
                        </div>

                        <div class="btn-row">
                            <button type="submit" class="btn btn-primary">윌리 위치 저장</button>
                            <button type="button" class="btn btn-secondary">축제 검색 팝업 열기 (추후 구현)</button>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </section>
</div>

</body>
</html>

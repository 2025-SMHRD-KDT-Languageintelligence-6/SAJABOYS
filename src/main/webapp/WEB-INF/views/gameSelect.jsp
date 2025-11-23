<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>방 선택 | 거점 탐험전</title>
    <link rel="stylesheet" href="/assets/css/main.css">
    <link rel="stylesheet" href="/assets/css/game-select.css">
</head>
<body>

<div id="page-wrapper">
    <main class="select-layout">
        <div class="select-grid">

            <!-- 방 목록 -->
            <section class="wait-box">
                <h3>생성된 방</h3>
                <p>현재 활성화된 게임 방 목록</p>
                <div class="wait-num" id="waitCount">
                    <c:out value="${fn:length(roomList)}"/> 개
                </div>

                <div class="room-list" id="roomListContainer">
                    <c:choose>
                        <c:when test="${empty roomList}">
                            <p>현재 생성된 방이 없습니다.</p>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="room" items="${roomList}">
                                <div class="room-item">
                                    <strong>${room.title}</strong><br>
                                    <span>모드: ${room.mode}</span><br>
                                    <span>${room.current}/${room.max != null ? room.max : '-' } 명</span>
                                    <button onclick="enterRoom('${room.id}')">입장</button>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </section>

            <!-- 방 생성 -->
            <section class="game-select-box">
                <h2>방 만들기</h2>
                <form id="createRoomForm">
                    <div class="mode-wrap">
                        <label class="mode-option">
                            <input type="radio" name="mode" value="police" required>
                            <strong>🥷 술래잡기 (도둑과 경찰)</strong>
                        </label>
                        <label class="mode-option">
                            <input type="radio" name="mode" value="zombie">
                            <strong>🧟 좀비 아포칼립스</strong>
                        </label>
                    </div>

                    <input type="text" name="title" placeholder="방 제목 입력" required>
                    <input type="number" name="max" placeholder="최대 인원 수 입력 (선택)" min="2">
                    <input type="password" name="password" placeholder="비밀번호 (선택)">

                    <button type="submit" class="start-btn">방 만들기</button>
                </form>
            </section>

        </div>
    </main>
</div>

<script>
    // 방 입장
    function enterRoom(roomId){
        location.href = "/room/enter?roomId=" + roomId;
    }

    // 방 생성
    document.getElementById("createRoomForm").addEventListener("submit", function(e){
        e.preventDefault();
        const formData = new FormData(this);

        fetch("/room/create", {
            method: "POST",
            body: formData
        })
        .then(r => r.json())
        .then(data => {
            if(data.success){
                location.href = "/room/enter?roomId=" + data.roomId;
            } else {
                alert("방 생성 실패: " + data.message);
            }
        });
    });

    // 방 목록 갱신 함수
    function refreshRoomList() {
        fetch("/room/list/json")
            .then(res => res.json())
            .then(roomList => {
                const container = document.getElementById("roomListContainer");
                const waitCount = document.getElementById("waitCount");
                container.innerHTML = ""; // 기존 목록 초기화

                if(roomList.length === 0) {
                    container.innerHTML = "<p>현재 생성된 방이 없습니다.</p>";
                } else {
                    roomList.forEach(room => {
                        const div = document.createElement("div");
                        div.className = "room-item";
                        div.innerHTML = `<strong>${room.title}</strong><br>
                                         <span>모드: ${room.mode}</span><br>
                                         <span>${room.current}/${room.max != null ? room.max : '-' } 명</span>
                                         <button onclick="enterRoom('${room.id}')">입장</button>`;
                        container.appendChild(div);
                    });
                }

                waitCount.textContent = roomList.length + " 개";
            });
    }

    // 3초마다 방 목록 갱신
    setInterval(refreshRoomList, 3000);
</script>

</body>
</html>

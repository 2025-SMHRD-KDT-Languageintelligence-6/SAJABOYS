<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게임방 선택 | 거점 탐험전</title>
    <link rel="stylesheet" href="/assets/css/main.css">
    <link rel="stylesheet" href="/assets/css/game-select.css">
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
</head>
<body>
<div id="page-wrapper">
    <main class="select-layout">
        <div class="select-grid">

            <!-- 좌측: 방 목록 -->
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
                                    <strong><c:out value="${room.title}"/></strong><br>
                                    <span>모드: <c:out value="${room.mode}"/></span><br>
                                    <span><c:out value="${room.current}"/>/<c:out value="${room.max}"/> 명</span><br>
                                    <span>비밀번호:
                                        <c:choose>
                                            <c:when test="${not empty room.password}">있음</c:when>
                                            <c:otherwise>없음</c:otherwise>
                                        </c:choose>
                                    </span><br>
                                    <button onclick="enterRoom('<c:out value="${room.id}"/>')">입장</button>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </section>

            <!-- 우측: 방 생성 -->
            <section class="game-select-box">
                <h2>방 만들기</h2>
                <form id="createRoomForm">
                    <div class="mode-wrap">
                        <label class="mode-option">
                            <input type="radio" name="mode" value="police" required>
                            <strong>🥷 술래잡기 (경찰과 도둑)</strong>
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
const userNickname = "${user.nickname}";
let roomId = null;

// 방 입장
function enterRoom(rid){
    roomId = rid;
    location.href = "/room/game?roomId=" + rid;
}

// 방 생성 + 자동 입장
document.getElementById("createRoomForm").addEventListener("submit", function(e){
    e.preventDefault();
    const formData = new FormData(this);
    fetch("/room/createAndEnter", {method: "POST", body: formData})
        .then(r => r.json())
        .then(data => {
            if(data.success){
                enterRoom(data.roomId);
            } else {
                alert("방 생성 실패: " + data.message);
            }
        })
        .catch(e => console.error(e));
});

// 방 목록 자동 갱신
function refreshRoomList() {
    fetch("/room/list/json")
        .then(res => res.json())
        .then(roomList => {
            const container = document.getElementById("roomListContainer");
            const waitCount = document.getElementById("waitCount");
            container.innerHTML = "";
            if(roomList.length === 0){
                container.innerHTML = "<p>현재 생성된 방이 없습니다.</p>";
            } else {
                roomList.forEach(room => {
                    const div = document.createElement("div");
                    div.className = "room-item";
                    div.innerHTML = `<strong>\${room.title}</strong><br>
                                     <span>모드: \${room.mode}</span><br>
                                     <span>\${room.current}/\${room.max != null ? room.max : '-' } 명</span><br>
                                     <span>비밀번호: \${room.password ? '있음' : '없음'}</span><br>
                                     <button onclick="enterRoom('\${room.id}')">입장</button>`;

                    // 실제 값으로 치환
                    div.innerHTML = div.innerHTML
                        .replace("\${room.title}", room.title)
                        .replace("\${room.mode}", room.mode)
                        .replace("\${room.current}", room.current)
                        .replace("\${room.max}", room.max != null ? room.max : "-")
                        .replace("\${room.password}", room.password)
                        .replace("\${room.id}", room.id);

                    container.appendChild(div);
                });
            }
            waitCount.textContent = roomList.length + " 개";
        })
        .catch(e => console.error(e));
}
setInterval(refreshRoomList, 3000);
</script>
</body>
</html>

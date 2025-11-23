<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게임방</title>
    <link rel="stylesheet" href="/assets/css/game-room.css">
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
</head>
<body>
<div class="gr-layout">

    <section class="gr-info-box">
        <h2 id="roomTitle"><c:out value="${room.title}"/></h2>
        <p class="gr-sub">모드: <span id="roomMode"><c:out value="${room.mode}"/></span></p>
        <p class="gr-sub">인원: <span id="playerCount"><c:out value="${room.current}"/></span>/<span id="maxCount"><c:out value="${room.max != null ? room.max : '-'}"/></span></p>
        <p class="gr-sub">비밀번호: <span id="roomPassword"><c:choose><c:when test="${not empty room.password}">있음</c:when><c:otherwise>없음</c:otherwise></c:choose></span></p>
        <hr class="gr-divider">
        <h3 class="gr-player-title">참여 플레이어</h3>
        <ul id="playerList" class="gr-player-list">
            <c:forEach var="player" items="${room.players}">
                <li><c:out value="${player}"/></li>
            </c:forEach>
        </ul>
        <button id="leaveRoomBtn" class="gr-leave-btn">방 나가기</button>
    </section>

    <section class="gr-chat-box">
        <h3>채팅</h3>
        <div id="chatMessages" class="gr-chat-messages"></div>
        <div class="gr-chat-input-wrap">
            <input type="text" id="chatInput" placeholder="메시지 입력..." class="gr-chat-input">
            <button id="sendBtn" class="gr-chat-send-btn">전송</button>
        </div>
    </section>
</div>

<script>
const roomId = "<c:out value='${room.id}'/>";
const userNickname = "<c:out value='${user.nickname}'/>";

// 플레이어 리스트는 JSP에서 렌더링한 그대로 사용
const ul = document.getElementById("playerList");

const socket = new SockJS('/ws');
const stompClient = Stomp.over(socket);

stompClient.connect({}, function(frame) {

    // 방 상태 구독
    stompClient.subscribe('/topic/room/' + roomId + '/state', function(message) {
        const data = JSON.parse(message.body);
        const players = Array.isArray(data.players) ? data.players : [];

        // 플레이어 리스트 갱신
        ul.innerHTML = "";
        players.forEach(p => {
            const li = document.createElement("li");
            li.textContent = p;
            ul.appendChild(li);
        });

        // 인원 / 비밀번호 업데이트
        document.getElementById("playerCount").textContent = players.length;
        document.getElementById("roomPassword").textContent = data.password ? '있음' : '없음';
    });

    // 채팅 구독
    stompClient.subscribe('/topic/room/' + roomId + '/chat', function(message) {
        const chat = JSON.parse(message.body);
        const div = document.createElement("div");
        div.textContent = chat.type === 'chat' ? chat.sender + ": " + chat.message : chat.message;
        document.getElementById("chatMessages").appendChild(div);
        document.getElementById("chatMessages").scrollTop = document.getElementById("chatMessages").scrollHeight;
    });

    // 입장 메시지 전송
    stompClient.send("/app/chat", {}, JSON.stringify({
        type: "join",
        roomId: roomId,
        sender: userNickname
    }));
});

// 채팅 전송
document.getElementById("sendBtn").addEventListener("click", function(){
    const msg = document.getElementById("chatInput").value.trim();
    if(!msg) return;
    stompClient.send("/app/chat", {}, JSON.stringify({
        type: "chat",
        roomId: roomId,
        sender: userNickname,
        message: msg
    }));
    document.getElementById("chatInput").value = "";
});

// 방 나가기
document.getElementById("leaveRoomBtn").addEventListener("click", function(){
    fetch("/room/leave", {
        method: "POST",
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: new URLSearchParams({roomId})
    })
    .then(r => r.json())
    .then(data => {
        if(data.success) location.href = "/room/list";
        else alert("방 나가기 실패: " + data.message);
    });
});
</script>
</body>
</html>

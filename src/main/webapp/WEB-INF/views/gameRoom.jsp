<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게임방</title>
    <link rel="stylesheet" href="/assets/css/game-room.css">
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
</head>
<body>
<div class="gr-layout">

    <!-- 좌측 상태 -->
    <section class="gr-info-box">
        <h2 id="roomTitle"><c:out value="${room.title}"/></h2>
        <p class="gr-sub">모드: <span id="roomMode"><c:out value="${room.mode}"/></span></p>
        <p class="gr-sub">인원: <span id="playerCount"><c:out value="${room.current}"/></span>/<span id="maxCount"><c:out value="${room.max != null ? room.max : '-'}"/></span></p>
        <p class="gr-sub">비밀번호: <span id="roomPassword">${room.password != null && room.password != '' ? '있음' : '없음'}</span></p>
        <hr class="gr-divider">
        <h3 class="gr-player-title">참여 플레이어</h3>
        <ul id="playerList" class="gr-player-list"></ul>
        <button id="leaveRoomBtn" class="gr-leave-btn">방 나가기</button>
    </section>

    <!-- 우측 채팅 -->
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
// 안전하게 JSP EL을 JS 변수로 전달
const roomId = "<c:out value='${room.id}'/>";
const userNickname = "<c:out value='${user.nickname}'/>";
const initialPlayers = JSON.parse('${playersJson != null && playersJson != "" ? playersJson : "[]"}');
const ul = document.getElementById("playerList");

// 초기 렌더링
initialPlayers.forEach(p => {
    const li = document.createElement("li");
    li.textContent = p;
    ul.appendChild(li);
});

// WebSocket 연결 설정
const socket = new SockJS('/ws');
const stompClient = Stomp.over(socket);

stompClient.connect({}, function(frame) {
    // 방 상태 구독
    stompClient.subscribe('/topic/room/' + roomId + '/state', function(message) {
        const data = JSON.parse(message.body);
        const players = Array.isArray(data.players) ? data.players : [];
        ul.innerHTML = "";
        players.forEach(p => {
            const li = document.createElement("li");
            li.textContent = p;
            ul.appendChild(li);
        });

        document.getElementById("playerCount").textContent = data.current ?? players.length;
        document.getElementById("roomPassword").textContent = data.password ? '있음' : '없음';
    });

    // 채팅 구독
    stompClient.subscribe('/topic/room/' + roomId + '/chat', function(message) {
        const chat = JSON.parse(message.body);
        const div = document.createElement("div");

        if (chat.type === 'join') {
            // 입장 메시지 처리
            div.textContent = chat.message;  // 예: "나다님이 입장했습니다."
        } else if (chat.type === 'leave') {
            // 퇴장 메시지 처리
            div.textContent = chat.message;
            const ul = document.getElementById("playerList");
            ul.innerHTML = "";
            chat.players.forEach(p => {
                const li = document.createElement("li");
                li.textContent = p;
                ul.appendChild(li);
            });
        } else {
            // 일반 채팅 메시지 처리
            div.textContent = chat.sender + ": " + chat.message;
        }

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
    const input = document.getElementById("chatInput");
    const msg = input.value.trim();
    if (msg === "") return;
    stompClient.send("/app/chat", {}, JSON.stringify({
        type: "chat",
        roomId: roomId,
        sender: userNickname,
        message: msg
    }));
    input.value = "";
});

// 방 나가기
document.getElementById("leaveRoomBtn").addEventListener("click", function(){
    fetch("/room/leave", {
        method: "POST",
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({ roomId: roomId, nickname: userNickname })
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) {
            location.href = "/room/list";  // 방 나가면 방 목록 페이지로 이동
        } else {
            alert("방 나가기 실패: " + data.message);
        }
    });
});

// 페이지 벗어날 때도 방 나가기 요청 보내기
window.addEventListener("beforeunload", function(event) {
    if (roomId && userNickname && stompClient && stompClient.connected) {
        stompClient.send("/app/chat", {}, JSON.stringify({
            type: "leave",
            roomId: roomId,
            sender: userNickname
        }));

        // 서버로 leave 요청
        const data = new URLSearchParams({ roomId, nickname: userNickname });
        navigator.sendBeacon('/room/leave', data);
    }
});
</script>

</body>
</html>

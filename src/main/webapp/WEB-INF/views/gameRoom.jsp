<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

        <label for="teamSelect">팀 선택:</label>
        <select id="teamSelect">
            <option value="red">빨강팀 (잡는팀)</option>
            <option value="blue">파랑팀 (잡히는팀)</option>
        </select>
        <button id="startGameBtn" class="gr-start-btn">게임 시작</button>
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

<!-- 카카오 지도 API -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=96386b6e873f709dc1378cbf43e8fff6&libraries=services"></script>

<script>
const roomId = "<c:out value='${room.id}'/>";
const userNickname = "<c:out value='${user.nickname}'/>";
const initialPlayers = ${playersJson != null && playersJson != "" ? playersJson : "[]"};
const ul = document.getElementById("playerList");
let map;
const markers = {};
let userTeam = 'red'; // 기본 빨강
let gameStarted = <c:out value='${room.gameStarted != null ? room.gameStarted : false}'/>;

// 초기 플레이어 렌더링
initialPlayers.forEach(p => {
    const li = document.createElement("li");
    li.textContent = p;
    ul.appendChild(li);
});

// 팀 선택 이벤트
document.getElementById("teamSelect").addEventListener("change", function() {
    userTeam = this.value;
});

// WebSocket 연결
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
        if(data.gameStarted) gameStarted = true;
    });

    // 채팅 구독
    stompClient.subscribe('/topic/room/' + roomId + '/chat', function(message) {
        const chat = JSON.parse(message.body);
        const div = document.createElement("div");
        div.textContent = chat.type === 'chat' ? chat.sender + ": " + chat.message : chat.message;
        document.getElementById("chatMessages").appendChild(div);
        document.getElementById("chatMessages").scrollTop = document.getElementById("chatMessages").scrollHeight;
    });

    // 위치 구독
    stompClient.subscribe('/topic/room/' + roomId + '/location', function(message) {
        const data = JSON.parse(message.body);
        data.forEach(p => {
            const color = p.nickname === userNickname ? 'green' : p.team; // 자기: 초록, 팀원: 팀 색
            const markerImage = new kakao.maps.MarkerImage(
                '/images/marker-' + color + '.png',
                new kakao.maps.Size(32, 32)
            );
            if (!markers[p.nickname]) {
                markers[p.nickname] = new kakao.maps.Marker({
                    position: new kakao.maps.LatLng(p.lat, p.lng),
                    map: map,
                    title: p.nickname,
                    image: markerImage
                });
            } else {
                markers[p.nickname].setPosition(new kakao.maps.LatLng(p.lat, p.lng));
                markers[p.nickname].setImage(markerImage);
            }
        });
    });

    // 게임 시작 구독
    stompClient.subscribe('/topic/room/' + roomId + '/game', function(message) {
        const data = JSON.parse(message.body);
        if (data.type === "start") {
            gameStarted = true;
            startGameUIBasic();
            const interval = setInterval(() => {
                if (typeof kakao !== "undefined" && kakao.maps) {
                    clearInterval(interval);
                    initRealtimeMap();
                }
            }, 100);
        }
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
        message: msg,
        team: userTeam
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
            location.href = "/room/list";
        } else {
            alert("방 나가기 실패: " + data.message);
        }
    });
});

// 게임 시작 버튼
document.getElementById("startGameBtn").addEventListener("click", function() {
    if(gameStarted) return;
    fetch("/room/game/start", {
        method: "POST",
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ roomId: roomId, sender: userNickname, team: userTeam })
    })
    .then(r => r.json())
    .then(data => {
        if(!data.success){
            alert("게임 시작 실패: " + data.message);
        }
    })
    .catch(console.error);
});

// 게임 UI 기본 전환
function startGameUIBasic() {
    document.querySelector(".gr-info-box").style.display = "none";
    const gameArea = document.createElement("div");
    gameArea.id = "gameArea";
    gameArea.innerHTML = `
        <h2>게임 시작!</h2>
        <p>실시간 위치 기반 지도</p>
        <div id="map" style="width:100%;height:400px;"></div>
    `;
    document.querySelector(".gr-layout").appendChild(gameArea);
}

// 지도 초기화 + 실시간 위치 전송
function initRealtimeMap() {
    if (!navigator.geolocation) {
        alert("GPS를 지원하지 않는 브라우저입니다.");
        return;
    }

    navigator.geolocation.getCurrentPosition(function(position) {
        const lat = position.coords.latitude;
        const lng = position.coords.longitude;
        const mapContainer = document.getElementById('map');
        const mapOption = { center: new kakao.maps.LatLng(lat, lng), level: 3 };
        map = new kakao.maps.Map(mapContainer, mapOption);

        // 자기 마커
        markers[userNickname] = new kakao.maps.Marker({
            position: new kakao.maps.LatLng(lat, lng),
            map: map,
            title: userNickname,
            image: new kakao.maps.MarkerImage(
                '/assets/img/marker-green.png',
                new kakao.maps.Size(32,32)
            )
        });

        // 위치 전송
        stompClient.send("/app/room/" + roomId + "/location", {}, JSON.stringify({
            nickname: userNickname,
            lat: lat,
            lng: lng,
            team: userTeam
        }));
    });

    navigator.geolocation.watchPosition(function(position) {
        const lat = position.coords.latitude;
        const lng = position.coords.longitude;
        if (markers[userNickname]) markers[userNickname].setPosition(new kakao.maps.LatLng(lat, lng));

        stompClient.send("/app/room/" + roomId + "/location", {}, JSON.stringify({
            nickname: userNickname,
            lat: lat,
            lng: lng,
            team: userTeam
        }));
    }, function(error) {
        console.error("위치 추적 오류:", error);
    }, { enableHighAccuracy: true, maximumAge: 0, timeout: 5000 });
}

// 페이지 벗어날 때 방 나가기
window.addEventListener("beforeunload", function(event) {
    if (roomId && userNickname && stompClient && stompClient.connected) {
        stompClient.send("/app/chat", {}, JSON.stringify({
            type: "leave",
            roomId: roomId,
            sender: userNickname
        }));
        const data = new URLSearchParams({ roomId, nickname: userNickname });
        navigator.sendBeacon('/room/leave', data);
    }
});
</script>
</body>
</html>

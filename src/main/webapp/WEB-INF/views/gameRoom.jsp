<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게임방</title>

    <!-- 방 선택 CSS 제거! -->
    <!-- <link rel="stylesheet" href="/assets/css/game-select.css"> -->

    <!-- 게임룸 전용 CSS -->
    <link rel="stylesheet" href="/assets/css/game-room.css">
</head>
<body>

<div class="gr-layout">

    <!-- 좌측: 방 정보 + 플레이어 목록 -->
    <section class="gr-info-box">
        <h2>${room.title}</h2>
        <p class="gr-sub">모드: ${room.mode}</p>
        <p class="gr-sub">인원: ${room.current}/${room.max != null ? room.max : '-'} 명</p>
        <p class="gr-sub">비밀번호: <c:out value="${room.password != null ? '있음' : '없음'}"/></p>

        <hr class="gr-divider">

        <h3 class="gr-player-title">참여 플레이어</h3>
        <ul class="gr-player-list">
            <c:forEach var="player" items="${room.players}">
                <li>${player}</li>
            </c:forEach>
        </ul>

        <button id="leaveRoomBtn" class="gr-leave-btn">방 나가기</button>
    </section>

    <!-- 우측: 채팅 -->
    <section class="gr-chat-box">
        <h3>채팅</h3>

        <div id="chatMessages" class="gr-chat-messages">
        </div>

        <div class="gr-chat-input-wrap">
            <input type="text" id="chatInput" placeholder="메시지 입력..." class="gr-chat-input">
            <button id="sendBtn" class="gr-chat-send-btn">전송</button>
        </div>
    </section>

</div>

<script>
    const roomId = "${room.id}";
    const userNickname = "${user.nickname}";

    // ===== 방 나가기 처리 =====
    document.getElementById("leaveRoomBtn").addEventListener("click", function(){
        fetch("/room/leave", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: "roomId=" + roomId
        })
        .then(r => r.json())
        .then(data => {
            if(data.success){
                location.href = "/room/list";
            } else {
                alert("방 나가기 실패: " + data.message);
            }
        });
    });

    // ===== 채팅 (임시) =====
    document.getElementById("sendBtn").addEventListener("click", function(){
        const input = document.getElementById("chatInput");
        const msg = input.value.trim();
        if(msg === "") return;

        const chatMessages = document.getElementById("chatMessages");
        const div = document.createElement("div");
        div.textContent = userNickname + ": " + msg;

        chatMessages.appendChild(div);
        input.value = "";
        chatMessages.scrollTop = chatMessages.scrollHeight;
    });
</script>

</body>
</html>
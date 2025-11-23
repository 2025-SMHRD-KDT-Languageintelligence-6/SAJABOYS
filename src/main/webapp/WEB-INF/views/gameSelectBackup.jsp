<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>방 선택 | 거점 탐험전</title>

  <!-- CSS -->
  <link rel="stylesheet" href="/assets/css/main.css" />
  <link rel="stylesheet" href="/assets/css/game-select.css" />
</head>

<body class="is-preload">

  <!-- header -->
  <div id="site-header"></div>
  <script src="/assets/js/header.js"></script>

  <div id="page-wrapper">
    <main class="select-layout">
      <div class="select-grid">

        <!-- 왼쪽: 방 목록 -->
        <section class="wait-box">
          <h3>생성된 방</h3>
          <p>현재 활성화된 게임 방 목록</p>
          <div class="wait-num" id="waitCount">
            <c:out value="${fn:length(roomList)}"/> 개
          </div>

          <div class="room-list">
            <c:choose>
              <c:when test="${empty roomList}">
                <p>현재 생성된 방이 없습니다.</p>
              </c:when>
              <c:otherwise>
                <c:forEach var="room" items="${roomList}">
                  <div class="room-item">
                    <strong>${room.title}</strong><br>
                    <span>모드: ${room.mode}</span><br>
                    <span>${room.current}/${room.max} 명</span>
                    <button onclick="enterRoom('${room.id}')">입장</button>
                  </div>
                </c:forEach>
              </c:otherwise>
            </c:choose>
          </div>
        </section>

        <!-- 가운데: 방 생성 -->
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
              <label class="mode-option">
                <input type="radio" name="mode" value="wally">
                <strong>🕵️ 월리를 찾아라</strong>
              </label>
            </div>

            <input type="text" name="title" placeholder="방 제목 입력" required
              style="margin-top:20px;width:100%;padding:12px;border-radius:12px;border:1px solid #ccc;box-sizing:border-box;">

            <button type="submit" class="start-btn">방 만들기</button>
          </form>
        </section>

        <!-- 오른쪽: 채팅 -->
        <section class="chat-box">
          <h3>자유 채팅</h3>
          <div id="chatArea" class="chat-area"></div>

          <div class="chat-num">
            <input id="chatInput" type="text" placeholder="메시지를 입력하세요" style="width:80%;padding:8px;border-radius:999px;border:none;box-sizing:border-box;">
            <button onclick="sendMsg()" style="padding:8px 16px;border-radius:999px;border:none;background:#FFD75E;cursor:pointer;margin-left:4px;">전송</button>
          </div>
        </section>

      </div>
    </main>

    <!-- 푸터 -->
    <div id="footer-wrapper">
      <div class="container" id="footer">
        <div id="copyright">
          <ul class="menu">
            <li>&copy; 2025 RunBack</li>
            <li>방 선택 페이지</li>
          </ul>
        </div>
      </div>
    </div>
  </div>

  <!-- JS: 방 입장 -->
  <script>
    function enterRoom(roomId){
      location.href = "/room/enter?roomId=" + roomId;
    }
  </script>

  <!-- JS: 방 생성 fetch API -->
  <script>
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
          alert("방이 생성되었습니다!");
          location.href = "/room/enter?roomId=" + data.roomId;
        } else {
          alert("방 생성 실패: " + data.message);
        }
      });
    });
  </script>

  <!-- WebSocket 채팅 -->
  <script>
    let ws = new WebSocket("wss://your-server/chat");

    ws.onmessage = (msg) => {
      const chatArea = document.getElementById("chatArea");
      let div = document.createElement("div");
      div.textContent = msg.data;
      chatArea.appendChild(div);
      chatArea.scrollTop = chatArea.scrollHeight;
    };

    function sendMsg(){
      const input = document.getElementById("chatInput");
      if(input.value.trim() === "") return;
      if(ws.readyState === WebSocket.OPEN){
        ws.send(input.value);
        input.value = "";
      } else {
        alert("채팅 서버에 연결되어 있지 않습니다.");
      }
    }
  </script>

</body>
</html>

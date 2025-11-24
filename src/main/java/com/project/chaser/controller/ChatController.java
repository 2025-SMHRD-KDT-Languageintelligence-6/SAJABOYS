package com.project.chaser.controller;

import com.project.chaser.dto.Chat;
import com.project.chaser.dto.GameStartMessage;
import com.project.chaser.dto.Room;
import com.project.chaser.service.RoomService;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import java.util.Map;

@Controller
public class ChatController {

    private final RoomService roomService;
    private final SimpMessagingTemplate messagingTemplate;

    public ChatController(RoomService roomService, SimpMessagingTemplate messagingTemplate) {
        this.roomService = roomService;
        this.messagingTemplate = messagingTemplate;
    }

    @MessageMapping("/chat")
    public void handleMessage(Chat chat) {
        switch (chat.getType()) {
            case "join":
                roomService.enterRoom(chat.getRoomId(), chat.getSender());
                chat.setMessage(chat.getSender() + "님이 입장했습니다.");
                chat.setPlayers(roomService.getPlayers(chat.getRoomId()));
                messagingTemplate.convertAndSend("/topic/room/" + chat.getRoomId() + "/state", chat);
                messagingTemplate.convertAndSend("/topic/room/" + chat.getRoomId() + "/chat", chat);
                break;

            case "chat":
                messagingTemplate.convertAndSend("/topic/room/" + chat.getRoomId() + "/chat", chat);
                break;

            case "leave":
                roomService.leaveRoom(chat.getRoomId(), chat.getSender());
                chat.setMessage(chat.getSender() + "님이 퇴장했습니다.");
                chat.setPlayers(roomService.getPlayers(chat.getRoomId()));
                messagingTemplate.convertAndSend("/topic/room/" + chat.getRoomId() + "/state", chat);
                messagingTemplate.convertAndSend("/topic/room/" + chat.getRoomId() + "/chat", chat);
                break;
        }
    }

    // ⭐ 게임 시작 메시지 처리 추가
    @MessageMapping("/game/start")
    public void startGame(GameStartMessage msg) {
        // DB 업데이트 제거 → 그냥 브로드캐스트만
        // roomService.startGame(msg.getRoomId());

        // 방 전체에 게임 시작 메시지 브로드캐스트
        messagingTemplate.convertAndSend(
                "/topic/room/" + msg.getRoomId() + "/game",
                Map.of(
                        "type", "start",
                        "roomId", msg.getRoomId(),
                        "sender", msg.getSender()
                )
        );

        System.out.println("게임 시작 메시지 브로드캐스트: " + msg.getRoomId());
    }
}

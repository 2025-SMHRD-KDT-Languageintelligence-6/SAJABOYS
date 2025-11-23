package com.project.chaser.controller;

import com.project.chaser.dto.Chat;
import com.project.chaser.service.RoomService;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

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
                sendStateAndChat(chat);
                break;

            case "leave":
                roomService.leaveRoom(chat.getRoomId(), chat.getSender());
                chat.setMessage(chat.getSender() + "님이 퇴장했습니다.");
                sendStateAndChat(chat);
                break;

            case "chat":
                chat.setPlayers(roomService.getPlayers(chat.getRoomId()));
                messagingTemplate.convertAndSend("/topic/room/" + chat.getRoomId() + "/chat", chat);
                break;
        }
    }

    // state와 chat을 동시에 보내는 메서드
    private void sendStateAndChat(Chat chat) {
        // 방 상태 메시지용 데이터 생성
        Chat state = new Chat();
        state.setType("state");
        state.setRoomId(chat.getRoomId());
        state.setPlayers(roomService.getPlayers(chat.getRoomId()));
        state.setCurrent(state.getPlayers().size());
        state.setHasPassword(roomService.hasPassword(chat.getRoomId())); // boolean 필드

        messagingTemplate.convertAndSend("/topic/room/" + chat.getRoomId() + "/state", state);
        messagingTemplate.convertAndSend("/topic/room/" + chat.getRoomId() + "/chat", chat);
    }
}

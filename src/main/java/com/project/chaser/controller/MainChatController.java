package com.project.chaser.controller;

import com.project.chaser.dto.Chat;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

@Controller
public class MainChatController {

    @MessageMapping("/main/chat")
    @SendTo("/topic/main/chat")
    public Chat send(Chat message) {
        // roomId는 메인 채팅에서는 사용 X
        return message;
    }
}

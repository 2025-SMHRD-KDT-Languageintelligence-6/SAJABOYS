package com.project.chaser.dto;

import lombok.*;

@Data
@NoArgsConstructor  // 기본 생성자
@AllArgsConstructor // 모든 필드 변수를 담는 생성자(초기화를 한다)
public class GameStartMessage {
    private String roomId;
    private String sender;

}
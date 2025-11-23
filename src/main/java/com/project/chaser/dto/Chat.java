package com.project.chaser.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Chat {

    // 메시지 종류: chat / join / leave / state
    private String type;

    private String roomId;
    private String sender;
    private String message;

    // 플레이어 목록 동기화에 사용
    private List<String> players;

    // 추가 필드: 방 현재 인원과 비밀번호 여부
    private Integer current;     // 현재 입장 인원
    private Boolean hasPassword; // 비밀번호 존재 여부
}

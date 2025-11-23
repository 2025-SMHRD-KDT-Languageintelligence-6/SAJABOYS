package com.project.chaser.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Chat {

    // 메시지 종류: chat / join / leave / playerList
    private String type;

    private String roomId;
    private String sender;
    private String message;

    // 플레이어 목록 동기화에 사용
    private List<String> players;
}

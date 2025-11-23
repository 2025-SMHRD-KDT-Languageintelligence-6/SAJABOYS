package com.project.chaser.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Data
@AllArgsConstructor
public class RoomState {
    private List<String> players; // 플레이어 목록
    private int current;          // 현재 인원
    private boolean hasPassword;  // 비밀번호 존재 여부
}

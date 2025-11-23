package com.project.chaser.dto;

import lombok.*;

import java.util.ArrayList;
import java.util.List;


@Data
@AllArgsConstructor
@RequiredArgsConstructor
@ToString
public class Room {
    private String id;          // 방 고유 ID
    private String title;       // 방 제목
    private String mode;        // 게임 모드
    private Integer max;       // 최대 인원 (null이면 제한 없음)
    private Integer current;   // 현재 인원
    private String password;    // 방 비밀번호 (없으면 null)
    private List<String> players = new ArrayList<>(); // 현재 입장한 플레이어 목록

    // 6개 매개변수 생성자 추가
    public Room(String id, String title, String mode, Integer max, int current, String password) {
        this.id = id;
        this.title = title;
        this.mode = mode;
        this.max = max;
        this.current = current;
        this.password = password;
    }
}

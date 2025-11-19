package com.project.chaser.dto;

import lombok.Data;

@Data
public class Comment {
    private int CommentIdx;
    private int SnsIdx;
    private int UserIdx;
    private String CommentContent;
    private String CreatedAt;

    // 조인해서 닉네임 표시용
    private String UserNickname;
}

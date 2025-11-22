package com.project.chaser.dto;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class Comment {
    private int CommentIdx;
    private int SnsIdx;
    private int UserIdx;
    private String CommentContent;
    private String CreatedAt;

    // 조인해서 닉네임 표시용
    private String UserNickname;

    // ✅ 대댓글용 필드 추가
    private Integer ParentIdx; // null 가능

    // ⬇️ 대댓글 트리 구조를 위한 필드 추가
    private List<Comment> children = new ArrayList<>();

    // 대댓글 확인용
    private int level;
}

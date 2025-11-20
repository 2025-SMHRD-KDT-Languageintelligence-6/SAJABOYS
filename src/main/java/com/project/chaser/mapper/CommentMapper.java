package com.project.chaser.mapper;

import com.project.chaser.dto.Comment;

import java.util.List;

public interface CommentMapper {
    List<Comment> getComments(int snsIdx);
    void insertComment(Comment comment);
}

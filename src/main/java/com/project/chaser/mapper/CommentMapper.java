package com.project.chaser.mapper;

import com.project.chaser.dto.Comment;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CommentMapper {
    List<Comment> getComments(int snsIdx);
    void insertComment(Comment comment);
}

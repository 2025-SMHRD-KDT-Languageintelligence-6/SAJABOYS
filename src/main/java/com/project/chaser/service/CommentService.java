package com.project.chaser.service;

import com.project.chaser.dto.Comment;
import com.project.chaser.mapper.CommentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentService {

    @Autowired
    private CommentMapper mapper;

    public List<Comment> getComments(int snsIdx) {
        return mapper.getComments(snsIdx);
    }

    public void addComment(Comment comment) {
        mapper.insertComment(comment);
    }
}

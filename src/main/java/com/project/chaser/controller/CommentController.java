package com.project.chaser.controller;

import com.project.chaser.dto.Comment;
import com.project.chaser.service.CommentService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class CommentController {

    @Autowired
    private CommentService commentService;

    // 댓글 목록
    @GetMapping("/comment/{snsIdx}")
    public List<Comment> list(@PathVariable int snsIdx) {
        return commentService.getComments(snsIdx);
    }

    // 댓글/대댓글 등록
    @PostMapping("/comment/add")
    public String addComment(@RequestBody Comment comment, HttpSession session) {
        // 세션에서 로그인한 userIdx 넣기
        Object user = session.getAttribute("user");
        if(user == null) return "loginRequired";

        comment.setUserIdx(((com.project.chaser.dto.User) user).getUserIdx());
        commentService.addComment(comment);
        return "success";
    }
}
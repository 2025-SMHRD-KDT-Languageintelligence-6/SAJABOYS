package com.project.chaser.controller;

import com.project.chaser.dto.Comment;
import com.project.chaser.dto.User;
import com.project.chaser.service.CommentService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    private CommentService commentService;

    @GetMapping("/{snsIdx}")
    public List<Comment> getComments(@PathVariable int snsIdx) {
        return commentService.getComments(snsIdx);
    }

    @PostMapping("/add")
    public String addComment(@RequestBody Comment comment,
                             HttpSession session) {

        User user = (User) session.getAttribute("user");
        if(user == null) return "loginRequired";

        comment.setUserIdx(user.getUserIdx());
        comment.setUserNickname(user.getNickname());

        commentService.addComment(comment);
        return "success";
    }
}

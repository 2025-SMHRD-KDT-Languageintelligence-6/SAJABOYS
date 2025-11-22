package com.project.chaser.controller;

import com.project.chaser.dto.Comment;
import com.project.chaser.dto.User;
import com.project.chaser.service.CommentService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/comment") // 👈 🚨🚨🚨 이 줄을 추가하여 /comment 요청을 처리하도록 수정했습니다.
public class CommentController {

    @Autowired
    private CommentService commentService;

    // 댓글 목록 (URL: /comment/{snsIdx})
    @GetMapping("/{snsIdx}") // 👈 클래스 레벨에 /comment가 있으므로 /comment 제거
    public List<Comment> list(@PathVariable int snsIdx) {
        return commentService.getComments(snsIdx);
    }

    // 댓글/대댓글 등록 (URL: /comment/add)
    @PostMapping("/add") // 👈 클래스 레벨에 /comment가 있으므로 /comment 제거
    public String addComment(@RequestBody Comment comment, HttpSession session) {
        // 세션에서 로그인한 userIdx 넣기
        Object user = session.getAttribute("user");
        if(user == null) return "loginRequired";

        comment.setUserIdx(((com.project.chaser.dto.User) user).getUserIdx());
        commentService.addComment(comment);
        return "success";
    }

    // 댓글 삭제 엔드포인트 (URL: /comment/delete/{commentIdx})
    @PostMapping("/delete/{commentIdx}")
    public ResponseEntity<String> deleteComment(@PathVariable("commentIdx") int commentIdx,
                                                HttpServletRequest request) {

        // 1. 세션 사용자 ID 검증
        User sessionUser = (User) request.getSession().getAttribute("user");
        if (sessionUser == null) {
            return ResponseEntity.ok("loginRequired");
        }

        try {
            // 2. 서비스 계층 호출: 댓글 내용을 NULL로, isDeleted를 TRUE로 업데이트
            boolean success = commentService.deleteComment(commentIdx, sessionUser.getUserIdx());

            if (success) {
                return ResponseEntity.ok("success");
            } else {
                // 권한 없음 (userIdx 불일치) 또는 DB 처리 실패
                return ResponseEntity.ok("fail");
            }

        } catch (Exception e) {
            // 로깅 및 서버 오류 처리
            e.printStackTrace();
            return ResponseEntity.status(500).body("error");
        }
    }
}
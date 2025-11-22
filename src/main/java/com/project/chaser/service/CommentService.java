package com.project.chaser.service;

import com.project.chaser.dto.Comment;
import com.project.chaser.mapper.CommentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class CommentService {

    @Autowired
    private CommentMapper mapper;

    // DB에서 댓글 가져와서 트리 구조로 변환 및 Level 계산
    public List<Comment> getComments(int snsIdx) {
        // ... (기존 getComments 메서드 내용은 동일)
        List<Comment> allComments = mapper.getComments(snsIdx);
        if (allComments.isEmpty()) {
            return new ArrayList<>();
        }

        Map<Integer, Comment> commentMap = allComments.stream()
                .collect(Collectors.toMap(Comment::getCommentIdx, dto -> dto));

        List<Comment> rootComments = new ArrayList<>();

        for (Comment comment : allComments) {
            Integer parentId = comment.getParentIdx();

            if (parentId == null || parentId.equals(0)) {
                comment.setLevel(0);
                rootComments.add(comment);
            } else {
                Comment parent = commentMap.get(parentId);

                if (parent != null) {
                    comment.setLevel(parent.getLevel() + 1);
                    parent.getChildren().add(comment);
                } else {
                    comment.setLevel(0);
                    rootComments.add(comment);
                }
            }
        }
        return rootComments;
    }

    public void addComment(Comment comment) {
        mapper.insertComment(comment);
    }

    /**
     * 댓글 삭제 로직 (대댓글 유무에 따른 조건부 삭제)
     */
    public boolean deleteComment(int commentIdx, int userIdx) {

        // 1. 해당 댓글에 대댓글이 있는지 확인
        // mapper.countReplies(commentIdx)가 XML의 SELECT 쿼리를 실행합니다.
        int replyCount = mapper.countReplies(commentIdx);
        int deletedRows = 0;

        if (replyCount > 0) {
            // 2-A. 대댓글이 있는 경우: 소프트 삭제 (메시지 남기기)
            // UPDATE: CommentContent = '삭제된 댓글입니다.', IsDeleted = TRUE
            deletedRows = mapper.deleteComment(commentIdx, userIdx); // 소프트 삭제 쿼리 호출

        } else {
            // 2-B. 대댓글이 없는 경우: DB에서 완전히 삭제 (Hard Delete)
            // DELETE FROM comments...
            deletedRows = mapper.hardDeleteComment(commentIdx, userIdx); // 하드 삭제 쿼리 호출
        }

        // 3. 업데이트/삭제된 행이 1개 이상이면 성공
        return deletedRows > 0;
    }
}
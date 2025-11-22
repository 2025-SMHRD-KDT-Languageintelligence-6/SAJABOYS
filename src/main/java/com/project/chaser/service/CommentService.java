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
        // 1. 모든 댓글을 플랫 리스트로 가져옴 (이때 정렬된 상태를 유지해야 함)
        List<Comment> allComments = mapper.getComments(snsIdx);
        if (allComments.isEmpty()) {
            return new ArrayList<>();
        }

        // 2. Map을 사용하여 CommentIdx(ID)를 키로 저장, O(1) 탐색 가능하게 함
        Map<Integer, Comment> commentMap = allComments.stream()
                .collect(Collectors.toMap(Comment::getCommentIdx, dto -> dto));

        List<Comment> rootComments = new ArrayList<>();

        for (Comment comment : allComments) {
            Integer parentId = comment.getParentIdx();

            // 3. 부모 ID가 없거나 0이면 Level 0, 최상위 리스트에 추가
            if (parentId == null || parentId.equals(0)) {
                comment.setLevel(0); // ⭐ Level 0 설정
                rootComments.add(comment);
            } else {
                // 4. 부모 Map에서 O(1)로 부모 댓글을 찾음
                Comment parent = commentMap.get(parentId);

                if (parent != null) {
                    // 부모 Level + 1로 자신의 Level 설정
                    comment.setLevel(parent.getLevel() + 1); // ⭐ Level 설정

                    // 부모의 children 목록에 자신을 추가
                    parent.getChildren().add(comment);
                } else {
                    // 부모가 없으면 최상위 댓글로 처리 (데이터베이스 오류 등)
                    comment.setLevel(0);
                    rootComments.add(comment);
                }
            }
        }

        // 5. 계층적으로 구성된 최상위 목록만 반환
        return rootComments;
    }

    public void addComment(Comment comment) {
        mapper.insertComment(comment);
    }
}
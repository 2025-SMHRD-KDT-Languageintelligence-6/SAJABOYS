package com.project.chaser.mapper;

import com.project.chaser.dto.Comment;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CommentMapper {
    public List<Comment> getComments(int snsIdx);
    public void insertComment(Comment comment);
    // 1. 소프트 삭제 (대댓글이 있을 때)
    int deleteComment(@Param("commentIdx") int commentIdx, @Param("userIdx") int userIdx);

    /**
     * 2. 대댓글 개수 확인: @Param을 사용하여 MyBatis 인자 전달 오류 해결
     * (500 Internal Server Error의 원인이었습니다.)
     */
    int countReplies(@Param("parentIdx") int parentIdx);

    /**
     * 3. 하드 삭제 (대댓글이 없을 때)
     */
    int hardDeleteComment(@Param("commentIdx") int commentIdx, @Param("userIdx") int userIdx);
}

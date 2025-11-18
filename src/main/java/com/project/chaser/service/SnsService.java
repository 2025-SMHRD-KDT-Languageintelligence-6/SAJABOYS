package com.project.chaser.service;

import com.project.chaser.dto.Sns;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface SnsService {
    public int insertPost(Sns sns, List<MultipartFile> files) throws Exception;

    public Sns getPostDetail(int snsIdx);

    public int getTotalCount(String category, String keyword); // 검색 포함 전체 게시글 수
    public List<Sns> getPostListByPage(int start, int pageSize, String category, String keyword); // 검색 포함 페이징 목록
    // 새로 추가: 글 수정
    public int updatePost(Sns sns, List<MultipartFile> files) throws Exception;

    public int deletePost(int snsIdx);
}

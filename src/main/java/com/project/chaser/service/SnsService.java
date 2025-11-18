package com.project.chaser.service;

import com.project.chaser.dto.Sns;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface SnsService {
    int insertPost(Sns sns, List<MultipartFile> files) throws Exception;

    Sns getPostDetail(int snsIdx);

    int getTotalCount(String category, String keyword); // 검색 포함 전체 게시글 수
    List<Sns> getPostListByPage(int start, int pageSize, String category, String keyword); // 검색 포함 페이징 목록
}

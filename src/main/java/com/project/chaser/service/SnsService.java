package com.project.chaser.service;

import com.project.chaser.dto.Sns;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface SnsService {
    public int insertPost(Sns sns, List<MultipartFile> files) throws Exception;

    public Sns getPostDetail(int snsIdx);

    public int getTotalCount();                // 전체 게시글 수
    public List<Sns> getPostListByPage(int start, int pageSize);  // 페이징 목록
}

package com.project.chaser.service;

import com.project.chaser.dto.Sns;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface SnsService {
    int insertPost(Sns sns, List<MultipartFile> files) throws Exception;

    Sns getPostDetail(int snsIdx);

    List<Sns> getPostList();
}

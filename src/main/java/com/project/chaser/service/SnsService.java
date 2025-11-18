package com.project.chaser.service;

import com.project.chaser.dto.Sns;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface SnsService {
    public int insertPost(Sns sns, List<MultipartFile> files) throws Exception;

    public Sns getPostDetail(int snsIdx);

    public List<Sns> getPostList();
}

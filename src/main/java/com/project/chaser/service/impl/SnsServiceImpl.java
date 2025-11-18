package com.project.chaser.service.impl;

import com.project.chaser.dto.Sns;
import com.project.chaser.dto.Snsfile;
import com.project.chaser.service.SnsMapper;
import com.project.chaser.service.SnsService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.*;

@Service
@Primary
@RequiredArgsConstructor
public class SnsServiceImpl implements SnsService {

    private final SnsMapper mapper;

    @Value("${upload.path}")
    private String uploadPath;

    @Override
    public int insertPost(Sns sns, List<MultipartFile> files) throws Exception {
        mapper.insertPost(sns);
        int snsIdx = sns.getSnsIdx();

        for (MultipartFile file : files) {
            if (file.isEmpty()) continue;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            String saveName = UUID.randomUUID() + "_" + file.getOriginalFilename();
            File dest = new File(uploadPath, saveName);
            file.transferTo(dest);

            Snsfile snsfile = new Snsfile();
            snsfile.setSnsIdx(snsIdx);
            snsfile.setFileName(file.getOriginalFilename());
            snsfile.setFilePath(saveName);
            snsfile.setFileSize((int) file.getSize());
            snsfile.setFileType(file.getContentType());

            mapper.insertFile(snsfile);
        }

        return snsIdx;
    }

    @Override
    public Sns getPostDetail(int snsIdx) {
        mapper.updateViews(snsIdx);
        Sns sns = mapper.getPost(snsIdx);
        sns.setFileList(mapper.getFiles(snsIdx));
        return sns;
    }

    @Override
    public int getTotalCount(String category, String keyword) {
        return mapper.getTotalCountBySearch(category, keyword);
    }

    @Override
    public List<Sns> getPostListByPage(int start, int pageSize, String category, String keyword) {
        return mapper.getPostListByPageWithSearch(start, pageSize, category, keyword);
    }

    @Override
    public int updatePost(Sns sns, List<MultipartFile> files) throws Exception {
        // 글 내용만 수정
        return mapper.updateSns(sns);
    }

    @Override
    public int deletePost(int snsIdx) {
        return mapper.deletePost(snsIdx);
    }

}
package com.project.chaser.service.impl;

import com.project.chaser.dto.Sns;
import com.project.chaser.dto.Snsfile;
import com.project.chaser.service.SnsMapper;
import com.project.chaser.service.SnsService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class SnsServiceImpl implements SnsService {

    @Autowired
    private final SnsMapper mapper;

    @Value("${upload.path}")
    private String uploadPath;

    @Override
    public int insertPost(Sns sns, List<MultipartFile> files) throws Exception {

        // 1) 게시글 저장
        mapper.insertPost(sns);
        int snsIdx = sns.getSnsIdx();

        // 2) 파일 저장 처리
        for (MultipartFile file : files) {

            if (file.isEmpty()) continue;

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
        Sns sns = mapper.getPost(snsIdx);
        sns.setFileList(mapper.getFiles(snsIdx));
        return sns;
    }

    @Override
    public List<Sns> getPostList() {
        return mapper.getPostList();
    }
}


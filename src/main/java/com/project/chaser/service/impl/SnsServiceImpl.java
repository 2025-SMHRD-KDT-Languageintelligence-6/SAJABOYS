package com.project.chaser.service.impl;

import com.project.chaser.dto.Sns;
import com.project.chaser.dto.Snsfile;
import com.project.chaser.service.SnsMapper;
import com.project.chaser.service.SnsService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.List;
import java.util.UUID;

@Service
@Primary
@RequiredArgsConstructor
public class SnsServiceImpl implements SnsService {

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

            // uploadPath가 C:/upload로 설정되어 있으므로 해당 경로에 파일을 저장
            File uploadDir = new File(uploadPath);  // C:/upload 디렉토리
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();  // 디렉토리가 없으면 생성
            }

            // 파일 이름에 UUID를 추가하여 중복 방지
            String saveName = UUID.randomUUID() + "_" + file.getOriginalFilename();
            File dest = new File(uploadPath, saveName);  // C:/upload/파일이름
            file.transferTo(dest);  // 파일 저장

            // Snsfile 객체 생성 및 DB 저장
            Snsfile snsfile = new Snsfile();
            snsfile.setSnsIdx(snsIdx);
            snsfile.setFileName(file.getOriginalFilename());
            snsfile.setFilePath(saveName);  // 저장된 파일 이름을 경로로 저장
            snsfile.setFileSize((int) file.getSize());
            snsfile.setFileType(file.getContentType());

            // DB에 파일 정보 저장
            mapper.insertFile(snsfile);
        }

        return snsIdx;
    }


    @Override
    public Sns getPostDetail(int snsIdx) {
        // 1. 조회수 증가
        mapper.updateViews(snsIdx);  // 조회수를 증가시키는 쿼리 호출

        // 2. 게시글 정보 조회
        Sns sns = mapper.getPost(snsIdx);

        // 3. 파일 목록 가져오기
        sns.setFileList(mapper.getFiles(snsIdx));

        return sns;
    }


    @Override
    public int getTotalCount() {
        return mapper.getTotalCount();
    }

    @Override
    public List<Sns> getPostListByPage(int start, int pageSize) {
        return mapper.getPostListByPage(start, pageSize);
    }
}


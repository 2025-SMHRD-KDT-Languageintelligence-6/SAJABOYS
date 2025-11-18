package com.project.chaser.dto;

import lombok.*;

@Data
@NoArgsConstructor  // 기본 생성자
@AllArgsConstructor // 모든 필드 변수를 담는 생성자(초기화를 한다)
@RequiredArgsConstructor    // NonNull 어노테이션 선언된 필드변수만 담는 생성자
@ToString
public class Snsfile {
    private int FileIdx;
    @NonNull
    private int SnsIdx;
    @NonNull
    private String FileName;
    @NonNull
    private String FilePath;
    private int FileSize;
    private String FileType;
    private String UploadedAt;
}

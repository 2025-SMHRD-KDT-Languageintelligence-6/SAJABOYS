package com.project.chaser.dto;

import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
@NoArgsConstructor  // 기본 생성자
@AllArgsConstructor // 모든 필드 변수를 담는 생성자(초기화를 한다)
@RequiredArgsConstructor    // NonNull 어노테이션 선언된 필드변수만 담는 생성자
@ToString   // 해당 인스턴스에 대한 정보를 문자열로 반환 -- 결과값 확인할 때 사용
public class Gaming {
    private int GamingIdx;
    @NonNull
    private int UserIdx;
    @NonNull
    private int FesIdx;
    @NonNull
    private String GameName;
    @NonNull
    private int GameResult;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date CreatedAt;
}


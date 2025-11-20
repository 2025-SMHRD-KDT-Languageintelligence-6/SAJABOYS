package com.project.chaser.dto;

import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
@NoArgsConstructor  // 기본 생성자
@AllArgsConstructor // 모든 필드 변수를 담는 생성자(초기화를 한다)
@RequiredArgsConstructor    // NonNull 어노테이션 선언된 필드변수만 담는 생성자
@ToString   // 해당 인스턴스에 대한 정보를 문자열로 반환 -- 결과값 확인할 때 사용
public class Festival {
    private int FesIdx;
    @NonNull
    private String FesName;
    @NonNull
    private String Region;
    @NonNull
    private String Addr;
    @NonNull
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date StartDate;
    @NonNull
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date EndDate;
    @NonNull
    private String Fee;
    @NonNull
    private String Theme;
    @NonNull
    private String Tel;
    @NonNull
    private double Lat;
    @NonNull
    private double Lon;
    private String CreatedAt;
    private String status; // XML에서 계산된 상태를 담기 위해 추가
    private int StampCount; // 스탬프 총 개수

    // 이미지 경로 동적 생성
    public String getImagePath() {
        // FesIdx가 1이면 001, 10이면 010 등 3자리 형식
        return String.format("/img/festival/%03d.png", FesIdx);
    }
}

package com.project.chaser.dto;

import lombok.*;

@Data
@NoArgsConstructor  // 기본 생성자
@AllArgsConstructor // 모든 필드 변수를 담는 생성자(초기화를 한다)
@RequiredArgsConstructor    // NonNull 어노테이션 선언된 필드변수만 담는 생성자
@ToString   // 해당 인스턴스에 대한 정보를 문자열로 반환 -- 결과값 확인할 때 사용
public class Festival {
    private int FesIdx;
    private String FesName;
    private String Region;
    private String Addr;
    private String StartDate;
    private String EndDate;
    private int Fee;
    private String Theme;
    private double Lat;
    private double Lon;
    private String CreatedAt;
}

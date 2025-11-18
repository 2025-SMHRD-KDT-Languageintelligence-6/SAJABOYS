package com.project.chaser.dto;

import lombok.*;

import java.util.List;

@Data
@NoArgsConstructor  // 기본 생성자
@AllArgsConstructor // 모든 필드 변수를 담는 생성자(초기화를 한다)
@RequiredArgsConstructor    // NonNull 어노테이션 선언된 필드변수만 담는 생성자
@ToString   // 해당 인스턴스에 대한 정보를 문자열로 반환 -- 결과값 확인할 때 사용
public class Sns {
    private int SnsIdx;
    @NonNull
    private String SnsTitle;
    @NonNull
    private String SnsContent;
    private String CreatedAt;
    @NonNull
    private int UserIdx;
    private int SnsViews;
    @NonNull
    private String Category;

    private List<Snsfile> fileList;

    // 새 필드 추가
    private String UserNickname;

}

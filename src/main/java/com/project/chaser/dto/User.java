package com.project.chaser.dto;

import lombok.*;

@Data
@NoArgsConstructor  // 기본 생성자
@AllArgsConstructor // 모든 필드 변수를 담는 생성자(초기화를 한다)
@RequiredArgsConstructor    // NonNull 어노테이션 선언된 필드변수만 담는 생성자
@ToString   // 해당 인스턴스에 대한 정보를 문자열로 반환 -- 결과값 확인할 때 사용
public class User {
    private int UserIdx;
    @NonNull
    private String UserId;
    @NonNull
    private String PasswordHash;
    @NonNull
    private String Nickname;
    @NonNull
    private String Email;
    private String Phone;
    @NonNull
    private char Gender;
    private String BirthDate;
    private int Point;
    private String JoinedAt;
    private boolean Admin;
}

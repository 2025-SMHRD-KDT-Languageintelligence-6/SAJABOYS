package com.project.chaser.controller;

import com.project.chaser.dto.User;
import com.project.chaser.service.UserMapper;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserController {

    @Autowired // 의존성 주입(Dependency Injection : DI)
    private UserMapper mapper;

    @GetMapping("/main")
    public String goMain() {
        return "index";
    }
    @GetMapping("/login")
    public String login(User user, HttpSession session) {
        // 1. e,p가 Member객체에 묶여서 전달, 메소드 안에서 받아옴
        // 2. mapper 인터페이스에 Member객체를 가지고 데이터 조회하는 기능 정의
        User loginUser = mapper.loginUser(user);
        // 3. XML에서 SQL문 작성
        // 4. (DB처리 잘했는지에 따라) 로그인 성공 -> session 저장 -> main
        //                          로그인 실패 -> sysout 출력 -> main
        // if문의 조건 : 조회해온 정보가 있는지 없는지
        if (loginUser == null){
            System.out.println("login Fail!");
        }
        else {
            System.out.println("login Success~");
            session.setAttribute("user", loginUser);
        }
        // 5. main.jsp에서 로그인한 회원의 정보를 출력
        return "index";
    }
}

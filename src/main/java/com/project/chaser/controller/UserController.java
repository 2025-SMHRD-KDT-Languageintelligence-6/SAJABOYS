package com.project.chaser.controller;

import com.project.chaser.dto.User;
import com.project.chaser.service.UserMapper;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class UserController {

    @Autowired // 의존성 주입(Dependency Injection : DI)
    private UserMapper mapper;

    @GetMapping("/main")
    public String goMain() {
        return "index";
    }
    @GetMapping("/header")
    public String header() {
        return "header";  // /WEB-INF/views/header.jsp 렌더링됨
    }
    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @PostMapping("/login")
    public String login(User user, HttpSession session, RedirectAttributes redirectAttributes) {
        // 1. e,p가 Member객체에 묶여서 전달, 메소드 안에서 받아옴
        // 2. mapper 인터페이스에 Member객체를 가지고 데이터 조회하는 기능 정의
        User loginUser = mapper.loginUser(user);
        // 3. XML에서 SQL문 작성
        // 4. (DB처리 잘했는지에 따라) 로그인 성공 -> session 저장 -> main
        //                          로그인 실패 -> sysout 출력 -> main
        // if문의 조건 : 조회해온 정보가 있는지 없는지

        String viewname = "";
        if (loginUser == null){
            System.out.println("login Fail!");
            redirectAttributes.addFlashAttribute("msg", "로그인 실패!");
            viewname = "redirect:/login";
        }
        else {
            System.out.println("login Success~");
            session.setAttribute("user", loginUser);
            viewname = "redirect:/main";
        }
        // 5. main.jsp에서 로그인한 회원의 정보를 출력
        return viewname;
    }
    @GetMapping("/logout")
    public String logout(HttpSession session){
        // session에 저장된 값 삭제
        // 삭제 방법 1) 저장된 이름을 알고 있으니까 그 이름으로 저장된 세션 삭제
        //              session.removeAttribute("저장된 이름")
        // 삭제 방법 2) 현재 애플리케이션 내위 존재하는 세션 모두 삭제
        session.invalidate();

        // 결과는 다시 main 이동
        // 이거 진행하던 메소드 있던데 그 메소드 실행하려면 요청대로 보냄
        return "redirect:/main";
    }
    @GetMapping("/signup")
    public String signup(){
        return "signup";
    }
    @PostMapping("/join")
    public String joinUser(User user){

        // 인터페이스에 정리된대로 DB 처리
        int cnt = mapper.joinUser(user);

        // 이미 main.jsp를 실행시키는 메소드가 있으면 그 메소드를 실행
        // 이거 view name 아니고 다른 메소드 redirect:/메소드명
        return "redirect:/main";
    }
    @GetMapping("/idCheck")
    @ResponseBody // 응답을 forwarding 방식이 아니라 바로 응답하려고 표시
    public int idCheck(User check){
        // 비동기 통신의 결과물을 직접 다시 보내는 메소드
        // ajax 통신을 하는 파일에서, 결과 파일 작성 X

        // 1. 데이터 접근
        int count = mapper.idCheck(check.getUserId());
        System.out.println("중복체크 결과 : " + count);
        return count;
    }
    @GetMapping("/update")
    public String update() {
        return "update";
    }

    @PostMapping("/update")
    public String updateUser(User user, HttpSession session) {
        // 1. update.jsp에서 넘어오는 e, p, t, a 값을 Member객체로 받아옴
        // 2. mapper에 추상메소드 작성 : updateMember
        //      2-1. 결과 값
        //      2-2. 매개변수
        // 3. XML에서 SQL문 작성
        int cnt = mapper.updateUser(user);

        if (cnt > 0) {
            System.out.println("update Succes!");
            session.setAttribute("user", user);
            // 변경 전 정보를 가지고 있는 세션에다가 같은 이름으로
            // 다른 데이터를 저장해서 덮어쓰기
        } else {
            System.out.println("update Fail...");
        }

        // 4. 회원정보 수정이 잘 되었으면 -> session 변경된 정보를 다시 저장
        //          실패가 되었으면 -> sysout으로 출력
        // 회원정보 수정하고 main으로 이동
        return "redirect:/main";
    }
}


package com.project.chaser.controller;

import com.project.chaser.dto.User;
import com.project.chaser.service.EmailService;
import com.project.chaser.service.JwtUtil;
import com.project.chaser.service.UserMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
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

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private EmailService emailService;

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
        // 1. id로만 사용자 조회
        User loginUser = mapper.loginUser(user);
        // 3. XML에서 SQL문 작성
        // 4. (DB처리 잘했는지에 따라) 로그인 성공 -> session 저장 -> main
        //                          로그인 실패 -> sysout 출력 -> main
        // if문의 조건 : 조회해온 정보가 있는지 없는지

        String viewname = "";
        if (loginUser == null){
            redirectAttributes.addFlashAttribute("msg", "아이디가 존재하지 않습니다.");
            return "redirect:/login";
        }
// 비밀번호 matches() 비교
        if (!passwordEncoder.matches(user.getPasswordHash(), loginUser.getPasswordHash())) {
            redirectAttributes.addFlashAttribute("msg", "비밀번호가 틀립니다.");
            return "redirect:/login";
        }

        // 로그인 성공
        session.setAttribute("user", loginUser);
        return "redirect:/main";
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
        // 1. 비밀번호 해시 처리
        String hashedPassword = passwordEncoder.encode(user.getPasswordHash());
        user.setPasswordHash(hashedPassword);

        // 2. DB 처리
        int cnt = mapper.joinUser(user);

        // 3. 가입 후 메인 페이지로 이동
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

    @GetMapping("/nickCheck")
    @ResponseBody // 응답을 forwarding 방식이 아니라 바로 응답하려고 표시
    public int nickCheck(User check){
        // 비동기 통신의 결과물을 직접 다시 보내는 메소드
        // ajax 통신을 하는 파일에서, 결과 파일 작성 X

        // 1. 데이터 접근
        int count = mapper.nickCheck(check.getNickname());
        System.out.println("중복체크 결과 : " + count);
        return count;
    }

    @GetMapping("/update")
    public String update() {
        return "update";
    }

    @PostMapping("/update")
    public String updateUser(User user, HttpSession session) {
        // 세션에서 기존 유저 정보 가져오기
        User existingUser = (User) session.getAttribute("user");

        // 비밀번호 입력 여부 확인
        if(user.getPasswordHash() == null || user.getPasswordHash().isEmpty()) {
            // 새 비밀번호 입력이 없으면 기존 비밀번호 유지
            user.setPasswordHash(existingUser.getPasswordHash());
        } else {
            // 새 비밀번호가 입력되었으면 해시 처리
            String hashed = passwordEncoder.encode(user.getPasswordHash());
            user.setPasswordHash(hashed);
        }

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
    @GetMapping("/findAccount")
    public String findAccount() {
        return "findAccount";
    }

    @PostMapping("/findId")
    public String findId(String Name, String Email, RedirectAttributes redirect){

            // DB에서 아이디 조회
            String foundId = mapper.findId(Name, Email);

            if (foundId != null) {
                redirect.addFlashAttribute("foundId", foundId);
            } else {
                redirect.addFlashAttribute("idError", "일치하는 정보가 없습니다.");
            }

            // 찾기 페이지 JSP 파일명 (예: findAccount.jsp)
            return "redirect:/findAccount";
    }
    // 비밀번호 찾기 → 이메일 링크
    @PostMapping("/findPw")
    public String findPw(String UserId, String Email, RedirectAttributes redirect) {
        User user = mapper.findByUserIdAndEmail(UserId, Email);
        if(user != null) {
            String token = jwtUtil.generateToken(user.getUserId(), 30);
            emailService.sendResetPasswordEmail(user.getEmail(), token);
            redirect.addFlashAttribute("msg", "비밀번호 재설정 링크를 이메일로 발송했습니다.");
        } else {
            redirect.addFlashAttribute("pwError", "일치하는 정보가 없습니다.");
        }
        return "redirect:/findAccount";
    }

    // 링크 클릭 → 비밀번호 재설정 폼
    @GetMapping("/resetPw")
    public String resetPwForm(String token, Model model) {
        String userIdStr = jwtUtil.validateToken(token); // String으로 받음
        if(userIdStr == null) {
            model.addAttribute("tokenError", "유효하지 않은 링크입니다.");
            return "resetPwError";
        }

        model.addAttribute("token", token);
        return "resetPwForm";
    }

    // 새 비밀번호 저장
    @PostMapping("/resetPw")
    public String resetPwSubmit(String token, String password,
                                RedirectAttributes redirect) {
        String userIdStr = jwtUtil.validateToken(token); // String으로 받음
        if(userIdStr == null) {
            redirect.addFlashAttribute("pwError", "유효하지 않은 링크입니다.");
            return "redirect:/findAccount";
        }

        Long userId = Long.valueOf(userIdStr); // 필요 시 Long 변환
        String encodedPw = passwordEncoder.encode(password);
        mapper.updatePassword(userId, encodedPw);

        redirect.addFlashAttribute("msg", "비밀번호가 성공적으로 변경되었습니다.");
        return "redirect:/login";
    }

}


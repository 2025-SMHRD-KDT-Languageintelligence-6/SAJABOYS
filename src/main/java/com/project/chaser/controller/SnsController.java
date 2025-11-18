package com.project.chaser.controller;

import com.project.chaser.dto.User;
import com.project.chaser.service.SnsService;
import com.project.chaser.dto.Sns;
import com.project.chaser.dto.Snsfile;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/sns")
public class SnsController {

    @Autowired
    private final SnsService service;

    // 게시글 목록 페이지
    @GetMapping
    public String list(Model model) {
        List<Sns> postList = service.getPostList();
        model.addAttribute("list", postList);   // ★ JSP에서 ${list}로 사용하므로 key를 list로 변경
        return "freeBoard"; // /WEB-INF/views/freeBoard.jsp
    }

    // 게시글 등록 처리
    @PostMapping("/write")
    public String write(Sns sns, @RequestParam("files") List<MultipartFile> files, HttpSession session) throws Exception {
        // 세션에서 로그인된 사용자 정보 가져오기
        User loginUser = (User) session.getAttribute("user");

        if (loginUser == null) {
            // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
            return "redirect:/login";
        }

        // UserIdx 설정
        sns.setUserIdx(loginUser.getUserIdx());  // 세션에서 가져온 UserIdx로 설정

        // 게시글 저장 후, 해당 게시글 상세 페이지로 리다이렉트
        int snsIdx = service.insertPost(sns, files);
        return "redirect:/sns/view/" + snsIdx;
    }



    // 게시글 상세 보기
    @GetMapping("/view/{SnsIdx}")
    public String view(@PathVariable int SnsIdx, Model model) {
        Sns sns = service.getPostDetail(SnsIdx);
        model.addAttribute("sns", sns);
        return "freeBoardView"; // /WEB-INF/views/sns/view.jsp
    }

    // 글쓰기 페이지로 이동
    @GetMapping("/write")
    public String showWriteForm(HttpSession session) {
        // 세션에서 로그인된 사용자 정보 가져오기
        User loginUser = (User) session.getAttribute("user");

        if (loginUser == null) {
            // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
            return "redirect:/login";
        }

        return "freeBoardWrite"; // 로그인된 경우 글쓰기 페이지로 이동
    }


}

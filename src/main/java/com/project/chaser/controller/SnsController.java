package com.project.chaser.controller;

import com.project.chaser.dto.User;
import com.project.chaser.dto.Sns;
import com.project.chaser.service.SnsService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/sns")
public class SnsController {

    private final SnsService service;

    // 게시글 목록 (페이징 + 검색)
    @GetMapping
    public String list(@RequestParam(defaultValue = "1") int page,
                       @RequestParam(defaultValue = "all") String category,
                       @RequestParam(value = "q", defaultValue = "") String keyword, // q 파라미터로 받기
                       Model model) {

        int pageSize = 10;

        // 검색 조건 처리
        String searchCategory = "all".equals(category) ? null : category;
        String searchKeyword = keyword.isEmpty() ? null : keyword; // 빈 문자열이면 null 처리

        int totalCount = service.getTotalCount(searchCategory, searchKeyword);
        int totalPage = (int) Math.ceil((double) totalCount / pageSize);
        int start = (page - 1) * pageSize;

        List<Sns> postList = service.getPostListByPage(start, pageSize, searchCategory, searchKeyword);

        model.addAttribute("list", postList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("category", category);
        model.addAttribute("keyword", keyword);

        return "freeBoard";
    }


    // 글 작성 화면
    @GetMapping("/write")
    public String showWriteForm(HttpSession session) {
        User loginUser = (User) session.getAttribute("user");
        if (loginUser == null) return "redirect:/login";
        return "freeBoardWrite";
    }

    // 글 작성 처리
    @PostMapping("/write")
    public String write(Sns sns,
                        @RequestParam(name = "files", required = false) List<MultipartFile> files,
                        HttpSession session) throws Exception {

        User loginUser = (User) session.getAttribute("user");
        if (loginUser == null) return "redirect:/login";

        sns.setUserIdx(loginUser.getUserIdx());
        if (files == null) files = new ArrayList<>();

        int snsIdx = service.insertPost(sns, files);
        return "redirect:/sns/view/" + snsIdx;
    }

    // 글 보기
    @GetMapping("/view/{snsIdx}")
    public String view(@PathVariable int snsIdx, Model model) {
        Sns sns = service.getPostDetail(snsIdx);
        model.addAttribute("sns", sns);
        return "freeBoardView";
    }
}
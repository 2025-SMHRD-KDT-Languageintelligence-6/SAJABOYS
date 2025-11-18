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
import java.util.Objects;

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


    // 글쓰기 & 수정 화면
    @GetMapping("/write")
    public String showWriteForm(@RequestParam(value = "snsIdx", required = false) Integer snsIdx,
                                HttpSession session,
                                Model model) {

        User loginUser = (User) session.getAttribute("user");
        if (loginUser == null) return "redirect:/login";

        if (snsIdx != null) {
            // 수정 모드: 기존 글 가져오기
            Sns sns = service.getPostDetail(snsIdx);

            // 본인 글인지 체크
            if (sns == null || !Objects.equals(sns.getUserIdx(), loginUser.getUserIdx())) {
                return "redirect:/sns";
            }

            model.addAttribute("sns", sns); // JSP에 기존 데이터 전달
        }

        return "freeBoardWrite"; // 글쓰기 JSP 재사용
    }


    // 글 작성 처리
    @PostMapping("/write")
    public String writeOrUpdate(Sns sns,
                                @RequestParam(name = "files", required = false) List<MultipartFile> files,
                                HttpSession session) throws Exception {

        User loginUser = (User) session.getAttribute("user");
        if (loginUser == null) return "redirect:/login";

        sns.setUserIdx(loginUser.getUserIdx());
        if (files == null) files = new ArrayList<>();

        if (sns.getSnsIdx() > 0) { // 0이면 새 글, 0보다 크면 수정 글
            // 기존 글 수정
            service.updatePost(sns, files);
        } else {
            // 새 글 작성
            // 새 글 작성
            int snsIdx = service.insertPost(sns, files);
            return "redirect:/sns/view/" + snsIdx;
        }

        return "redirect:/sns/view/" + sns.getSnsIdx();
    }


    // 글 보기
    @GetMapping("/view/{snsIdx}")
    public String view(@PathVariable int snsIdx, Model model) {
        Sns sns = service.getPostDetail(snsIdx);
        model.addAttribute("sns", sns);
        return "freeBoardView";
    }

    // 글 삭제
    @PostMapping("/delete/{snsIdx}")
    public String deletePost(@PathVariable int snsIdx, HttpSession session) {
        User loginUser = (User) session.getAttribute("user");
        if (loginUser == null) return "redirect:/login";

        // 삭제 요청이 본인 글인지 확인
        Sns sns = service.getPostDetail(snsIdx);
        if (sns == null || sns.getUserIdx() != loginUser.getUserIdx()) {
            // 글이 없거나, 로그인 유저와 작성자가 다르면 목록으로
            return "redirect:/sns";
        }

        service.deletePost(snsIdx); // Service 호출
        return "redirect:/sns"; // 삭제 후 목록으로 이동
    }



}
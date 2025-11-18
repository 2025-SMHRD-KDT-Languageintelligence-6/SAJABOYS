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

import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/sns")
public class SnsController {

    @Autowired
    private final SnsService service;

    // 게시글 목록 (페이징 적용)
    @GetMapping
    public String list(@RequestParam(defaultValue = "1") int page, Model model) {

        int pageSize = 10;  // 한 페이지당 게시글 10개

        // 전체 게시글 수
        int totalCount = service.getTotalCount();

        // 총 페이지 수 계산
        int totalPage = (int) Math.ceil((double) totalCount / pageSize);

        // DB LIMIT 용 시작 index
        int start = (page - 1) * pageSize;

        // 현재 페이지 게시글 목록 가져오기
        List<Sns> postList = service.getPostListByPage(start, pageSize);

        // JSP로 전달
        model.addAttribute("list", postList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPage", totalPage);

        return "freeBoard";  // /WEB-INF/views/freeBoard.jsp
    }

    @PostMapping("/write")
    public String write(Sns sns,
                        @RequestParam(name = "files", required = false) List<MultipartFile> files,
                        HttpSession session) throws Exception {

        // 세션에서 로그인된 사용자 정보 가져오기
        User loginUser = (User) session.getAttribute("user");

        if (loginUser == null) {
            // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
            return "redirect:/login";
        }

        // UserIdx 설정
        sns.setUserIdx(loginUser.getUserIdx());  // 세션에서 가져온 UserIdx로 설정

        // 파일이 없을 경우 빈 리스트로 처리
        if (files == null) {
            files = new ArrayList<>();
        }

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

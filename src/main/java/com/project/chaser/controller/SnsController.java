package com.project.chaser.controller;

import com.project.chaser.service.SnsService;
import com.project.chaser.dto.Sns;
import com.project.chaser.dto.Snsfile;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/sns")
public class SnsController {

    @Autowired
    private final SnsService service;

    /**
     * 게시글 등록 처리 (여러 파일 업로드 가능)
     */
    @PostMapping("/write")
    public String write(Sns sns,
                        @RequestParam("files") List<MultipartFile> files) throws Exception {

        int snsIdx = service.insertPost(sns, files);

        return "redirect:/sns/view/" + snsIdx;
    }

    /**
     * 게시글 상세 보기
     */
    @GetMapping("/view/{snsIdx}")
    public String view(@PathVariable int snsIdx,
                       org.springframework.ui.Model model) {
        Sns sns = service.getPostDetail(snsIdx);
        model.addAttribute("sns", sns);
        return "sns/view"; // view.jsp
    }

    /**
     * 게시글 목록 보기
     */
    @GetMapping("/list")
    public String list(org.springframework.ui.Model model) {
        List<Sns> list = service.getPostList();
        model.addAttribute("list", list);
        return "sns/list"; // list.jsp
    }
}

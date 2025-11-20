package com.project.chaser.controller;

import com.project.chaser.dto.Festival;
import com.project.chaser.service.StampService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/festival")
@RequiredArgsConstructor
public class StampController {

    private final StampService stampService;

    // 1) 스탬프 진행 현황 페이지
    @GetMapping("/{fesIdx}/stamp")
    public String stampPage(@PathVariable int fesIdx, HttpSession session, Model model) {
        int userIdx = (int) session.getAttribute("userIdx");

        Festival festival = stampService.getFestival(fesIdx);
        List<Integer> userStamps = stampService.getUserStamps(fesIdx, userIdx);

        model.addAttribute("festival", festival);
        model.addAttribute("userStamps", userStamps);

        return "stampPage"; // JSP
    }

    // 2) QR 스캔 후 스탬프 등록
    @PostMapping("/stamp/add")
    @ResponseBody
    public String addStamp(@RequestParam int fesIdx, @RequestParam int stampNumber, HttpSession session) {
        int userIdx = (int) session.getAttribute("userIdx");
        stampService.addStamp(fesIdx, userIdx, stampNumber);
        return "OK";
    }
}

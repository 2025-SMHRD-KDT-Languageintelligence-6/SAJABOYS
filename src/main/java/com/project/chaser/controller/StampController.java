package com.project.chaser.controller;

import com.project.chaser.dto.Festival;
import com.project.chaser.dto.Stamp;
import com.project.chaser.dto.User;
import com.project.chaser.service.StampService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/stamp")
public class StampController {

    @Autowired
    private final StampService stampService;

    /**
     * 스탬프 메인 페이지 (전체 축제 현황)
     */
    @GetMapping
    public String stampPage(HttpSession session, Model model) {

        User loginUser = (User) session.getAttribute("user");
        if (loginUser == null) {
            return "redirect:/login";
        }

        int userIdx = loginUser.getUserIdx();

        int totalCount = stampService.getTotalFestivalCount();
        int collectedCount = stampService.countCompletedFestivals(userIdx);

        // Grid 출력용
        List<Map<String, Object>> festivalStatuses = stampService.getFestivalCompletionStatus(userIdx);

        model.addAttribute("totalCount", totalCount);
        model.addAttribute("collectedCount", collectedCount);
        model.addAttribute("festivalStatuses", festivalStatuses);
        model.addAttribute("user", loginUser);

        return "stamp";
    }

    /**
     * QR 스캔 후 스탬프 적립
     */
    @PostMapping("/add")
    @ResponseBody
    public boolean addStamp(HttpSession session,
                            @RequestParam int stampNumber,
                            @RequestParam int fesIdx) {

        User loginUser = (User) session.getAttribute("user");
        if (loginUser == null) {
            return false;
        }
        int userIdx = loginUser.getUserIdx();
        return stampService.addStamp(userIdx, stampNumber, fesIdx);
    }

    /**
     * 스탬프 상세 페이지
     */
    @GetMapping("/detail")
    public String stampDetailPage(@RequestParam("fesIdx") int fesIdx,
                                  HttpSession session,
                                  Model model) {
        User loginUser = (User) session.getAttribute("user");
        if (loginUser == null) return "redirect:/login";

        int userIdx = loginUser.getUserIdx();

        // 1️⃣ DB에서 Festival 정보 가져오기
        Festival festival = stampService.getFestivalDetails(fesIdx);
        if (festival == null) {
            model.addAttribute("error", "해당 축제 정보를 찾을 수 없습니다.");
            return "error";
        }

        // 2️⃣ 사용자가 수집한 스탬프만 가져오기
        List<Stamp> collectedStamps = stampService.getCollectedStampsByFestival(userIdx, fesIdx);

        // 3️⃣ 모델에 그대로 전달 (절대 festival.stampCount 수정 금지)
        model.addAttribute("festival", festival);
        model.addAttribute("collectedStamps", collectedStamps);

        return "stampDetail";
    }

    @GetMapping("/qr")
    public String qrPage(HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("user");
        if (loginUser == null) return "redirect:/login";

        // 현재 보고 있는 축제 ID (옵션)
        // model.addAttribute("fesIdx", fesIdx);

        return "qr";  // qr.jsp
    }

    @GetMapping("/createQr")
    public String createQr() {
        return "createQr";  // createQr.jsp
    }
}
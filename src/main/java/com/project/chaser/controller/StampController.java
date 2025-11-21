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

    // 🚨 @PostMapping("/add") 메서드는 사용하지 않는 것으로 판단하여 제거했습니다.
    // 만약 필요하다면 다시 추가해 주십시오.

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

        return "qr";  // qr.jsp
    }

    @GetMapping("/createQr")
    public String createQr() {
        return "createQr";  // createQr.jsp
    }

    /**
     * QR 스캔 후 스탬프 적립 및 결과 페이지 표시
     */
    @GetMapping("/scan")
    public String scanStamp(
            // 🚨 400 Bad Request 오류 방지를 위해 required=false와 defaultValue="0" 설정 추가
            @RequestParam(value = "fesIdx", required = false, defaultValue = "0") int fesIdx,
            @RequestParam(value = "stampNumber", required = false, defaultValue = "0") int stampNumber,
            HttpSession session,
            Model model
    ) {
        User loginUser = (User) session.getAttribute("user");
        if (loginUser == null) return "redirect:/login";

        // 유효성 검사: 값이 누락되거나 빈 문자열일 경우 defaultValue="0"이 할당됨
        if (fesIdx == 0 || stampNumber == 0) {
            model.addAttribute("error", "잘못된 스캔 링크입니다. 축제 번호나 스탬프 번호가 누락되었습니다.");
            return "error";
        }

        // 유효한 값이므로 정상 로직 실행 (스탬프 적립)
        boolean success = stampService.addStamp(loginUser.getUserIdx(), stampNumber, fesIdx);

        model.addAttribute("success", success);
        model.addAttribute("fesIdx", fesIdx);
        model.addAttribute("stampNumber", stampNumber);

        return "scanResult";  // 스탬프 적립 결과 페이지
    }
}
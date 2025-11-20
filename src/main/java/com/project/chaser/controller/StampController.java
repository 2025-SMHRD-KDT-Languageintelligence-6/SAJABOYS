package com.project.chaser.controller;

import com.project.chaser.dto.Stamp;
import com.project.chaser.dto.User;
import com.project.chaser.service.StampService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/stamp")
public class StampController {

    private final StampService stampService;

    /**
     * @return 스탬프 메인 페이지 (로그인 사용자 전체 스탬프 현황)
     */
    @GetMapping
    public String stampPage(HttpSession session, Model model) {

        // 1. 로그인 체크
        User loginUser = (User) session.getAttribute("user");
        if (loginUser == null) {
            return "redirect:/login";
        }

        int userIdx = loginUser.getUserIdx();

        // 2. 데이터 조회
        // 전체 목표 개수 (모든 축제의 수)
        int totalCount = stampService.getTotalGoalCountForAllFestivals();

        // 사용자가 수집한 스탬프 리스트 (완료한 축제 목록)
        List<Stamp> stampList = stampService.getAllStampList(userIdx);

        // 3. 모델에 데이터 추가
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("stampList", stampList);
        model.addAttribute("user", loginUser); // JSP에서 User 정보 사용을 위해 추가

        return "stamp";
    }

    /**
     * @return QR 스캔 후 스탬프 적립 처리
     */
    @PostMapping("/add")
    @ResponseBody
    public boolean addStamp(HttpSession session,
                            @RequestParam int stampNumber,
                            @RequestParam int fesIdx) { // QR 적립 시, 해당 축제 ID는 필수 파라미터

        User loginUser = (User) session.getAttribute("user");
        if (loginUser == null) {
            return false;
        }

        int userIdx = loginUser.getUserIdx();
        return stampService.addStamp(userIdx, stampNumber, fesIdx);
    }

    /**
     * @return 스탬프 개수 조회 (AJAX 용)
     */
    @GetMapping("/count")
    @ResponseBody
    public Map<String, Object> getStampCount(HttpSession session) {

        User loginUser = (User) session.getAttribute("user");
        if (loginUser == null) {
            return Map.of("error", "로그인이 필요합니다.");
        }

        int userIdx = loginUser.getUserIdx();

        // 1. 전체 목표 개수 (모든 축제 수)
        int totalCount = stampService.getTotalGoalCountForAllFestivals();

        // 2. 사용자가 수집한 스탬프 개수 (완료된 축제 수)
        int collectedCount = stampService.getCompletedFestivalCount(userIdx);

        return Map.of(
                "count", collectedCount,
                "total", totalCount
        );
    }
}
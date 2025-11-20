package com.project.chaser.controller;

import com.project.chaser.dto.Festival;
import com.project.chaser.dto.Stamp;
import com.project.chaser.dto.User;
import com.project.chaser.service.StampService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map; // 💡 Map 임포트

@Controller
@RequiredArgsConstructor
@RequestMapping("/stamp")
public class StampController {

    private final StampService stampService;

    /**
     * @return 스탬프 메인 페이지 (완료한 축제 수 / 전체 축제 수 현황)
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
        int totalCount = stampService.getTotalFestivalCount();
        int collectedCount = stampService.countCompletedFestivals(userIdx);

        // Grid 데이터 (Map 리스트 사용)
        List<Map<String, Object>> festivalStatuses = stampService.getFestivalCompletionStatus(userIdx);

        // 3. 모델에 데이터 추가
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("collectedCount", collectedCount);
        model.addAttribute("festivalStatuses", festivalStatuses); // JSP Grid 출력용
        model.addAttribute("user", loginUser);

        return "stamp";
    }

    /**
     * @return QR 스캔 후 스탬프 적립 처리
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
    // StampController.java (stampDetailPage 메서드 수정)

    /**
     * @param fesIdx 축제 고유번호 (URL 파라미터로 받음)
     * @return 스탬프 상세 페이지 (stampDetail.jsp)
     */
    @GetMapping("/detail")
    public String stampDetailPage(@RequestParam("fesIdx") int fesIdx, HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("user");

        // 로그인 체크
        if (loginUser == null) {
            return "redirect:/login";  // 로그인 안되어 있으면 로그인 페이지로
        }
        int userIdx = loginUser.getUserIdx();

        // 축제 정보 조회
        Festival festival = stampService.getFestivalDetails(fesIdx);

        // 축제 정보가 없으면 오류 메시지 출력
        if (festival == null) {
            model.addAttribute("error", "해당 축제 정보를 찾을 수 없습니다.");
            return "error";  // error.jsp 같은 페이지로 이동 (오류 페이지)
        }

        // 사용자가 해당 축제에서 찍은 스탬프 목록 조회
        List<Stamp> collectedStamps = stampService.getCollectedStampsByFestival(userIdx, fesIdx);

        // 모델에 데이터 추가
        model.addAttribute("festival", festival);
        model.addAttribute("collectedStamps", collectedStamps);

        // 축제 상세 페이지 뷰 이름 반환
        return "stampDetail";  // 정상적으로 stampDetail.jsp로 리턴
    }
}
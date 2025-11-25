package com.project.chaser.controller;

import com.project.chaser.dto.Gaming;
import com.project.chaser.dto.User;
import com.project.chaser.service.WallyService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
@RequestMapping("/wally")
public class WallyController {

    @Autowired
    private final WallyService wallyService;

    @GetMapping("/")
    public String wallyStamp(HttpSession session){
        User loginUser = (User) session.getAttribute("user");
        if (loginUser == null) {
            return "redirect:/login";
        }

        return "wallyStamp";
    }

    @GetMapping("/createQr")
    public String createWallyQr(){
        return "createWallyQr";
    }

    @GetMapping("/qr")
    public String qrPage(HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("user");
        if (loginUser == null) return "redirect:/login";

        return "wallyQr";  // wallyQr.jsp
    }

    /**
     * QR 코드 스캔 후 게임 적립
     */
    @GetMapping("/scan")
    public String scanGaming(@RequestParam(value = "fesIdx", required = false, defaultValue = "0") int fesIdx,
                             @RequestParam(value = "gameResult", required = false, defaultValue = "0") int gameResult,
                             HttpSession session, Model model) {

        // 유저 정보 가져오기
        User loginUser = (User) session.getAttribute("user");
        if (loginUser == null) return "redirect:/login"; // 로그인 안된 유저는 로그인 페이지로 리다이렉트

        // 유효성 검사
        if (fesIdx == 0 || gameResult == 0) {
            model.addAttribute("error", "잘못된 스캔 링크입니다. 축제 번호나 게임 결과가 누락되었습니다.");
            return "error"; // 잘못된 URL이거나 값이 부족한 경우 오류 처리
        }

        // Gaming 객체 생성 및 유저 정보와 게임 결과 설정
        Gaming gaming = new Gaming();
        gaming.setFesIdx(fesIdx);
        gaming.setUserIdx(loginUser.getUserIdx());  // 현재 로그인한 유저 정보 사용
        gaming.setGameResult(gameResult);           // 스캔한 게임 결과
        gaming.setGameName("윌리 찾기");            // 게임 이름 설정 (필요에 따라 수정 가능)

        // 게임 결과 DB에 저장
        boolean success = wallyService.saveGaming(gaming);

        // 모델에 결과 전달
        model.addAttribute("success", success);
        model.addAttribute("fesIdx", fesIdx);
        model.addAttribute("gameResult", gameResult);

        // 적립 완료 페이지로 이동
        return "redirect:/main";  // scanResult.jsp (적립된 결과를 보여주는 페이지)
    }
}

package com.project.chaser.controller;

import com.project.chaser.dto.Festival;
import com.project.chaser.dto.User;
import com.project.chaser.mapper.FestivalMapper;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Controller
public class AdminController {

    @Autowired
    private FestivalMapper festivalMapper;

    @GetMapping("/admin")
    public String admin(HttpSession session) {
        User user = (User) session.getAttribute("user");

        if (user != null && user.isAdmin()) {
            return "admin";
        } else {
            return "redirect:/main";
        }
    }

    // 오늘의 윌리 이미지 업로드
    @PostMapping("/admin/wallyImage")
    public String uploadWallyImage(@RequestParam("wallyImage") MultipartFile file,
                                   HttpSession session, HttpServletRequest request) {
        User user = (User) session.getAttribute("user");

        if (user == null || !user.isAdmin()) {
            return "redirect:/main"; // 관리자가 아니면 메인 페이지로 리다이렉트
        }

        if (file != null && !file.isEmpty()) {
            try {
                String filename = "wally_today.jpg";

                // 실제 업로드 디렉토리 경로
                String uploadDirPath = request.getServletContext().getRealPath("/uploads/wally");
                Path uploadDir = Paths.get(uploadDirPath);
                Files.createDirectories(uploadDir);  // 폴더가 없으면 생성

                Path filePath = uploadDir.resolve(filename);  // 경로 설정

                // 파일 업로드
                file.transferTo(filePath.toFile());

                // 웹에서 접근할 수 있는 경로를 설정 (public 경로)
                String imagePath = "/uploads/wally/" + filename;

                // ServletContext에 이미지 경로 저장 (모든 사용자에게 보이게 설정)
                ServletContext application = request.getServletContext();
                application.setAttribute("wallyImagePath", imagePath);  // 웹 경로로 저장

                // 세션에 이미지 경로 저장 (로그인한 사용자에게만 보이게 설정)
                session.setAttribute("wallyImagePath", imagePath);

            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return "redirect:/admin"; // 업로드 후 다시 admin 페이지로 리다이렉트
    }




    // 축제 정보 업데이트
    @PostMapping("/admin/festival")
    public String updateFestival(@RequestParam("festivalName") String name,
                                 @RequestParam("festivalId") int fesIdx,
                                 HttpServletRequest request) {  // HttpServletRequest를 받아옵니다.

        // HttpServletRequest에서 ServletContext 가져오기
        ServletContext application = request.getServletContext();

        // 유효성 검사 (관리자만 접근 가능)
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || !user.isAdmin()) {
            return "redirect:/main";  // 관리자만 접근 가능
        }

        // 축제 정보 조회
        Festival festival = festivalMapper.getFestival(fesIdx);
        if (festival != null) {
            // 세션에 저장 (세션에 저장된 데이터는 로그인한 사용자에게만 보여짐)
            request.getSession().setAttribute("festivalName", name);
            request.getSession().setAttribute("festivalImagePath", festival.getImagePath());

            // Application에 저장 (모든 사용자에게 보임)
            application.setAttribute("festivalName", name);
            application.setAttribute("festivalImagePath", festival.getImagePath());
        }

        return "redirect:/admin";
    }
}

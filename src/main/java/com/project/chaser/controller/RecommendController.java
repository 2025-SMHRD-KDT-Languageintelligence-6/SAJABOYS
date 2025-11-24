package com.project.chaser.controller;

import com.project.chaser.service.FestivalRecommendClient;
import com.project.chaser.dto.RecommendFestivalDto;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class RecommendController {

    private final FestivalRecommendClient recommendClient;

    @GetMapping("/")
    public String index(Model model) {

        double lat = 35.15;   // 기본값
        double lon = 126.85;  // 기본값
        int topK = 3;

        List<RecommendFestivalDto> recommendList =
                recommendClient.getRecommendedFestivals(lat, lon, topK);

        model.addAttribute("recommendList", recommendList);

        return "redirect:/main";  // /WEB-INF/views/index.jsp
    }
}

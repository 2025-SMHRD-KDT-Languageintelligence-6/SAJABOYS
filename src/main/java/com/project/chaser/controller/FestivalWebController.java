package com.project.chaser.controller;

import com.project.chaser.service.FestivalService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@RequiredArgsConstructor
@Controller
public class FestivalWebController {

    private final FestivalService festivalService;

    @GetMapping("/festival")
    public String festivalPage(Model model) {
        model.addAttribute("festivalList", festivalService.getTodayFestivals());
        return "festival/festival";
    }

}

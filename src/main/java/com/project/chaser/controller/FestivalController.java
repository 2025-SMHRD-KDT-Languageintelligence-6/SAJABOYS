package com.project.chaser.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class FestivalController {
    @GetMapping("/main")
    public String goMain() {
        return "index";
    }
}

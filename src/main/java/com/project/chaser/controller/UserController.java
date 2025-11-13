package com.project.chaser.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserController {
    @GetMapping("/main")
    public String goMain() {
        return "index";
    }
}

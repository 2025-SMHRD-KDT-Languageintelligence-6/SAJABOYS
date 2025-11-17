package com.project.chaser.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SnsController {
    @GetMapping("/sns")
    public String sns(){
        return "freeBoard";
    }
}

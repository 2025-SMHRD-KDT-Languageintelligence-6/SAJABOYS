package com.project.chaser.controller;

import com.project.chaser.dto.User;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@RequiredArgsConstructor
@Controller
public class GameController {
    @GetMapping("/gameSelect")
    public String gameSelect(HttpSession session){
        User loginUser = (User) session.getAttribute("user");
        if (loginUser == null) {
            return "redirect:/login";
        }
        return "gameSelect";
    }


    @GetMapping("/rule")
    public String rule(){
    return "rule";
    }
    @GetMapping("/rule/zombie")
    public String zombie(){
        return "zombie";
    }
    @GetMapping("/rule/wally")
    public String wally(){
        return "wally";
    }
    @GetMapping("/rule/police")
    public String police(){
        return "police";
    }
}

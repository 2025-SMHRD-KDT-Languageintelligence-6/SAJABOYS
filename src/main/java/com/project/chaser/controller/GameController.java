package com.project.chaser.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@RequiredArgsConstructor
@Controller
public class GameController {
    @GetMapping("/gameSelect")
    public String gameSelect(){
        return "gameSelect";
    }


    @GetMapping("/rule")
    public String rule(){
    return "rule";
    }
    @GetMapping("/zombie")
    public String zombie(){
        return "zombie";
    }
    @GetMapping("/wally")
    public String wally(){
        return "wally";
    }
    @GetMapping("/police")
    public String police(){
        return "police";
    }
}

package com.project.chaser.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class WallyController {
    @GetMapping("/wally/createQr")
    public String createWallyQr(){
        return "createWallyQr";
    }
}

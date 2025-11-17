package com.project.chaser.service.impl;

import com.project.chaser.service.EmailService;
import lombok.RequiredArgsConstructor;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

@Service
@RequiredArgsConstructor
public class EmailServiceImpl implements EmailService {

    private final JavaMailSender mailSender;

    @Override
    public void sendResetPasswordEmail(String toEmail, String token) {
        try {
            String encodedToken = URLEncoder.encode(token, "UTF-8");
            // 일반적으로는 localhost:8089/resetPw?token=
            String resetLink = "http://172.30.1.54:8089/resetPw?token=" + encodedToken;

            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(toEmail);
            message.setSubject("[서비스] 비밀번호 재설정 안내");
            message.setText("아래 링크를 클릭하여 비밀번호를 재설정하세요.\n" + resetLink + "\n30분 동안 유효합니다.");

            mailSender.send(message);
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("UTF-8 인코딩 오류", e);
        }
    }

}

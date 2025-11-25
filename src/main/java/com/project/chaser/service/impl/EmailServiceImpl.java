package com.project.chaser.service.impl;

import com.project.chaser.service.EmailService;
import lombok.RequiredArgsConstructor;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.scheduling.annotation.Async; // 💡 (선택 사항) 느린 응답 개선을 위해 추가

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

@Service
@RequiredArgsConstructor
public class EmailServiceImpl implements EmailService {

    private final JavaMailSender mailSender;

    // 💡 인터페이스 메서드를 변경하고, 동적 주소를 받기 위해 baseUrl 인자를 추가했습니다.
    // @Async를 추가하여 Gmail SMTP의 느린 응답으로 인한 사용자 대기 시간을 줄이는 것을 권장합니다.
    @Async
    @Override
    public void sendResetPasswordEmail(String toEmail, String token, String baseUrl) { // 👈 baseUrl 인자 추가
        try {
            String encodedToken = URLEncoder.encode(token, "UTF-8");

            // 💡 하드코딩된 주소 대신 인자로 받은 baseUrl을 사용합니다.
            String resetLink = baseUrl + "/resetPw?token=" + encodedToken;

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
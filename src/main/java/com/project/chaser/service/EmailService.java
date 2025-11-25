package com.project.chaser.service;

public interface EmailService {
    public void sendResetPasswordEmail(String toEmail, String token, String baseUrl);
}

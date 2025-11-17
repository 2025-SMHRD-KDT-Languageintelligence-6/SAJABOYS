package com.project.chaser.service;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.stereotype.Component;
import io.jsonwebtoken.security.Keys;
import javax.crypto.SecretKey;
import java.security.Key;
import java.util.Date;

@Component
public class JwtUtil {
    // 노출 엄금
    // ★ 여기서 안전한 HMAC-SHA256 키를 자동 생성
    private final Key key = Keys.secretKeyFor(SignatureAlgorithm.HS256);

    public String generateToken(String UserId, long expireMinutes) {
        return Jwts.builder()
                .claim("UserId", UserId)
                .setExpiration(new Date(System.currentTimeMillis() + expireMinutes * 60 * 1000))
                .signWith(key)
                .compact();
    }

    public String validateToken(String token) {
        try {
            Claims claims = Jwts.parserBuilder()
                    .setSigningKey(key)
                    .build()
                    .parseClaimsJws(token)
                    .getBody();
            return (String) claims.get("UserId");
        } catch (Exception e) {
            return null;
        }
    }
}

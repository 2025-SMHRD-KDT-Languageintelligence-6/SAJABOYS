package com.project.chaser.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.chaser.dto.RecommendFestivalDto;
import org.springframework.stereotype.Service;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Collections;
import java.util.List;

@Service
public class FestivalRecommendClient {

    // Flask 서버 URL (app.py에서 설정한 포트와 경로)
    private static final String FLASK_URL = "http://127.0.0.1:9000/recommend";

    private final HttpClient httpClient = HttpClient.newHttpClient();
    private final ObjectMapper objectMapper = new ObjectMapper();

    // ★ 여기! Controller에서 부를 메서드
    public List<RecommendFestivalDto> getRecommendedFestivals(double lat, double lon, int topK) {

        try {
            String url = String.format("%s?lat=%f&lon=%f&top_k=%d",
                    FLASK_URL, lat, lon, topK);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .GET()
                    .build();

            HttpResponse<String> response =
                    httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() != 200) {
                System.out.println("[FestivalRecommendClient] Flask 응답 코드 = " + response.statusCode());
                return Collections.emptyList();
            }

            // JSON → List<RecommendFestivalDto> 로 변환
            return objectMapper.readValue(
                    response.body(),
                    new TypeReference<List<RecommendFestivalDto>>() {}
            );

        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }
}

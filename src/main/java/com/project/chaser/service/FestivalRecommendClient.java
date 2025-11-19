package com.project.chaser.service;

import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class FestivalRecommendClient {

    private final RestTemplate restTemplate;

    // Flask 서버 주소 (app.py가 띄워져 있어야 함!)
    private static final String BASE_URL = "http://localhost:5000";

    public FestivalRecommendClient(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    public List<Map<String, Object>> getRecommendedFestivals(
            double lat,
            double lon,
            Integer topN,
            String feeType
    ) {
        String url = BASE_URL + "/api/festivals/recommend"
                + "?lat={lat}&lon={lon}&topN={topN}&feeType={feeType}";

        Map<String, Object> uriVars = new HashMap<>();
        uriVars.put("lat", lat);
        uriVars.put("lon", lon);
        uriVars.put("topN", topN != null ? topN : 10);
        uriVars.put("feeType", feeType != null ? feeType : "all");

        ResponseEntity<List<Map<String, Object>>> response =
                restTemplate.exchange(
                        url,
                        HttpMethod.GET,
                        null,
                        new ParameterizedTypeReference<List<Map<String, Object>>>() {},
                        uriVars
                );

        return response.getBody();
    }
}

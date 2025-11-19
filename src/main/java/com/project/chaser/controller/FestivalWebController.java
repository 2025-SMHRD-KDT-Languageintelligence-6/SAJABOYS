package com.project.chaser.controller;

import com.project.chaser.service.FestivalRecommendClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
public class FestivalWebController {

    private final FestivalRecommendClient recommendClient;

    public FestivalWebController(FestivalRecommendClient recommendClient) {
        this.recommendClient = recommendClient;
    }

    // 예: http://localhost:8089/api/festivals/recommend?lat=34.95&lon=127.48&topN=5&feeType=all
    @GetMapping("/api/festivals/recommend")
    public List<Map<String, Object>> recommend(
            @RequestParam double lat,
            @RequestParam double lon,
            @RequestParam(defaultValue = "10") int topN,
            @RequestParam(defaultValue = "all") String feeType
    ) {

        // 1) Flask에서 원본 추천 결과 가져오기
        List<Map<String, Object>> rawList =
                recommendClient.getRecommendedFestivals(lat, lon, topN, feeType);

        // 2) 필요한 컬럼만 추려서, 순서까지 정리해서 반환
        return rawList.stream()
                .map(item -> {
                    Map<String, Object> m = new LinkedHashMap<>();

                    // 원본 키 (Flask에서 내려주는 이름)
                    String start = (String) item.get("축제 시작");
                    String end   = (String) item.get("축제종료");

                    // 한국식 날짜 문자열로 변환
                    String startDate = extractDate(start);
                    String endDate   = extractDate(end);

                    // ★ 최종으로 클라이언트에게 보여줄 필드와 순서
                    m.put("입장료", item.get("입장료"));
                    m.put("축제명", item.get("축제명"));
                    m.put("축제시작", startDate);   // 2025년 10월 21일
                    m.put("축제종료", endDate);     // 2025년 11월 23일
                    m.put("테마", item.get("테마"));

                    return m;
                })
                .collect(Collectors.toList());
    }

    /**
     * "Tue, 21 Oct 2025 00:00:00 GMT" 형태의 문자열을
     * "2025년 10월 21일" 로 변환하는 헬퍼 메서드
     */
    private String extractDate(String original) {
        if (original == null) return "";

        try {
            // 원본 형식: Tue, 21 Oct 2025 00:00:00 GMT
            DateTimeFormatter inputFmt =
                    DateTimeFormatter.ofPattern("EEE, dd MMM yyyy HH:mm:ss 'GMT'", Locale.ENGLISH);

            // 출력 형식: 2025년 10월 21일
            DateTimeFormatter outputFmt =
                    DateTimeFormatter.ofPattern("yyyy년 MM월 dd일");

            LocalDateTime dt = LocalDateTime.parse(original, inputFmt);
            return dt.format(outputFmt);

        } catch (Exception e) {
            System.out.println("날짜 파싱 실패: " + original + " / " + e.getMessage());
            // 에러가 나더라도 서비스가 터지지 않게 원본 값 반환
            return original;
        }
    }
}

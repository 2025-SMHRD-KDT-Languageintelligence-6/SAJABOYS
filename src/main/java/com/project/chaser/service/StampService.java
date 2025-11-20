package com.project.chaser.service;

import com.project.chaser.dto.Festival;
import com.project.chaser.dto.Stamp;
import com.project.chaser.mapper.StampMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map; // 💡 Map 임포트

@Service
@RequiredArgsConstructor
public class StampService {

    private final StampMapper stampMapper;

    /**
     * @return 분모: 전체 축제의 총 개수 (126)
     */
    public int getTotalFestivalCount() {
        return stampMapper.getTotalFestivalCount();
    }

    /**
     * @param userIdx 사용자 고유번호
     * @return 분자: 사용자가 모든 스탬프를 모아 '완료한' 축제 개수 (0)
     */
    public int countCompletedFestivals(int userIdx) {
        return stampMapper.countCompletedFestivals(userIdx);
    }

    /**
     * @param userIdx 사용자 고유번호
     * @return Grid 출력을 위한 전체 축제별 완료 상태 리스트 (Map 반환)
     */
    public List<Map<String, Object>> getFestivalCompletionStatus(int userIdx) {
        return stampMapper.getFestivalCompletionStatus(userIdx);
    }

    /**
     * @param userIdx 사용자 고유번호
     * @return 사용자가 수집한 스탬프 리스트
     */
    public List<Stamp> getAllStampList(int userIdx) {
        return stampMapper.findByUserIdx(userIdx);
    }

    /**
     * 스탬프 적립 처리
     */
    public boolean addStamp(int userIdx, int stampNumber, int fesIdx) {
        // DTO 필드명이 PascalCase임을 가정하고 객체 생성
        Stamp stamp = new Stamp();
        stamp.setUserIdx(userIdx);
        stamp.setStampNumber(stampNumber);
        stamp.setFesIdx(fesIdx);

        return stampMapper.insertStamp(stamp);
    }
    /**
     * @param fesIdx 축제 고유번호
     * @return 축제 상세 정보 (DTO)
     */
    public Festival getFestivalDetails(int fesIdx) {
        // 축제 정보를 DB에서 가져옵니다.
        Festival festival = stampMapper.findByFesIdx(fesIdx);

        if (festival != null) {
            // 해당 축제에서 수집해야 하는 스탬프 수 계산
            int stampCount = stampMapper.countStampsByFestival(fesIdx);  // countStampsByFestival 메서드를 호출하여 스탬프 개수 계산
            festival.setStampCount(stampCount);  // festival 객체에 stampCount를 설정
        }

        return festival;
    }

    /**
     * @param userIdx 사용자 고유번호
     * @param fesIdx 축제 고유번호
     * @return 사용자가 해당 축제에서 찍은 스탬프 리스트
     */
    public List<Stamp> getCollectedStampsByFestival(int userIdx, int fesIdx) {
        // 💡 2. StampMapper에 이 쿼리를 구현해야 합니다.
        return stampMapper.findStampsByUserAndFestival(userIdx, fesIdx);
    }
}
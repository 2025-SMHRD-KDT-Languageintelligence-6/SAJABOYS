package com.project.chaser.service;

import com.project.chaser.dto.Stamp;
import com.project.chaser.mapper.StampMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class StampService {

    private final StampMapper stampMapper;

    /**
     * @return 전체 축제의 총 목표 개수 (총 축제 수)
     */
    public int getTotalGoalCountForAllFestivals() {
        return stampMapper.countTotalFestivals(); // 모든 축제 수 조회
    }

    /**
     * @param userIdx 사용자 고유번호
     * @return 사용자가 수집한 스탬프 리스트
     */
    public List<Stamp> getAllStampList(int userIdx) {
        // 사용자가 찍은 모든 스탬프 기록을 가져옵니다.
        return stampMapper.findByUserIdx(userIdx);
    }

    /**
     * @param userIdx 사용자 고유번호
     * @return 사용자가 완료한 (DISTINCT) 축제 개수
     */
    public int getCompletedFestivalCount(int userIdx) {
        // 스탬프 진행률을 위한 분자 (사용자가 스탬프를 찍은 유니크한 축제 수)
        return stampMapper.countDistinctFestivalsByUser(userIdx);
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

        // 💡 주의: 실제 서비스에서는 이전에 적립한 스탬프인지 중복 체크 로직이 필요합니다.

        return stampMapper.insertStamp(stamp);
    }
}
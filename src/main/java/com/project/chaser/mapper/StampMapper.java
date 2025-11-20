package com.project.chaser.mapper;

import com.project.chaser.dto.Stamp;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface StampMapper {

    // 💡 1. 전체 축제(스탬프 목표) 개수
    int countTotalFestivals();

    // 💡 2. 사용자가 완료한 (DISTINCT) 축제 개수
    int countDistinctFestivalsByUser(int userIdx);

    // 사용자 ID로 수집한 스탬프 리스트 조회 (기존 로직 유지)
    List<Stamp> findByUserIdx(int userIdx);

    // 스탬프 적립 (유지)
    boolean insertStamp(Stamp stamp);

    // ... (기존 메서드 중 사용되지 않는 countByUserIdx 등은 정리)
}
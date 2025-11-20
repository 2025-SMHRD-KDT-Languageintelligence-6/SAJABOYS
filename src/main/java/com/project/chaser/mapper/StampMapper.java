package com.project.chaser.mapper;

import com.project.chaser.dto.Festival;
import com.project.chaser.dto.Stamp;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map; // 💡 Map 임포트

@Mapper
public interface StampMapper {

    // 1. 분모: 전체 축제 개수
    public int getTotalFestivalCount();

    // 2. 분자: 사용자가 완료한 축제 개수
    public int countCompletedFestivals(@Param("userIdx") int userIdx);

    // 3. Grid 출력을 위한 축제별 완료 상태 리스트 (DTO 대신 Map 반환)
    public List<Map<String, Object>> getFestivalCompletionStatus(@Param("userIdx") int userIdx);

    // 사용자 ID로 수집한 스탬프 리스트 조회 (유지)
    public List<Stamp> findByUserIdx(@Param("userIdx") int userIdx);

    // 스탬프 적립 (유지)
    public boolean insertStamp(Stamp stamp);

    // 축제 정보 조회
    public Festival findFestivalById(int fesIdx);

    // 사용자가 해당 축제에서 찍은 스탬프 목록 조회
    public List<Stamp> findStampsByUserAndFestival(int userIdx, int fesIdx);

    public Festival findByFesIdx(int fesIdx);

    // 사용자가 수집한 스탬프 개수를 반환하는 메서드
    public int countStampsByFestival(int fesIdx);
}
package com.project.chaser.mapper;

import com.project.chaser.dto.Gaming;

import java.util.List;

public interface WallyMapper {
    // 게임 데이터를 DB에 저장하는 메서드
    public void insertGaming(Gaming gaming);

    public List<Gaming> selectGamingResultsByUser(int userIdx);


}

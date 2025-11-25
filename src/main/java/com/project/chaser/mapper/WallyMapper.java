package com.project.chaser.mapper;

import com.project.chaser.dto.Gaming;

public interface WallyMapper {
    // 게임 데이터를 DB에 저장하는 메서드
    void insertGaming(Gaming gaming);

}

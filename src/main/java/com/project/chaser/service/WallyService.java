package com.project.chaser.service;

import com.project.chaser.dto.Gaming;
import com.project.chaser.mapper.WallyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class WallyService {

    @Autowired
    private WallyMapper wallyMapper;

    // 게임 데이터 저장
    public boolean saveGaming(Gaming gaming) {
        try {
            wallyMapper.insertGaming(gaming); // MyBatis Mapper를 사용해 DB에 저장
            return true; // 성공적으로 저장되면 true 반환
        } catch (Exception e) {
            e.printStackTrace();
            return false; // 예외가 발생하면 false 반환
        }
    }

    public List<Gaming> getGamingResults(int userIdx) {
        return wallyMapper.selectGamingResultsByUser(userIdx);
    }
}


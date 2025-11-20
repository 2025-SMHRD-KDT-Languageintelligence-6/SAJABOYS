package com.project.chaser.service;

import com.project.chaser.dto.Festival;
import com.project.chaser.mapper.FestivalMapper;
import com.project.chaser.mapper.StampMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class StampService {
    private final StampMapper stampMapper;
    private final FestivalMapper festivalMapper;

    public Festival getFestival(int fesIdx) {
        return festivalMapper.getFestival(fesIdx);
    }

    public List<Integer> getUserStamps(int fesIdx, int userIdx) {
        return stampMapper.getUserStamps(fesIdx, userIdx);
    }

    public void addStamp(int fesIdx, int userIdx, int stampNumber) {
        stampMapper.insertStamp(fesIdx, userIdx, stampNumber);
    }
}


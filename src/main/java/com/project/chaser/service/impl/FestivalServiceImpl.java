package com.project.chaser.service.impl;

import com.project.chaser.dto.Festival;
import com.project.chaser.service.FestivalMapper;
import com.project.chaser.service.FestivalService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class FestivalServiceImpl implements FestivalService {

    private final FestivalMapper festivalMapper;

    @Override
    public List<Festival> getTodayFestivals() {
        return festivalMapper.getTodayFestivals();
    }
}
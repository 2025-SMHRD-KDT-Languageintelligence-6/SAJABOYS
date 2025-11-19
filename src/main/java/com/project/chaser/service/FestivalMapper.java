package com.project.chaser.service;

import com.project.chaser.dto.Festival;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface FestivalMapper {
    List<Festival> getTodayFestivals();   // 오늘 기준 일정 포함된 축제 목록

}

package com.project.chaser.mapper;

import com.project.chaser.dto.Festival;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface FestivalMapper {
    List<Festival> getTodayFestivals();
}

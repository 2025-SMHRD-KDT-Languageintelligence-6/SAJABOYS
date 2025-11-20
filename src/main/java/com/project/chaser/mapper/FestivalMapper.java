package com.project.chaser.mapper;

import com.project.chaser.dto.Festival;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface FestivalMapper {
    public List<Festival> getTodayFestivals();

    public Festival getFestival(int fesIdx);

    @Select("SELECT StampCount FROM festival WHERE FesIdx = #{fesIdx}")
    int getStampCount(@Param("fesIdx") int fesIdx);
}

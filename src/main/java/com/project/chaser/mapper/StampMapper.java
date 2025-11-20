package com.project.chaser.mapper;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface StampMapper {
    List<Integer> getUserStamps(int fesIdx, int userIdx);

    void insertStamp(int fesIdx, int userIdx, int stampNumber);
}

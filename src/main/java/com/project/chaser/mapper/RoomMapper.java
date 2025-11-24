package com.project.chaser.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface RoomMapper {
    int updateRoomStarted(@Param("roomId") String roomId, @Param("started") boolean started);
}

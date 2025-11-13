package com.project.chaser.service;

import com.project.chaser.dto.User;
import lombok.NonNull;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {
    public User loginUser(User user);

    public int joinUser(User user);

    public int idCheck(@NonNull String UserId);
}

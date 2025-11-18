package com.project.chaser.service;

import com.project.chaser.dto.Sns;
import com.project.chaser.dto.Snsfile;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SnsMapper {
    public void insertPost(Sns sns);
    public void insertFile(Snsfile snsfile);

    public Sns getPost(int SnsIdx);
    public List<Snsfile> getFiles(int SnsIdx);
    // 게시글 조회수 증가
    void updateViews(int snsIdx);
    int getTotalCount();

    List<Sns> getPostListByPage(@Param("start") int start,
                                @Param("pageSize") int pageSize);
}

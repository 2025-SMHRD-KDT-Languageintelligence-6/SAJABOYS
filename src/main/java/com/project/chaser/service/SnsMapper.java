package com.project.chaser.service;

import com.project.chaser.dto.Sns;
import com.project.chaser.dto.Snsfile;

import java.util.List;

public interface SnsMapper {
    public void insertPost(Sns sns);
    public void insertFile(Snsfile snsfile);

    public Sns getPost(int SnsIdx);
    public List<Snsfile> getFiles(int SnsIdx);
    public List<Sns> getPostList();
}

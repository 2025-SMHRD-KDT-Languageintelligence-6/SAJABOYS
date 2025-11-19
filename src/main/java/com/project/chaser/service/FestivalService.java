package com.project.chaser.service;

import com.project.chaser.dto.Festival;
import java.util.List;

public interface FestivalService {
    List<Festival> getTodayFestivals();
}
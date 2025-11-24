package com.project.chaser.dto;

import lombok.Data;

@Data
public class RecommendFestivalDto {

    private int FesIdx;
    private String FesName;
    private String Region;
    private String Addr;
    private String StartDate;
    private String EndDate;
    private double Lat;
    private double Lon;

    private double distance_km;
    private double pred_score;

    private String imagePath;
}

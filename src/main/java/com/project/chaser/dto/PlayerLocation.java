package com.project.chaser.dto;

import lombok.Data;

@Data
public class PlayerLocation {
    private String nickname;
    private double lat;
    private double lng;

    public PlayerLocation() {}

    public PlayerLocation(String nickname, double lat, double lng) {
        this.nickname = nickname;
        this.lat = lat;
        this.lng = lng;
    }
}

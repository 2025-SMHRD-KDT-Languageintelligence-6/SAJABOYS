package com.project.chaser.controller;

import com.project.chaser.dto.PlayerLocation;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

@Controller
public class RoomWebSocketController {

    // 방별 플레이어 위치 저장 (Thread-safe)
    private final Map<String, Map<String, PlayerLocation>> roomLocations = new ConcurrentHashMap<>();

    @MessageMapping("/room/{roomId}/location")
    @SendTo("/topic/room/{roomId}/location")
    public Collection<PlayerLocation> updateLocation(@DestinationVariable String roomId, PlayerLocation location) {
        roomLocations.putIfAbsent(roomId, new ConcurrentHashMap<>());
        Map<String, PlayerLocation> players = roomLocations.get(roomId);

        // 해당 플레이어 위치 업데이트
        players.put(location.getNickname(), location);

        // 방에 있는 모든 플레이어 위치 반환
        return players.values();
    }
}

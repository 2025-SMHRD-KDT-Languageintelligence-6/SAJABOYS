package com.project.chaser.service;

import com.project.chaser.dto.Room;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class RoomService {

    // 서버 메모리에 방 리스트 관리
    private final Map<String, Room> roomMap = new LinkedHashMap<>();

    // 전체 방 조회
    public List<Room> getAllRooms() {
        return new ArrayList<>(roomMap.values());
    }

    // 방 생성
    public Room createRoom(String title, String mode, Integer max, String password) {
        String roomId = UUID.randomUUID().toString();
        Room room = new Room(roomId, title, mode, max, 0, password);
        roomMap.put(roomId, room);
        return room;
    }

    // 방 입장
    public boolean enterRoom(String roomId, String nickname) {
        Room room = roomMap.get(roomId);
        if(room == null) return false;
        if(room.getMax() != null && room.getCurrent() >= room.getMax()) return false;
        if(!room.getPlayers().contains(nickname)) {
            room.getPlayers().add(nickname);
            room.setCurrent(room.getCurrent() + 1);
        }
        return true;
    }

    // 방 퇴장
    public void leaveRoom(String roomId, String nickname) {
        Room room = roomMap.get(roomId);
        if(room == null) return;
        room.getPlayers().remove(nickname);
        room.setCurrent(room.getCurrent() - 1);
        if(room.getCurrent() <= 0) {
            roomMap.remove(roomId); // 인원 0이면 방 삭제
        }
    }

    public Room getRoom(String roomId) {
        return roomMap.get(roomId);
    }
}

package com.project.chaser.service;

import com.project.chaser.dto.Room;
import com.project.chaser.mapper.RoomMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor // final 필드를 자동으로 생성자에 주입
public class RoomService {

    private final RoomMapper roomMapper; // MyBatis Mapper

    private final ConcurrentHashMap<String, Room> roomMap = new ConcurrentHashMap<>();

    public List<Room> getAllRooms() {
        return roomMap.values().stream().collect(Collectors.toList());
    }

    public void addRoom(Room room) {
        roomMap.put(room.getId(), room);
    }

    public Room getRoom(String roomId) {
        return roomMap.get(roomId);
    }

    public List<String> getPlayers(String roomId) {
        Room room = roomMap.get(roomId);
        return room != null ? new CopyOnWriteArrayList<>(room.getPlayers()) : new CopyOnWriteArrayList<>();
    }

    public void enterRoom(String roomId, String nickname) {
        Room room = roomMap.get(roomId);
        if (room == null) return;
        if (room.getMax() != null && room.getCurrent() >= room.getMax()) return;
        if (!room.getPlayers().contains(nickname)) {
            room.getPlayers().add(nickname);
            room.setCurrent(room.getCurrent() + 1);
        }
    }

    public void leaveRoom(String roomId, String nickname) {
        Room room = roomMap.get(roomId);
        if (room == null) return;
        if (room.getPlayers().contains(nickname)) {
            room.getPlayers().remove(nickname);
            room.setCurrent(room.getCurrent() - 1);
        }
        // 마지막 사람만 나가면 삭제
        if (room.getCurrent() <= 0) {
            roomMap.remove(roomId);
        }
    }
    // 새로 추가
    public void startGame(String roomId) {
        Room room = roomMap.get(roomId);
        if(room != null) {
            room.setGameStarted(true);
        }
    }
}

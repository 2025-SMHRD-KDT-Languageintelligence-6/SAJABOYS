package com.project.chaser.controller;

import com.project.chaser.dto.Room;
import com.project.chaser.dto.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

import java.util.*;

@Controller
@RequestMapping("/room")
public class RoomController {

    private final Map<String, Room> roomMap = new LinkedHashMap<>();

    // 방 목록 페이지
    @GetMapping("/list")
    public String roomList(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        model.addAttribute("roomList", new ArrayList<>(roomMap.values()));
        return "gameSelect";
    }

    // 방 목록 JSON
    @GetMapping("/list/json")
    @ResponseBody
    public List<Room> roomListJson() {
        return new ArrayList<>(roomMap.values());
    }

    // 방 생성 + 자동 입장
    @PostMapping("/createAndEnter")
    @ResponseBody
    public Map<String, Object> createAndEnterRoom(
            @RequestParam String title,
            @RequestParam String mode,
            @RequestParam(required = false) Integer max,
            @RequestParam(required = false) String password,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();
        User user = (User) session.getAttribute("user");
        if(user == null){
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }

        String roomId = UUID.randomUUID().toString();
        Room room = new Room(roomId, title, mode, max, 1, password);
        room.getPlayers().add(user.getNickname());
        roomMap.put(roomId, room);

        result.put("success", true);
        result.put("roomId", roomId);
        result.put("enterUrl", "/room/game?roomId=" + roomId);
        return result;
    }

    // 게임 방 입장
    @GetMapping("/game")
    public String enterRoom(@RequestParam String roomId, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        Room room = roomMap.get(roomId);
        if (room == null) return "redirect:/room/list";

        if (!room.getPlayers().contains(user.getNickname())) {
            room.getPlayers().add(user.getNickname());
            room.setCurrent(room.getCurrent() + 1);
        }

        model.addAttribute("room", room);
        model.addAttribute("user", user);
        return "gameRoom";
    }

    // 방 나가기
    @PostMapping("/leave")
    @ResponseBody
    public Map<String, Object> leaveRoom(@RequestParam String roomId, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }

        Room room = roomMap.get(roomId);
        if (room == null) {
            result.put("success", false);
            result.put("message", "방이 존재하지 않습니다.");
            return result;
        }

        room.getPlayers().remove(user.getNickname());
        room.setCurrent(room.getCurrent() - 1);

        // 방에 플레이어 없으면 삭제
        if (room.getPlayers().isEmpty()) {
            roomMap.remove(roomId);
        }

        result.put("success", true);
        return result;
    }
}

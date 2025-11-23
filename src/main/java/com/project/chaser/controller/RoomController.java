package com.project.chaser.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.chaser.dto.Room;
import com.project.chaser.dto.User;
import com.project.chaser.service.RoomService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.UUID;

@Controller
@RequestMapping("/room")
public class RoomController {

    private final RoomService roomService;
    private final ObjectMapper objectMapper = new ObjectMapper(); // JSON 변환용

    public RoomController(RoomService roomService) {
        this.roomService = roomService;
    }

    // 방 목록 페이지
    @GetMapping("/list")
    public String roomList(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        List<Room> rooms = roomService.getAllRooms();
        model.addAttribute("roomList", rooms);
        return "gameSelect";
    }

    // 방 목록 JSON
    @GetMapping("/list/json")
    @ResponseBody
    public List<Room> roomListJson() {
        return roomService.getAllRooms();
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
        Room room = new Room(roomId, title, mode, max, 0, password); // current 0
        roomService.addRoom(room);

        // 방 생성 직후 본인 입장
        roomService.enterRoom(roomId, user.getNickname());

        result.put("success", true);
        result.put("roomId", roomId);
        result.put("enterUrl", "/room/game?roomId=" + roomId);
        return result;
    }

    // 게임 방 입장
    @GetMapping("/game")
    public String enterRoom(@RequestParam String roomId, HttpSession session, Model model) throws Exception {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        Room room = roomService.getRoom(roomId);
        if (room == null) return "redirect:/room/list";

        // 플레이어 추가 (중복 방지)
        roomService.enterRoom(roomId, user.getNickname());

        // 최신 플레이어 리스트 JSON
        String playersJson = objectMapper.writeValueAsString(roomService.getPlayers(roomId));

        model.addAttribute("room", room);
        model.addAttribute("user", user);
        model.addAttribute("playersJson", playersJson);
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

        Room room = roomService.getRoom(roomId);
        if (room == null) {
            result.put("success", false);
            result.put("message", "방이 존재하지 않습니다.");
            return result;
        }

        roomService.leaveRoom(roomId, user.getNickname());
        result.put("success", true);
        return result;
    }
}
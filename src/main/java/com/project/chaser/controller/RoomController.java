package com.project.chaser.controller;

import com.project.chaser.dto.Chat;
import com.project.chaser.dto.Room;
import com.project.chaser.dto.User;
import com.project.chaser.service.RoomService;
import org.springframework.messaging.simp.SimpMessagingTemplate;
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
    private final SimpMessagingTemplate messagingTemplate;

    // 생성자 주입
    public RoomController(RoomService roomService, SimpMessagingTemplate messagingTemplate) {
        this.roomService = roomService;
        this.messagingTemplate = messagingTemplate;
    }

    // 방 목록 페이지
    @GetMapping("/list")
    public String roomList(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        model.addAttribute("roomList", roomService.getAllRooms());
        return "gameSelect";
    }

    // **JSON 방 목록**
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
        Room room = new Room(roomId, title, mode, max, 1, password);
        room.getPlayers().add(user.getNickname());
        roomService.addRoom(room);

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

        // 플레이어 추가
        if (!room.getPlayers().contains(user.getNickname())) {
            roomService.enterRoom(roomId, user.getNickname());
        }

        model.addAttribute("room", room);
        model.addAttribute("user", user);
        return "gameRoom";
    }

    // 방 나가기
    @PostMapping("/leave")
    @ResponseBody
    public Map<String, Object> leaveRoom(@RequestBody Map<String, String> payload) {
        String roomId = payload.get("roomId");
        String nickname = payload.get("nickname");

        Map<String, Object> result = new HashMap<>();

        Room room = roomService.getRoom(roomId);
        if (room == null) {
            result.put("success", false);
            result.put("message", "방이 존재하지 않습니다.");
            return result;
        }

        roomService.leaveRoom(roomId, nickname);

        // 퇴장 메시지 및 상태 갱신
        Chat chat = new Chat();
        chat.setType("leave");
        chat.setRoomId(roomId);
        chat.setSender(nickname);
        chat.setMessage(nickname + "님이 퇴장했습니다.");
        chat.setPlayers(roomService.getPlayers(roomId));
        chat.setCurrent(room.getCurrent());
        chat.setHasPassword(room.getPassword() != null && !room.getPassword().isEmpty());

        messagingTemplate.convertAndSend("/topic/room/" + roomId + "/state", chat);
        messagingTemplate.convertAndSend("/topic/room/" + roomId + "/chat", chat);

        result.put("success", true);
        return result;
    }
}
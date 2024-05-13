package project.blog.community.otochat.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import project.blog.community.otochat.domain.ChatRoom;
import project.blog.community.otochat.domain.ChatUser;
import project.blog.community.otochat.dto.ChatMessageResponseDto;
import project.blog.community.otochat.dto.ChatRoomRequestDto;
import project.blog.community.otochat.dto.ChatRoomResponseDto;
import project.blog.community.otochat.dto.ChatRoomWithMessagesDto;
import project.blog.community.otochat.repository.ChatRoomRepository;
import project.blog.community.otochat.repository.ChatUserRepository;
import project.blog.community.otochat.service.ChatMessageService;
import project.blog.community.otochat.service.ChatRoomService;
import project.blog.community.project.entity.User;
import project.blog.community.project.mapper.UserMapper;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static project.blog.community.util.LoginUtils.getCurrentLoginMemberAccount;

// HTTP 방식의 통신과 관련된 기능 컨트롤러
@RestController
@RequiredArgsConstructor
@RequestMapping("/otochat")
public class ChatRoomController {

    private final ChatRoomService chatRoomService;
    private final ChatRoomRepository chatRoomRepository;
    private final ChatMessageService chatMessageService;
    private final ChatUserRepository chatUserRepository;

    @PostMapping("/room")
    public ResponseEntity<ChatRoomWithMessagesDto> makeRoom(
            @RequestBody ChatRoomRequestDto chatRoomRequestDto,
            HttpServletRequest request) {

        HttpSession session = request.getSession();
        session.getAttribute("login");
        // 세션 유틸리티 메서드로 로그인한 유저 ID 가져오기
        String myAccount = getCurrentLoginMemberAccount(session);

        ChatUser user = chatUserRepository
                .findChatUserByAccount(myAccount)
                .orElseThrow(() -> new RuntimeException("로그인 유저 정보가 없습니다."));

        ChatUser other = chatUserRepository.findChatUserByAccount(chatRoomRequestDto.getAccountNumber())
                .orElseThrow(() -> new RuntimeException("채팅 상대방 정보가 없습니다"));

        Optional<ChatRoom> optionalChatRoom = chatRoomRepository.findByUserAndOther(user, other);
        //고유한 값이어야 함


        //채팅방이 이미있으면, 반환
        if (optionalChatRoom.isPresent()) {
            ChatRoom foundChatRoom = optionalChatRoom.get();
            List<ChatMessageResponseDto> chatMessage = chatMessageService.findRoom(foundChatRoom.getRoomNumber());
            ChatRoom chatRoom = optionalChatRoom.get();
            ChatRoomWithMessagesDto chatRoomWithMessagesDto = new ChatRoomWithMessagesDto(chatRoom, chatMessage);
            
            return ResponseEntity.ok(chatRoomWithMessagesDto);

            //없으면 새로 만들기
            //other의 nickname을 받기(채팅 메시지에 user과 other이 있기 떄문에 member는 상관x)
        } else {
            ChatRoom newChatRoom=chatRoomService.save(user, other);
            ChatRoomWithMessagesDto chatRoomWithMessagesDto = new ChatRoomWithMessagesDto(newChatRoom, new ArrayList<>());
            return ResponseEntity.ok(chatRoomWithMessagesDto);
        }
    }


    //전체 조회
    @GetMapping("/list")
    public ResponseEntity<List<ChatRoomResponseDto>> findAll() {
        List<ChatRoomResponseDto> roomResponseDtos = chatRoomService.findByList();
        return ResponseEntity.ok(roomResponseDtos);
    }


    //채팅방 삭제
    @DeleteMapping("/{roomNumber}")
    public ResponseEntity<Void> DeleteChat(@PathVariable int roomNumber) {
        chatRoomService.delete(roomNumber);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}

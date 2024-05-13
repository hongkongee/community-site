package project.blog.community.otochat.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import project.blog.community.otochat.domain.ChatMessage;
import project.blog.community.otochat.dto.ChatMessageRequestDto;
import project.blog.community.otochat.dto.ChatMessageResponseDto;
import project.blog.community.otochat.repository.ChatMessageMapper;

import java.util.ArrayList;
import java.util.List;

// 채팅방 메세지를 저장하는 로직
@Service
@RequiredArgsConstructor
@Slf4j
public class ChatMessageService {
    private final ChatMessageMapper chatMessageMapper;
//    private final MemberMapper memberMapper; -> UserMapper

    @Transactional
    public void save(final ChatMessageRequestDto requestDto) {
        ChatMessage chatMessage=requestDto.toEntity();
        chatMessageMapper.save(chatMessage);
    }

    @Transactional
    public List<ChatMessageResponseDto> findRoom(int roomNumber) {

        List<ChatMessage> chatMessage = this.chatMessageMapper.findByRoomNumber(roomNumber);

        List<ChatMessageResponseDto> dtolist = new ArrayList<>();
        for (ChatMessage chatMessage1 : chatMessage) {
            ChatMessageResponseDto responseDto = new ChatMessageResponseDto(chatMessage1);
            dtolist.add(responseDto);
        }
        return dtolist;
    }
}

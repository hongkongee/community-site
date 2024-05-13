package project.blog.community.otochat.repository;

import org.springframework.stereotype.Repository;
import project.blog.community.otochat.domain.ChatMessage;
import project.blog.community.otochat.domain.ChatRoom;

import java.util.List;

@Repository
public interface ChatMessageRepository extends JpaRepository<ChatRoom, Long> {
    // 채팅 메세지 DB에 저장하기
    void save(ChatMessage chatMessage);

    // 방번호로 채팅 내역 찾기
    List<ChatMessage> findByRoomNumber(int roomNumber);

    // 방번호로 가장 최신 메세지 찾기
    ChatMessage findTopByRoomNumberOrderByCreatedTimeDesc(int roomNumber);

    // 방번호로 모든 채팅 찾기
    List<ChatMessage> findAllByRoomNumber(int roomNumber);
}

package project.blog.community.otochat.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import project.blog.community.otochat.domain.ChatMessage;
import project.blog.community.otochat.domain.ChatRoom;

import java.util.List;

@Repository
public interface ChatMessageRepository extends JpaRepository<ChatRoom, Long> {

    // 방번호로 채팅 내역 찾기
    List<ChatMessage> findByRoomNumber(int roomNumber);

    // 방번호로 가장 최신 메세지 찾기
    ChatMessage findTopByRoomNumberOrderByCreatedTimeDesc(int roomNumber);

    // 방번호로 모든 채팅 찾기
    List<ChatMessage> findAllByRoomNumber(int roomNumber);

    // 특정 방번호의 모든 메세지 삭제
    void deleteAll(List<ChatMessage> messagesToDelete);
}

package project.blog.community.otochat.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import project.blog.community.otochat.domain.ChatRoom;
import project.blog.community.otochat.domain.ChatUser;
import project.blog.community.project.entity.User;

import java.util.Optional;

@Repository
public interface ChatRoomRepository extends JpaRepository<ChatRoom, Long> {

    Optional<ChatRoom> findByRoomNumber(int roomNumber);

    Optional<ChatRoom> findByUserAndOther(ChatUser user, ChatUser other);
}

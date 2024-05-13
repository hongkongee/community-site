package project.blog.community.otochat.repository;

import org.springframework.stereotype.Repository;
import project.blog.community.otochat.domain.ChatRoom;
import project.blog.community.project.entity.User;

@Repository
public interface ChatRoomRepository extends JpaRepository<ChatRoom, Long> {

    Optional<ChatRoom> findByRoomNumber(int roomNumber);

    Optional<ChatRoom> findByMemberAndOther(User user, User other);
}

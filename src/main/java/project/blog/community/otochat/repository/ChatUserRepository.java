package project.blog.community.otochat.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import project.blog.community.otochat.domain.ChatUser;

import java.util.Optional;

@Repository
public interface ChatUserRepository extends JpaRepository<ChatUser, String> {

    Optional<ChatUser> findChatUserByAccount(String account);
}

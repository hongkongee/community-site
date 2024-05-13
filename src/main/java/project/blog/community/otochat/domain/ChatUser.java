package project.blog.community.otochat.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

// User table의 자식 table로 채팅 서비스만을 위한 유저 테이블
@NoArgsConstructor
@Getter
@Entity
@Table(name="chatuser")
public class ChatUser {

    @Id
    private String account;

    // 회원 이름
    private String name;

    private String nickname;

    // 회원 프사
    private String profilePicture;
}

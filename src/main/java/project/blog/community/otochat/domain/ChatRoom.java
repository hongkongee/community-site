package project.blog.community.otochat.domain;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Table;

import javax.persistence.*;

@NoArgsConstructor
@Getter
@Entity
@Table(name="chatroom")
public class ChatRoom extends BaseTimeEntity {

    // BaseTimeEntity : JPA 생성/수정 시간 자동 설정

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int roomNumber;

    @ManyToOne
    @JoinColumn(name="my_id")
    private ChatUser user; //방을 만든 사람

    @ManyToOne
    @JoinColumn(name="other_id")
    private ChatUser other; //대화상대

    @Builder
    public ChatRoom(ChatUser other,  ChatUser user) {
        this.other=other;
        this.user=user;
    }
}

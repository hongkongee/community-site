package project.blog.community.otochat.domain;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import javax.persistence.Entity;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.GeneratedValue;
//import org.springframework.data.mongodb.core.mapping.Document;

// 채팅 메세지 entity
@Getter
//@Document(collection = "chatMessage") -> MongoDB 컬렉션 이름 지정 어노테이션
@Entity
@NoArgsConstructor
public class ChatMessage {

    // @Id : PK 지정
    // @GeneratedValue : PK에 대한 생성 전략 제공

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String id;
    private String userName; //user_name;
    private String msg; //msg
    private String imageUrl;
    private int roomNumber;
    private String createdTime;


    @Builder //생성자 빌드
    public ChatMessage(String msg, String imageUrl, int roomNumber, String userName) {
        this.msg = msg;
        this.imageUrl = imageUrl;
        this.roomNumber=roomNumber;
        this.userName=userName;
        this.createdTime = ZonedDateTime.now().format(DateTimeFormatter.ISO_ZONED_DATE_TIME);
    }
}

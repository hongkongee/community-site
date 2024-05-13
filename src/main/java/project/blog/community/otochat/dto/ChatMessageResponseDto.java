package project.blog.community.otochat.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
import project.blog.community.otochat.domain.ChatMessage;

@Getter
@NoArgsConstructor
@ToString
@AllArgsConstructor
public class ChatMessageResponseDto {

    private String id;
    private String userName; //user_name;
    private String msg; //msg
    private String imageUrl;
    private int roomNumber;
    private String createdTime;

    // entity를 dto로 바꾸는 생성자
    public ChatMessageResponseDto(ChatMessage chatMessage) {
        this.id = chatMessage.getId();
        this.userName = chatMessage.getUserName();
        this.msg = chatMessage.getUserName();
        this.roomNumber = chatMessage.getRoomNumber();
        this.createdTime = chatMessage.getCreatedTime();

    }
}

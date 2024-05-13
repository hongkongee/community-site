package project.blog.community.otochat.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import project.blog.community.otochat.domain.ChatMessage;

// 채팅 메세지 request DTO
@Getter
@Setter
@NoArgsConstructor
public class ChatMessageRequestDto {
    public enum MessageType{
        ENTER, TALK
    }

    private String userName; //username;
    private String msg; //msg
    private String imageUrl; // file(BYTE형식으로 변환?)
    private int roomNumber;


    //생성자
    @Builder
    public ChatMessageRequestDto(String userName, String msg, String imageUrl, int roomNumber) {
        this.msg = msg;
        this.userName = userName;
        this.imageUrl = imageUrl;
        this.roomNumber=roomNumber;

    }
    //객체 만들기
    public ChatMessage toEntity() {
        return ChatMessage.builder()
                .userName(userName)
                .msg(msg)
                .imageUrl(imageUrl)
                .roomNumber(roomNumber)
                .build();
    }
}

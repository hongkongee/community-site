package project.blog.community.otochat.dto;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
import project.blog.community.otochat.domain.ChatRoom;

@Getter
@NoArgsConstructor
@ToString
@AllArgsConstructor
public class ChatRoomResponseDto {

    private int roomNumber;
    private String userAccount;
    private String otherAccount;

    private String msg;
    private String createdTime;

    public ChatRoomResponseDto(ChatRoom chatRoom, String msg, String createdTime) {
        this.roomNumber = chatRoom.getRoomNumber();
        this.userAccount = chatRoom.getUser().getAccount();
        this.otherAccount = chatRoom.getOther().getAccount();

        this.msg = msg;
        this.createdTime = createdTime;

    }
}

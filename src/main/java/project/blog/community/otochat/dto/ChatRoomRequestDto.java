package project.blog.community.otochat.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

// 채팅방 생성 시 요청으로 받는 dto (상대방의 아이디 정보)
@Getter
@NoArgsConstructor
public class ChatRoomRequestDto {
//    private String nickname;
    private String accountNumber;

    @Builder
    public ChatRoomRequestDto(String accountNumber) {
        this.accountNumber = accountNumber;
    }
}

package project.blog.community.project.dto.response;

import lombok.*;
import project.blog.community.project.entity.Board;
import project.blog.community.project.entity.User;

@Getter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FollowerResponseDTO {

    private String accountNumber;
    private String name;
    private String email;
    private String nickname;
    private String profilePicture;
    private String loginMethod;

    public FollowerResponseDTO(User user) {
        this.name = user.getName();
        this.email = user.getEmail();
        this.nickname = user.getNickname();
        this.profilePicture = user.getProfilePicture();
        this.accountNumber =  user.getAccountNumber();
        this.loginMethod = user.getLoginMethod().toString();
    }


}

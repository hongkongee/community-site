package project.blog.community.project.dto.response;

import lombok.*;
import project.blog.community.project.entity.Gender;
import project.blog.community.project.entity.User;

@Getter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MypageUserResponseDTO {

    private String accountNumber;

    private String email;

    private String nickname;

    private Gender gender;

    private int birthday; // year

    private String profilePicture;

    public MypageUserResponseDTO(User user) {
        this.accountNumber = user.getAccountNumber();
        this.email = user.getEmail();
        this.nickname = user.getNickname();
        this.gender = user.getGender();
        this.birthday = user.getBirthday();
        this.profilePicture = user.getProfilePicture();
    }

}

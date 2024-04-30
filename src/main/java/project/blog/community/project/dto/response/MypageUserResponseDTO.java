package project.blog.community.project.dto.response;

import lombok.*;
//import project.blog.community.project.entity.Gender;
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

    private String name;

//    private Gender gender;

    private int birthday; // year

    private String profilePicture;

    private float rate;

    private String introduction;

    private int point;

    private String loginMethod;

    public MypageUserResponseDTO(User user) {
        this.accountNumber = user.getAccountNumber();
        this.email = user.getEmail();
        this.nickname = user.getNickname();
//        this.gender = user.getGender();
        this.birthday = user.getBirthday();
        this.profilePicture = user.getProfilePicture();
        this.rate = user.getRate();
        this.loginMethod = String.valueOf(user.getLoginMethod());

        this.introduction = user.getIntroduction();
        this.name = user.getName();

        this.point = user.getPoint();
    }

}

package project.blog.community.project.dto.request;

import lombok.*;
import org.springframework.security.crypto.password.PasswordEncoder;
import project.blog.community.project.entity.User;

@Getter
@Setter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserRequestDTO {

    // 회원 아이디
    private String accountNumber;

    // 회원 비밀번호
    private String password;

    private String gender;

    private String nickname;

    // 회원 생일(year)
    private int birthday;


    public User toEntity(PasswordEncoder encoder) {
        return User.builder()
                .accountNumber(accountNumber)
                .password(encoder.encode(password))
                .birthday(birthday)
                .gender(gender)
                .nickname(nickname)
                .build();
    }
}

package project.blog.community.project.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.multipart.MultipartFile;
import project.blog.community.project.entity.LoginMethod;
import project.blog.community.project.entity.User;

@Setter @Getter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SignUpRequestDto {

   @NotBlank
   @Size(min = 4, max = 10)
   private String accountNumber;

   @NotBlank
   private String password;

   @NotBlank
   @Size(min = 2, max= 6)
   private String name;

   @NotBlank
   @Email
   private String email;

   @NotBlank
   @Size(max=4)
   private int birthday;

   @NotBlank
   private String gender;

   @NotBlank
   @Size(min = 2, max = 8)
   private String nickname;

   // 프로필 사진 이미지
   private MultipartFile profilePicture;

   private LoginMethod loginMethod;

   public User toEntity(PasswordEncoder encoder) {
      return User.builder()
            .accountNumber(accountNumber)
            .password(encoder.encode(password))
            .name(name)
            .email(email)
            .birthday(birthday)
            .gender(gender)
            .nickname(nickname)
            .profilePicture(null) // 나중에 경로 넣어야 함
            .loginMethod(loginMethod)
            .build();
   }


}













































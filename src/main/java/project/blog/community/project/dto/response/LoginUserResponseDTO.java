package project.blog.community.project.dto.response;

import lombok.*;

@Getter @Setter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LoginUserResponseDTO {

   public String accountNumber;
   public String name;
   private String email;
   private String auth;
   private String gender;
   private String nickname;
   private String profilePicture;
   private String loginMethod;
   private int point;

}














































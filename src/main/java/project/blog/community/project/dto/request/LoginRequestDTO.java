package project.blog.community.project.dto.request;

import lombok.*;

@Getter @Setter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LoginRequestDTO {

   private String accountNumber;
   private String password;
   private boolean autoLogin;

}













































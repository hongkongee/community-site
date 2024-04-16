package project.blog.community.project.entity;

import lombok.*;
import org.springframework.cglib.core.Local;

import java.time.LocalDateTime;

@Setter @Getter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {

   // 회원 아이디
   private String accountNumber;
   // 회원 비밀번호
   private String password;
   // 회원 이름
   private String name;
   // 회원 이메일
   private String email;
   // 회원 권한
   private Auth auth;
   // 회원 가입 일자
   private LocalDateTime regDate;

   private Gender gender;

   // 회원 생일(year)
   private int birthday;

   // 쿠키
   private String sessionId;
   // 쿠키 수명
   private LocalDateTime limitTime;

   // 회원 프사
   private String profilePicture;

   // 회원 가입 방법
   private LoginMethod loginMethod;



}













































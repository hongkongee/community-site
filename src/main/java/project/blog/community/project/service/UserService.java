package project.blog.community.project.service;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.util.WebUtils;
import project.blog.community.project.dto.request.AutoLoginDTO;
import project.blog.community.project.dto.request.LoginRequestDTO;
import project.blog.community.project.dto.request.SignUpRequestDto;
import project.blog.community.project.dto.response.LoginUserResponseDTO;
import project.blog.community.project.entity.User;
import project.blog.community.project.mapper.UserMapper;

import java.time.LocalDateTime;

import static project.blog.community.project.service.LoginResult.*;
import static project.blog.community.util.LoginUtils.*;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserService {

   private final UserMapper userMapper;
   private final PasswordEncoder encoder;

   // 회원 가입 서비스
   public void join(SignUpRequestDto dto, String savePath) {

      userMapper.save(dto.toEntity(encoder, savePath));
   }

   // 로그인 검증 처리
   public LoginResult authenticate(LoginRequestDTO dto,
                                   HttpSession session,
                                   HttpServletResponse response) {

      User foundUser = userMapper.findUser(dto.getAccountNumber());

      if (foundUser == null) {
         log.info("{} (은)는 없는 아이디!", dto.getAccountNumber());
         return NO_ACC;
      }

      // 비밀번호 일치 검사
      String inputPassword = dto.getPassword();
      String realPassword = foundUser.getPassword();

      if (!encoder.matches(inputPassword, realPassword)) {
         log.info("비밀번호가 다르다!");
         return NO_PW;
      }

      // 자동 로그인 처리
      if (dto.isAutoLogin()) {
         // 자동 로그인 쿠키 생성
         Cookie autoLoginCookie = new Cookie(AUTO_LOGIN_COOKIE, session.getId());

         // 쿠키 설정
         int limitTime = 60 * 60 * 24 * 90;
         autoLoginCookie.setPath("/");
         autoLoginCookie.setMaxAge(limitTime);

         // 쿠키를 클라이언트에게 전송하기 위해 응답
         response.addCookie(autoLoginCookie);

         userMapper.saveAutoLogin(AutoLoginDTO.builder()
               .sessionId(session.getId())
               .limitTime(LocalDateTime.now().plusDays(10))
               .account(dto.getAccountNumber())
               .build());

      }

      log.info("{} 님 로그인 성공!", dto.getAccountNumber());
      return SUCCESS;


   }


   public boolean checkDuplicateValue(String type, String keyword) {
      return userMapper.isDuplicate(type, keyword);
   }

   public void maintainLoginState(HttpSession session, String accountNumber) {
      User foundMember = userMapper.findUser(accountNumber);

      LoginUserResponseDTO dto = LoginUserResponseDTO.builder()
            .accountNumber(foundMember.getAccountNumber())
            .name(foundMember.getName())
            .email(foundMember.getEmail())
            .gender(String.valueOf(foundMember.getGender()))
            .nickname(foundMember.getNickname())
            .auth(foundMember.getAuth().getDescription())
            .profile(foundMember.getProfilePicture())
            .loginMethod(foundMember.getLoginMethod().toString())
            .build();

      // 세션에 로그인한 회원 정보를 저장
      session.setAttribute(LOGIN_KEY, dto);
      /// 세션 수명 설정
      session.setMaxInactiveInterval(60 * 60);
   }


   public void autoLoginClear(HttpServletRequest request, HttpServletResponse response) {

      // 자동 로그인 쿠키를 가져온다.
      Cookie c = WebUtils.getCookie(request, AUTO_LOGIN_COOKIE);

      // 쿠키 삭제
      if (c != null) {
         c.setMaxAge(0);
         c.setPath("/");
         response.addCookie(c);
      }

      userMapper.saveAutoLogin(
            AutoLoginDTO.builder()
                  .sessionId("none")
                  .limitTime(LocalDateTime.now())
                  .account(getCurrentLoginMemberAccount(request.getSession()))
                  .build()
      );

   }

}













































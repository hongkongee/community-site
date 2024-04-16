package project.blog.community.project.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import project.blog.community.project.dto.request.LoginRequestDTO;
import project.blog.community.project.dto.request.SignUpRequestDto;
import project.blog.community.project.entity.User;
import project.blog.community.project.mapper.UserMapper;

import static project.blog.community.project.service.LoginResult.*;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserService {

   private final UserMapper userMapper;
   private final PasswordEncoder encoder;

   // 회원 가입 서비스
   public void join(SignUpRequestDto dto) {

      userMapper.save(dto.toEntity(encoder));
   }

   // 로그인 검증 처리
   public LoginResult authenticate(LoginRequestDTO dto) {

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

      log.info("{} 님 로그인 성공!", dto.getAccountNumber());
      return SUCCESS;


   }


}













































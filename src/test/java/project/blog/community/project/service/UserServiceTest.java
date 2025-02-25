package project.blog.community.project.service;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;


@SpringBootTest
class UserServiceTest {

   @Autowired
   UserService userService;

   @Test
   @DisplayName("회원정보를 전달하면 비밀번호가 암호화돠어 DB에 저장될 것이다.")
   void join() {

/*      SignUpRequestDto dto = SignUpRequestDto.builder()
            .accountNumber("test444")
            .password("test44!")
            .name("테스트4")
            .email("test444@gmail.com")
            .birthday(2002)
            .gender(String.valueOf(MALE))
            .nickname("mr.test2")
            .build();

      userService.join(dto);*/

   }

   @Test
   @DisplayName("계정명이 test222인 회원의 로그인 시도 결과를 상황별로 검증한다.")
   void authenticate() {

/*
      LoginRequestDTO dto = LoginRequestDTO.builder()
            .accountNumber("test222")
            .password("test222!")
            .build();

      LoginResult result = userService.authenticate(dto);

      assertEquals(SUCCESS, result);
*/

   }
}


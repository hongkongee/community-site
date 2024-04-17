package project.blog.community.project.mapper;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import project.blog.community.project.entity.Gender;
import project.blog.community.project.entity.User;

import static org.junit.jupiter.api.Assertions.*;
import static project.blog.community.project.entity.Gender.*;

@SpringBootTest
class UserMapperTest {

   @Autowired
   UserMapper userMapper;


   @Test
   @DisplayName("회원가입 성공해야 한다.")
   void save() {
      User user = User.builder()
            .accountNumber("test999")
            .password("test999!")
            .name("테스트9")
            .email("test99@gmail.com")
            .birthday(2000)
            .gender(FEMALE)
            .nickname("테스트9")
            .build();

      userMapper.save(user);
   }


   @Test
   @DisplayName("아이디가 test123인 계정을 조회하면 그 회원의 이름은 테스트이어야 한다.")
   void findUser() {
      String id = "test123";

      User user = userMapper.findUser(id);

      assertEquals(user.getName(), "테스트");

   }

   @Test
   @DisplayName("이메일이 test122@gmail.com일 경우 중복확인 false여야 한다.")
   void isDuplicate() {
      String email = "test122@gmail.com";

      boolean emailFlag = userMapper.isDuplicate("email", email);

      assertFalse(emailFlag);

   }
}
















































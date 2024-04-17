package project.blog.community.project.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import project.blog.community.project.entity.User;

@Mapper
public interface UserMapper {

   // 회원 가입
   void save(User user);

   // 회원 정보 조회
   User findUser(String accountNumber);

   // 중복 체크
   boolean isDuplicate(@Param("type") String type, @Param("keyword") String keyword);

}
















































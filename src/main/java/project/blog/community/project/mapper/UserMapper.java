package project.blog.community.project.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import project.blog.community.project.dto.request.AutoLoginDTO;
import project.blog.community.project.entity.User;

@Mapper
public interface UserMapper {

   // 회원 가입
   void save(User user);

   // 회원 정보 조회
   User findUser(String accountNumber);

   // 중복 체크
   boolean isDuplicate(@Param("type") String type, @Param("keyword") String keyword);

   // 신고 횟수 1 증가
   void updateReport(String accountNumber);

   // 자동 로그인 세션아이디, 만료시간 업데이트
   void saveAutoLogin(AutoLoginDTO build);

   // 쿠키값(세션아이디)으로 회원정보를 조회
   User findMemberByCookie(String sessionId);



}
















































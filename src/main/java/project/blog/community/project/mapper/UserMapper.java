package project.blog.community.project.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import project.blog.community.project.dto.request.AutoLoginDTO;
import project.blog.community.project.entity.User;

import java.util.List;

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

   // 팔로우한 유저 찾기
   List<String> findUserByFollower(@Param("number") int number, @Param("account") String currentLoginMemberAccount);

   // 팔로우 추가하기
   void addFollower(@Param("me") String currentLoginMemberAccount, @Param("you") String followerAccount);

   void removeFollower(@Param("me") String myAccount, @Param("you") String userAccount);

   // 팔로우하는 유저 찾기
   List<String> findUserByFollowing(String account);

   // 포인트 증가시키기
   void addPoint(@Param("me") String myAccount, @Param("point") int todayPoint);


}
















































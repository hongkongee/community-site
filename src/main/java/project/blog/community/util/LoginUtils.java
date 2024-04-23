package project.blog.community.util;


import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import project.blog.community.project.dto.response.LoginUserResponseDTO;

// 회원 인증
@Slf4j
public class LoginUtils {

   // 로그인 세션
   public static final String LOGIN_KEY = "login";

   // 자동 로그인
   public static final String AUTO_LOGIN_COOKIE = "auto";

   // 로그인 여부 확인
   public static boolean isLogin(HttpSession session) {
      return session.getAttribute(LOGIN_KEY) != null;
   }

   // 로그인 한 사람의 계정명을 반환해 주는 메서드
   public static String getCurrentLoginMemberAccount (HttpSession session) {
      LoginUserResponseDTO loginUser = (LoginUserResponseDTO) session.getAttribute(LOGIN_KEY);
      return loginUser.getAccountNumber();
   }

   // 사용자 쓴 게시물인지 확인해 주는 메서드
   public static boolean isMine(HttpSession session, String targetAccount) {
      return targetAccount.equals(getCurrentLoginMemberAccount(session));
   }

   // 관리자인지 확인해주는 메서드
   public static boolean isAdmin(HttpSession session) {
      LoginUserResponseDTO loginUser = (LoginUserResponseDTO) session.getAttribute(LOGIN_KEY);
      log.info("loginUser: {}", loginUser);
      return loginUser.getAuth().equals("관리자");

   }


}













































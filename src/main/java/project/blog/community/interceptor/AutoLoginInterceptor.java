package project.blog.community.interceptor;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.util.WebUtils;
import project.blog.community.project.entity.User;
import project.blog.community.project.mapper.UserMapper;
import project.blog.community.project.service.UserService;
import project.blog.community.util.LoginUtils;

import java.time.LocalDateTime;

import static project.blog.community.util.LoginUtils.*;

@Configuration
@Slf4j
@RequiredArgsConstructor
public class AutoLoginInterceptor implements HandlerInterceptor{

   private final UserMapper userMapper;
   private final UserService userService;

   @Override
   public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

      // 사이트에 들어오면 자동 로그인 쿠키를 가진 클라이언트인지를 체크
      Cookie autoLoginCookie = WebUtils.getCookie(request, AUTO_LOGIN_COOKIE);

      // 자동 로그인 쿠키가 있다면
      if (autoLoginCookie != null) {
         // 읽어들인 쿠키가 가지고 있는 session_id를 꺼내자
         String sessionId = autoLoginCookie.getValue();

         // DB에서 쿠키가 가지고 있던 session_id와 동일한 값을 가진 회원을 조회
         User user = userMapper.findMemberByCookie(sessionId);

         // 회원이 정상적으로 조회가 됐다면 and 자동 로그인 만료시간 이전이면 로그인을 수행한다.
         if (user != null && LocalDateTime.now().isBefore(user.getLimitTime())) {
            userService.maintainLoginState(request.getSession(), user.getAccountNumber());
         }

      }
      // 자동로그인을 신청했던 사람이든, 아니든
      // 요청을 무조건 컨트롤러로 전달되어야 하니까 return 값을 true가 고정입니다.
      return true;
   }
}













































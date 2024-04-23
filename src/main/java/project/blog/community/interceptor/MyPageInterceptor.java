package project.blog.community.interceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;

import static project.blog.community.util.LoginUtils.isLogin;

@Configuration
@Slf4j
public class MyPageInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        HttpSession session = request.getSession();

        if (!isLogin(session)) {
            log.info("권한 없음! 요청 거부 = {}", request.getRequestURI());
            response.sendRedirect("/users/sign-in");
            return false;
        }

        return true;

    }
}

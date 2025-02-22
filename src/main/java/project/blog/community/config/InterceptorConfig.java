package project.blog.community.config;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import project.blog.community.interceptor.AfterLoginInterceptor;
import project.blog.community.interceptor.AutoLoginInterceptor;
import project.blog.community.interceptor.BoardInterceptor;
import project.blog.community.interceptor.BoardInterceptor;
import project.blog.community.interceptor.MyPageInterceptor;

@Configuration
@RequiredArgsConstructor
public class InterceptorConfig implements WebMvcConfigurer {

   private final AfterLoginInterceptor afterLoginInterceptor;
   private final BoardInterceptor boardInterceptor;
   private final AutoLoginInterceptor autoLoginInterceptor;
   private final MyPageInterceptor myPageInterceptor;

   @Override
   public void addInterceptors(InterceptorRegistry registry) {
      registry.addInterceptor(afterLoginInterceptor)
            .addPathPatterns("/users/sign-up", "/users/sign-in");

      registry
            .addInterceptor(boardInterceptor)
            .addPathPatterns("/home/**", "/market/**", "/game/**", "/chat/chat")
            .excludePathPatterns("/home/main");

      registry
            .addInterceptor(autoLoginInterceptor)
            .addPathPatterns("/**");

      registry
              .addInterceptor(myPageInterceptor)
              .addPathPatterns("/mypage/home/**");
   }


}













































package project.blog.community.config;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import project.blog.community.interceptor.AfterLoginInterceptor;

@Configuration
@RequiredArgsConstructor
public class InterceptorConfig implements WebMvcConfigurer {

   private final AfterLoginInterceptor afterLoginInterceptor;

   @Override
   public void addInterceptors(InterceptorRegistry registry) {
      registry.addInterceptor(afterLoginInterceptor)
            .addPathPatterns("/users/sign-up", "/users/sign-in");
   }


}













































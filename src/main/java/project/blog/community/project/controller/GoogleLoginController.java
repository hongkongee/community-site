package project.blog.community.project.controller;


import jakarta.servlet.http.HttpSession;
import lombok.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import project.blog.community.project.service.GoogleLoginService;
import project.blog.community.project.service.SnsLoginService;

import java.util.HashMap;
import java.util.Map;

@Controller
@Slf4j
@RequiredArgsConstructor
public class GoogleLoginController {

    private final GoogleLoginService googleLoginService;



    @org.springframework.beans.factory.annotation.Value("${sns.google.client-id}")
    private String googleAppKey;

    @org.springframework.beans.factory.annotation.Value("${sns.google.redirect-uri}")
    private String googleRidirectUri;


    @GetMapping("/google/login")
    public String googleLogin() {
        String uri = "https://kauth.kakao.com/oauth/authorize";
        uri += "?client_id=" + googleAppKey;
        uri += "&redirect_uri=" + googleRidirectUri;
        uri += "&response_type=code";

        return "redirect:" + uri;
    }

    // 카카오 인가 코드 받기
    @GetMapping("/auth/google")
    public String snsGoogle(String code, HttpSession session) {
        log.info("구글 로그인 인가 코드:{}", code);

        // 인가 코드를 가지고 카카오 인증 서버에 토큰 발급 요청을 보내자
        // 서비스에게 시킬 것 (server to server 통신)
        Map<String, String> params = new HashMap<>();
        params.put("appKey", googleAppKey);
        params.put("redirect", googleRidirectUri);
        params.put("code", code);

        googleLoginService.googleLogin(params, session);

        // 로그인 처리가 모두 완료되면 홈 화면으로
        return "redirect:/";
    }




}




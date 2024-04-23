package project.blog.community.project.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import project.blog.community.project.service.SnsLoginService;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;

@Controller
@Slf4j
@RequiredArgsConstructor
public class SnsLoginController {

    private final SnsLoginService snsLoginService;

    @Value("${sns.kakao.app-key}")
    private String kakaoAppKey;

    @Value("${sns.kakao.redirect-uri}")
    private String kakaoRidirectUri;

    @Value("${sns.naver.client-id}")
    private String naverClientId;

    @Value("${sns.naver.client-secret}")
    private String naverClientSecret;

    @Value("${sns.naver.client-callback-uri}")
    private String naverCallbakUri;

    @GetMapping("/kakao/login")
    public String kakaoLogin() {
        String uri = "https://kauth.kakao.com/oauth/authorize";
        uri += "?client_id=" + kakaoAppKey;
        uri += "&redirect_uri=" + kakaoRidirectUri;
        uri += "&response_type=code";

        return "redirect:" + uri;
    }

    // 카카오 인가 코드 받기
    @GetMapping("/auth/kakao")
    public String snsKakao(String code, HttpSession session) {
        log.info("카카오 로그인 인가 코드:{}", code);

        // 인가 코드를 가지고 카카오 인증 서버에 토큰 발급 요청을 보내자
        // 서비스에게 시킬 것 (server to server 통신)
        Map<String, String> params = new HashMap<>();
        params.put("appKey", kakaoAppKey);
        params.put("redirect", kakaoRidirectUri);
        params.put("code", code);

        snsLoginService.kakaoLogin(params, session);

        // 로그인 처리가 모두 완료되면 홈 화면으로
        return "redirect:/";
    }

    // 네이버 인가코드 받기
    @GetMapping("/naver/login")
    public String naverConnect() {
        // state용 난수 생성
        SecureRandom random = new SecureRandom();
        String state = new BigInteger(130, random).toString(32);

        String uri = "https://nid.naver.com/oauth2.0/authorize?";
        uri += "response_type=code";
        uri += "&client_id=" + naverClientId;
        uri += "&redirect_uri=" + naverCallbakUri;
        uri += "&state=" + state;

        return "redirect:" + uri;

    }

    // 네이버 토큰 발급 받기
    @RequestMapping(value = "/callback", method = {RequestMethod.GET, RequestMethod.POST},
            produces = "application/json")
    public void naverLogin(@RequestParam(value = "code") String code,
                           @RequestParam(value = "state") String state) {
        // 네이버에 요청 보내기
        RestTemplate template = new RestTemplate();

    }

}

//package project.blog.community.project.service;
//
//import jakarta.servlet.http.HttpSession;
//import lombok.RequiredArgsConstructor;
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.http.*;
//import org.springframework.stereotype.Service;
//import org.springframework.util.LinkedMultiValueMap;
//import org.springframework.util.MultiValueMap;
//import org.springframework.web.client.RestOperations;
//import org.springframework.web.client.RestTemplate;
//import project.blog.community.project.dto.request.SignUpRequestDto;
//import project.blog.community.project.dto.response.GoogleUserResponseDTO;
//import project.blog.community.project.dto.response.KakaoUserResponseDTO;
//import project.blog.community.project.entity.User;
//
//import java.util.Map;
//
//
//@Service
//@Slf4j
//@RequiredArgsConstructor
//
//public class GoogleLoginService {
//    private final UserService userService;
//
//    @Value("${spring.security.oauth2.client.registration.google.client-id}")
//    private String clientId;
//
//    @Value("${spring.security.oauth2.client.registration.google.redirect-uri}")
//    private String redirectUri;
//
//    @Value("${spring.security.oauth2.client.registration.google.client-secret}")
//    private String clientSecret;
//
//
//
//
//    // 토큰 발급 요청
//    private String getGoogleAccessToken(String code, String clientId, String clientSecret, String redirectUri) {
//
//
//        // Google OAuth 2.0의 토큰 발급 엔드포인트 URL
//        String tokenUri = "https://oauth2.googleapis.com/token";
//
//        // HTTP 요청을 보낼 때 필요한 헤더 설정
//        HttpHeaders headers = new HttpHeaders();
//        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
//
//
//        // 요청 바디에 파라미터 세팅
//        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
//        params.add("code", code);
//        params.add("client_id", clientId);
//        params.add("client_secret", clientSecret);
//        params.add("redirect_uri", redirectUri);
//        params.add("grant_type", "authorization_code");
//
//        // REST API를 호출하기 위한 RestTemplate 객체 생성
//        RestTemplate restTemplate = new RestTemplate();
//
//        // Google OAuth 서버에 POST 요청을 보내서 액세스 토큰을 요청
//        ResponseEntity<Map> responseEntity = restTemplate.postForEntity(
//                tokenUri,
//                new HttpEntity<>(params, headers),
//                Map.class
//        );
//
//        // 응답에서 액세스 토큰을 추출하여 반환
//        Map<String, String> responseMap = responseEntity.getBody();
//        String accessToken = responseMap.get("access_token");
//
//        return accessToken;
//
//    }
//
//
//
//    public void googleLogin(Map<String, String> params, HttpSession session) {
//
//
//        String accessToken = getGoogleAccessToken(code, clientId, clientSecret,
//                "http://localhost:8989/auth/google");
//        log.info("access_token: {}", accessToken);
//
//
//        // 전달받은 엑세스 토큰을 활용하여 사용자의 정보 가져오기
//        GoogleUserResponseDTO dto = getGoogleUserInfo(accessToken);
//
//        // 카카오에서 받은 회원정보로 우리 사이트 회원가입
//        String email = dto.getEmail();
//        log.info("email: {}", email);
//
//        String nickname = dto.getNickname();
//        log.info("이메일: {}", email);
//
//        // 회원 중복 확인 (이메일)
//        if (!userService.checkDuplicateValue("email", email)) {
//            // 한 번도 구글 로그인을 한 적이 없다면 회원가입 진행
//            userService.join(
//                    SignUpRequestDto.builder()
//                            .email(email)
//                            .password("0000")
//                            .nickname(dto.getNickname())
//                            .loginMethod(User.LoginMethod.GOOGLE)
//                            .build(),
//                    null
//            );
//        }
//
//        // 우리 사이트 로그인 처리
//        userService.maintainLoginState(session, email);
//
//    }
//
//    private GoogleUserResponseDTO getGoogleUserInfo(String accessToken) {
//
//        String requestUri = "https://www.googleapis.com/oauth2/v3/userinfo";
//
//        // 요청 헤더
//        HttpHeaders headers = new HttpHeaders();
//        headers.add("Authorization", "Bearer " + accessToken);
//        //headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
//
//        // 요청 보내기
//        RestTemplate template = new RestTemplate();
//        ResponseEntity<GoogleUserResponseDTO> responseEntity = template.exchange(
//                requestUri,
//                HttpMethod.POST,
//                new HttpEntity<>(headers),
//                GoogleUserResponseDTO.class
//        );
//
//        GoogleUserResponseDTO responseJSON = responseEntity.getBody();
//        log.info("응답 데이터 결과 : {}", responseJSON);
//
//        return responseJSON;
//
//    }
//}
//

package project.blog.community.project.service;


import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import project.blog.community.project.dto.response.GoogleUserResponseDTO;
import project.blog.community.project.dto.response.NaverUserResponseDTO;
import project.blog.community.project.dto.request.SignUpRequestDto;
import project.blog.community.project.dto.response.KakaoUserResponseDTO;
import project.blog.community.project.entity.User;

import java.time.LocalDateTime;
import java.util.Map;



@Service
@Slf4j
@RequiredArgsConstructor
public class SnsLoginService {

    private final UserService userService;
    
    // 카카오 로그인 처리
    public void kakaoLogin(Map<String, String> params, HttpSession session) {

        String accessToken = getKakaoAccessToken(params);
        log.info("access_token: {}", accessToken);
        
        // 전달받은 엑세스 토큰을 활용하여 사용자의 정보 가져오기
        KakaoUserResponseDTO dto = getKakaoUserInfo(accessToken);

        // 카카오에서 받은 회원정보로 우리 사이트 회원가입
        String id = String.valueOf(dto.getId());
        log.info("카카오 아이디: {}", id);

        // 회원 중복 확인 (아이디)
        if (!userService.checkDuplicateValue("account", id)) {
            // 한 번도 카카오 로그인을 한 적이 없다면 회원가입 진행
            userService.join(
                    SignUpRequestDto.builder()
                            .accountNumber(String.valueOf(dto.getId()))
                            .password("0000")
                            .name(dto.getProperties().getNickname())
                            .email(dto.getKakaoAccount().getEmail())
                            .loginMethod(User.LoginMethod.KAKAO)
                            .build(),
                    dto.getProperties().getProfileImage()
            );
        }

        // 우리 사이트 로그인 처리
        userService.maintainLoginState(session, id);

    }

    // 카카오 서버로부터 유저정보 받아오기
    private KakaoUserResponseDTO getKakaoUserInfo(String accessToken) {

        String requestUri = "https://kapi.kakao.com/v2/user/me";

        // 요청 헤더
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "Bearer " + accessToken);
        headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

        // 요청 보내기
        RestTemplate template = new RestTemplate();
        ResponseEntity<KakaoUserResponseDTO> responseEntity = template.exchange(
                requestUri,
                HttpMethod.POST,
                new HttpEntity<>(headers),
                KakaoUserResponseDTO.class
        );

        KakaoUserResponseDTO responseJSON = responseEntity.getBody();
        log.info("응답 데이터 결과 : {}", responseJSON);

        return responseJSON;

    }

    // 토큰 발급 요청
    private String getKakaoAccessToken(Map<String, String> requestParam) {
        
        // 요청 URI
        String requestUri = "https://kauth.kakao.com/oauth/token";

        // 요청 헤더 설정
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

        // 요청 바디에 파라미터 세팅
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("grant_type", "authorization_code");
        params.add("client_id", requestParam.get("appKey"));
        params.add("code", requestParam.get("code"));

        // 카카오 인증서버로 POST 요청 날리기
        RestTemplate template = new RestTemplate();

        // 헤더 정보와 파라미터를 하나로 묶기
        HttpEntity<Object> requestEntity = new HttpEntity<>(params, headers);

        ResponseEntity<Map> responseEntity
                = template.exchange(requestUri, HttpMethod.POST, requestEntity, Map.class);

        // 응답 데이터에서 JSON 추출
        Map<String, Object> responseJSON = (Map<String, Object>) responseEntity.getBody();
        log.info("응답 JSON 데이터: {}", responseJSON);

        // access token 추출 (카카오 로그인 중인 사용자의 정보를 요청할 때 필요한 토큰)
        String accessToken = (String) responseJSON.get("access_token");

        return accessToken;

    }

    // 네이버 로그인
    public void naverLogin(Map<String, String> params, HttpSession session) {

        String accessToken = getNaverAccessToken(params);
        log.info("access_token: {}", accessToken);

        // 전달받은 엑세스 토큰을 활용하여 사용자의 정보 가져오기
        NaverUserResponseDTO dto = getNaverUserInfo(accessToken);

        // 네이버에서 받은 회원정보로 우리 사이트 회원가입
        String id = dto.getNaverUserDetail().getId();
        log.info("네이버 소셜 아이디: {}", id);

        // 회원 중복 확인 (아이디)
        if (!userService.checkDuplicateValue("account", id)) {
            // 한 번도 네이버 로그인을 한 적이 없다면 회원가입 진행
            userService.join(
                    SignUpRequestDto.builder()
                            .accountNumber(dto.getNaverUserDetail().getId())
                            .password("0000")
                            .name(dto.getNaverUserDetail().getName())
                            .email(dto.getNaverUserDetail().getEmail())
                            .birthday(Integer.parseInt(dto.getNaverUserDetail().getBirthyear()))
                            .gender(dto.getNaverUserDetail().getGender())
                            .nickname(dto.getNaverUserDetail().getNickname())
                            .loginMethod(User.LoginMethod.NAVER)
                            .build(),
                    dto.getNaverUserDetail().getProfileImage()
            );
        }

//         우리 사이트 로그인 처리
        userService.maintainLoginState(session, id);

    }

    private NaverUserResponseDTO getNaverUserInfo(String accessToken) {

        String requestUri = "https://openapi.naver.com/v1/nid/me";

        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "Bearer " + accessToken);

        // 요청 보내기
        RestTemplate template = new RestTemplate();
        ResponseEntity<NaverUserResponseDTO> responseEntity = template.exchange(
                requestUri,
                HttpMethod.POST,
                new HttpEntity<>(headers),
                NaverUserResponseDTO.class
        );

        NaverUserResponseDTO responseJSON = responseEntity.getBody();
        log.info("응답 데이터 결과 : {}", responseJSON);

        return responseJSON;

    }

    private String getNaverAccessToken(Map<String, String> requestParams) {

        // 요청 URI
        String requestUri = "https://nid.naver.com/oauth2.0/token";

        // 요청 헤더 설정
        HttpHeaders headers = new HttpHeaders();

        // 요청 바디에 파라미터 세팅
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("client_id", requestParams.get("client_id"));
        params.add("client_secret", requestParams.get("client_secret"));
        params.add("grant_type", "authorization_code");
        params.add("state", requestParams.get("state"));
        params.add("code", requestParams.get("code"));

        // 네이버 인증서버로 POST 요청 날리기
        RestTemplate template = new RestTemplate();

        // 헤더 정보와 파라미터를 하나로 묶기
        HttpEntity<Object> requestEntity = new HttpEntity<>(params, headers);

        ResponseEntity<Map> responseEntity
                = template.exchange(requestUri, HttpMethod.POST, requestEntity, Map.class);

        // 응답 데이터에서 JSON 추출
        Map<String, Object> responseJSON = (Map<String, Object>) responseEntity.getBody();
        log.info("응답 JSON 데이터: {}", responseJSON);

        // access token 추출
        String accessToken = (String) responseJSON.get("access_token");

        return accessToken;

    }

    public void googleLogin(Map<String, String> params, HttpSession session) {

        String accessToken = getGoogleAccessToken(params);
        log.info("access_token: {}", accessToken);

        // 전달받은 엑세스 토큰을 활용하여 사용자의 정보 가져오기
        GoogleUserResponseDTO dto = getGoogleUserInfo(accessToken);

        // 구글에서 받은 회원정보로 우리 사이트 회원가입
        // 구글은 아이디를 제공하지 않아 locale + localDateTime.now()를 이용해 임의 생성
        String id = dto.getLocale() + LocalDateTime.now();
        log.info("구글 소셜 아이디: {}", id);

        // 회원 중복 확인 (아이디)
        if (!userService.checkDuplicateValue("account", id)) {
            // 한 번도 구글 로그인을 한 적이 없다면 회원가입 진행
            userService.join(
                    SignUpRequestDto.builder()
                            .accountNumber(id)
                            .password("0000")
                            .email(dto.getEmail())
                            .name(dto.getName())
                            .loginMethod(User.LoginMethod.GOOGLE)
                            .build(),
                    dto.getPicture()
            );
        }

//         우리 사이트 로그인 처리
        userService.maintainLoginState(session, id);

    }

    private GoogleUserResponseDTO getGoogleUserInfo(String accessToken) {

        String userInfoUri = "https://www.googleapis.com/oauth2/v3/userinfo";

        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "Bearer " + accessToken);

        RestTemplate template = new RestTemplate();

        ResponseEntity<GoogleUserResponseDTO> responseEntity = template.exchange(
                userInfoUri,
                HttpMethod.GET,
                new HttpEntity<>(headers),
                GoogleUserResponseDTO.class
        );

        GoogleUserResponseDTO responseJSON = responseEntity.getBody();
        log.info("응답 데이터 결과 : {}", responseJSON);

        return responseJSON;

    }

    private String getGoogleAccessToken(Map<String, String> requestParams) {

        // 요청 URI
        String requestUri = "https://oauth2.googleapis.com/token";

        // 요청 헤더 설정
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        // 요청 바디에 파라미터 세팅
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("code", requestParams.get("code"));
        params.add("client_id", requestParams.get("client_id"));
        params.add("client_secret", requestParams.get("client_secret"));
        params.add("redirect_uri", requestParams.get("redirect_uri"));
        params.add("grant_type", "authorization_code");

        // REST API를 호출하기 위한 RestTemplate 객체 생성
        RestTemplate template = new RestTemplate();

        // 헤더 정보와 파라미터를 하나로 묶기
        HttpEntity<Object> requestEntity = new HttpEntity<>(params, headers);

        ResponseEntity<Map> responseEntity
                = template.exchange(requestUri, HttpMethod.POST, requestEntity, Map.class);

        // 응답 데이터에서 JSON 추출
        Map<String, Object> responseJSON = (Map<String, Object>) responseEntity.getBody();
        log.info("응답 JSON 데이터: {}", responseJSON);

        // access token 추출
        String accessToken = (String) responseJSON.get("access_token");

        return accessToken;
    }
}

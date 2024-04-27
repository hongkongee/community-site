package project.blog.community.project.service;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import project.blog.community.project.dto.request.SignUpRequestDto;
import project.blog.community.project.dto.response.GoogleUserResponseDTO;
import project.blog.community.project.dto.response.KakaoUserResponseDTO;
import project.blog.community.project.entity.User;

import java.util.Map;


@Service
@Slf4j
@RequiredArgsConstructor

public class GoogleLoginService {
    private final UserService userService;


    public void googleLogin(Map<String, String> params, HttpSession session) {

        public void googleLogin (Map <String, String> params, HttpSession session){

            String accessToken = getGoogleAccessToken(params);
            log.info("access_token: {}", accessToken);

            // 전달받은 엑세스 토큰을 활용하여 사용자의 정보 가져오기
            GoogleUserResponseDTO dto = getGoogleUserInfo(accessToken);

            // 카카오에서 받은 회원정보로 우리 사이트 회원가입
            String email = dto.getGoogleAccount().getEmail();
            log.info("이메일: {}", email);

            // 회원 중복 확인 (이메일)
            if (!userService.checkDuplicateValue("email", email)) {
                // 한 번도 구글 로그인을 한 적이 없다면 회원가입 진행
                userService.join(
                        SignUpRequestDto.builder()
                                .accountNumber(String.valueOf(dto.getId()))
                                .password("0000")
                                .name(dto.getProperties().getNickname())
                                .email(email)
                                .loginMethod(User.LoginMethod.Google)
                                .build(),
                        dto.getProperties().getProfileImage()
                );
            }

            // 우리 사이트 로그인 처리
            userService.maintainLoginState(session, String.valueOf(dto.getId()));

        }

        private KakaoUserResponseDTO getGoogleUserInfo (String accessToken){

            String requestUri = "";

            // 요청 헤더
            HttpHeaders headers = new HttpHeaders();
            headers.add("Authorization", "Bearer " + accessToken);
            headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

            // 요청 보내기
            RestTemplate template = new RestTemplate();
            ResponseEntity<GoogleUserResponseDTO> responseEntity = template.exchange(
                    requestUri,
                    HttpMethod.POST,
                    new HttpEntity<>(headers),
                    GoogleUserResponseDTO.class
            );

            GoogleUserResponseDTO responseJSON = responseEntity.getBody();
            log.info("응답 데이터 결과 : {}", responseJSON);

            return responseJSON;

        }

        // 토큰 발급 요청
        private String getGoogleAccessToken (Map <String, String> requestParam){

            // 요청 URI
            String requestUri = " ////////////// ";

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

            // access token 추출 (구글 로그인 중인 사용자의 정보를 요청할 때 필요한 토큰)
            String accessToken = (String) responseJSON.get("access_token");

            return accessToken;

        }


    }
}

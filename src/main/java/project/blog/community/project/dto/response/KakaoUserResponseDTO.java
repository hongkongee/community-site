package project.blog.community.project.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

import java.time.LocalDateTime;

@Setter @Getter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
public class KakaoUserResponseDTO {

    private long id; // 카카오 아이디

    @JsonProperty("connected_at")
    private LocalDateTime connectedAt; // 응답받은 시간

    private Properties properties; // 직접 생성한 Properties 클래스

    @Setter @Getter @ToString
    public static class Properties {

        private String nickname;
        @JsonProperty("profile_image")
        private String profileImage;
        @JsonProperty("thumbnail_image")
        private String thumbnailImage;

    }



}

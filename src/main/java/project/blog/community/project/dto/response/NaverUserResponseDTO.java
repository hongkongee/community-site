package project.blog.community.project.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

@Getter @Setter @ToString
public class NaverUserResponseDTO {

    @JsonProperty("resultcode")
    private String resultCode;
    @JsonProperty("message")
    private String message;
    @JsonProperty("response")
    private NaverUserDetail naverUserDetail;

    @Getter
    @NoArgsConstructor
    @AllArgsConstructor
    @ToString
    public static class NaverUserDetail {
        private String id;
        private String name;
        private String email;
        private String nickname;
        @JsonProperty("profile_image")
        private String profileImage;
        private String gender;
        private String birthyear;

    }

}

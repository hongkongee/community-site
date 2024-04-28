package project.blog.community.project.dto.response;


import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;
import project.blog.community.project.entity.User;

@Getter
@Setter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
public class GoogleUserResponseDTO {
    @JsonProperty("given_name")
    private String nickname;

    private String email;

}

package project.blog.community.project.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class GoogleUserResponseDTO {

    private String email;
    private String name;
    private String picture;
    private String locale;

}

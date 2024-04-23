package project.blog.community.project.dto.response;

import jakarta.validation.constraints.NotBlank;
import lombok.*;
import project.blog.community.project.entity.Market;

@Setter @Getter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MarketModifyResponse {

    @NotBlank
    private String text;

    public Market toEntity(){
        return Market.builder()

                .textContent(text)
                .build();
    }

}

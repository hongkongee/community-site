package project.blog.community.project.dto.response;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import project.blog.community.project.entity.Market;

import java.time.LocalDateTime;

@Setter @Getter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MarketModifyResponse {

    @NotNull
    private int bno;

    @NotBlank
    private String text;

    public Market toEntity(){//MarketModifyResponse -> Market
        return Market.builder()
                .boardNo(bno)
                .textContent(text)
                .build();
    }

}

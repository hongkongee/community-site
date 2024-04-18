package project.blog.community.project.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import project.blog.community.project.entity.Market;
import project.blog.community.project.entity.Reply;

@Getter @Setter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder


public class MarketModifyRequestDTO {


    @NotNull
    private int bno;

    @NotBlank
    private String text;

    // 글번호

    public Market toEntity(){
        return Market.builder()
                .boardNo(bno)
                .textContent(text)
                .build();
    }

}

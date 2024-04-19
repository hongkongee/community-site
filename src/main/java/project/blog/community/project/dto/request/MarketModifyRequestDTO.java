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

//유효성을 검증할 때 null 값이나 공백 문자열이 포함되어 있는지 확인
    @NotNull
    private int boardNo;

    @NotBlank
    private String title;

    @NotBlank
    private String text;

    // 글번호

    public Market toEntity(){
        return Market.builder()
                .boardNo(boardNo)
                .textTitle(title)
                .textContent(text)
                .build();
    }

}

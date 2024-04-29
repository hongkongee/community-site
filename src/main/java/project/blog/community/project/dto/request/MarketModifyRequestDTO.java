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
    @NotNull(message = "게시판 번호는 필수입니다")
    private int boardNo;

    @NotBlank(message = "제목은 필수입니다")
    private String title;

    @NotBlank(message = "내용은 필수입니다")
    private String text;

    private String category;

    @NotNull
    private int price;

    private String address;


    // 글번호

    public Market toEntity(){
        return Market.builder()
                .boardNo(boardNo)
                .textTitle(title) // 수정된 부분
                .textContent(text)
                .category(category)
                .price(price)
                .address(address)
                .build();
    }

}

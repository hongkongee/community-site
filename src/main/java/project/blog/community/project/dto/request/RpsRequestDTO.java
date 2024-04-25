package project.blog.community.project.dto.request;

import lombok.*;

@Getter @Setter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RpsRequestDTO {
    // 입력 베팅 포인트 금액
    private int betPoint;
    // 가위 or 바위 or 보
    private String choice; 
}

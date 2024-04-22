package project.blog.community.project.dto.request;

import lombok.*;

@Getter
@Setter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LikeRequestDTO {
    private int bno;
    private int number;

    private Long postId;
    private Long userId;

}

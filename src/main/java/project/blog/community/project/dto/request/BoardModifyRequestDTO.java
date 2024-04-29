package project.blog.community.project.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BoardModifyRequestDTO {
    @NotNull(message = "게시판 번호는 필수입니다")
    private int bno;

    @NotBlank(message = "카테고리는 필수입니다")
    private String category;

    @NotBlank(message = "제목은 필수입니다")
    private String title;

    @NotBlank(message = "내용은 필수입니다")
    private String content;

    private MultipartFile file;
}

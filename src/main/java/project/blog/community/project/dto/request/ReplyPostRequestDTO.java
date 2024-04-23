package project.blog.community.project.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;
import project.blog.community.project.entity.Reply;

@Getter @Setter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReplyPostRequestDTO {

   @NotBlank
   @Size(min=1, max= 300)
   private String text; // 댓글 내용

   @NotBlank
   @Size(min= 2, max = 8)
   private String author; // 댓글 작성자

   @NotNull
   private int bno; // 원본 글번호

   public Reply toEntity() {
      return Reply.builder()
            .content(this.text)
            .replyWriter(this.author)
            .boardNo(this.bno)
            .build();
   }

}













































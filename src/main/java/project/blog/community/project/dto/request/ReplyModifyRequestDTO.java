package project.blog.community.project.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import project.blog.community.project.entity.Reply;

@Getter @Setter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReplyModifyRequestDTO {

   @NotNull
   private int rno;

   @NotBlank
   private String text;

   public Reply toEntity() {
      return Reply.builder()
            .replyNo(rno)
            .content(text)
            .build();
   }

}













































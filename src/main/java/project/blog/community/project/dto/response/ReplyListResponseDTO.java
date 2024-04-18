package project.blog.community.project.dto.response;

import lombok.*;
import project.blog.community.project.common.PageMaker;

import java.util.List;

@Setter @Getter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReplyListResponseDTO {

   private int count; // 댓글 수
   private PageMaker pageInfo; // 페이징 정보

   private List<ReplyDetailResponseDTO> replies; // 실제 댓글 리스트


}













































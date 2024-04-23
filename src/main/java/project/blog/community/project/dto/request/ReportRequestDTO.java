package project.blog.community.project.dto.request;

import lombok.*;
import project.blog.community.project.mapper.UserMapper;

import java.util.List;

// 게시물 작성자를 신고하고 폼을 제출할 때 데이터
@Getter @Setter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReportRequestDTO {
    
    private int bno; // 신고된 게시글 번호
    private String writer; // 신고된 게시글의 작성자
    private String message; // 신고 기타 사유
    private List<String> interests; // 신고 사유 체크박스 배열
}

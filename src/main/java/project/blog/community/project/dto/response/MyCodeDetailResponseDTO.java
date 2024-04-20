package project.blog.community.project.dto.response;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import project.blog.community.project.entity.MyCode;
@Getter@ToString
@EqualsAndHashCode
public class MyCodeDetailResponseDTO {
    private final int codeNo;
    private final String title;
    private final String content;
    private final String regDate;
    private final String writer;
    private final String programming;

    public MyCodeDetailResponseDTO(MyCode myCode) {
        this.codeNo = myCode.getCodeNo();
        this.title = myCode.getTitle();
        this.content = myCode.getContent();
        this.regDate = MyCodeListResponseDTO.makePrettierDateString(myCode.getRegDate());
        this.writer = myCode.getWriter();
        this.programming = myCode.getProgramming();
    }
}

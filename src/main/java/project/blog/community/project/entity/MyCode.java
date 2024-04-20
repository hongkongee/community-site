package project.blog.community.project.entity;

import lombok.*;
import project.blog.community.project.dto.request.MyCodeWriteRequestDTO;

import java.time.LocalDateTime;

@Setter
@Getter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
public class MyCode {

    private int codeNo;
    private String title;
    private String content;
    private LocalDateTime regDate;
    private String writer;
    private String programming;

    public MyCode(MyCodeWriteRequestDTO dto) {
        this.title = dto.getTitle();
        this.content = dto.getContent();
        this.programming = dto.getProgramming();



    }
}

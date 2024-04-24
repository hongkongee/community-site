package project.blog.community.project.dto.request;

import lombok.*;

@Setter
@Getter@ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
public class MyCodeWriteRequestDTO {
    private int codeNo;
    private String title;
    private String content;
    private String writer;
    private String programming;



}

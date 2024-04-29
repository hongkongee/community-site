package project.blog.community.project.entity;

import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Setter
@Getter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Diary {

    private int diaryNo;
    private String toDo;
    private String whatDo;
    private String writer;

    private LocalDate regDate;

}

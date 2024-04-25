package project.blog.community.project.entity;

import lombok.*;

@Setter
@Getter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Rate {
    private int boardNo;
    private String textWriter;

    private String message;

    private String chooseReason;
}

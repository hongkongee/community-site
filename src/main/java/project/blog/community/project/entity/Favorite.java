package project.blog.community.project.entity;

import lombok.*;

@Setter
@Getter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Favorite {
    private String accountNumber;
    private int boardNo;
}

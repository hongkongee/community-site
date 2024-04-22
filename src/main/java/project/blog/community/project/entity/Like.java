package project.blog.community.project.entity;

/*CREATE TABLE tbl_like (
        account_number VARCHAR(50),
bno INT,
UNIQUE (account_number, bno)
);*/

import lombok.*;

// 유저와 게시물의 좋아요 관계 테이블

@Setter
@Getter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Like {
    private String accountNumber;
    private int bno;
}













































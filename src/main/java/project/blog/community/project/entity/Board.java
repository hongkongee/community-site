package project.blog.community.project.entity;
/*
CREATE TABLE `tbl_board` (
  `bno` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `writer` varchar(45) NOT NULL,
  `content` varchar(2000) NOT NULL,
  `reg_date` datetime DEFAULT NULL,
  `view_count` int DEFAULT '0',
  `like_count` int DEFAULT '0',
  `category` varchar(100) DEFAULT 'NORMAL',
  PRIMARY KEY (`bno`)
)
*/


import lombok.*;

import java.time.LocalDateTime;

@Setter
@Getter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Board {

    private int bno;

    private String title;

    // User의 account로 입력 (중복 안되게)
    private String writer;

    private String content;

    private LocalDateTime regDate;

    private int viewCount;

    private int likeCount;

    private Category category;

    private String postImg;


}













































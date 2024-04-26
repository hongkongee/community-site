package project.blog.community.project.entity;

/*
CREATE TABLE tbl_reply (
	reply_no INT NOT NULL AUTO_INCREMENT,
  board_no INT,
  reply_writer VARCHAR(50) NOT NULL,
  content VARCHAR(1000) NOT NULL,
  reg_date DATETIME DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT pk_reply PRIMARY KEY (reply_no),
  CONSTRAINT fk_reply FOREIGN KEY(board_no) REFERENCES tbl_board(bno)
  ON DELETE CASCADE
);

*/



import lombok.*;

import java.time.LocalDateTime;

@Setter @Getter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Reply {

   private int replyNo;
   private int boardNo;
   @Setter
   private String replyWriter;
   @Setter
   private String content;
   private LocalDateTime regDate;
   private LocalDateTime updateDate;
   @Setter
   private String account;
   private String profileImage;
   private String loginMethod;


}













































package project.blog.community.project.mapper;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import project.blog.community.project.common.Page;
import project.blog.community.project.entity.Board;
import project.blog.community.project.entity.Reply;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class ReplyMapperTest {

   @Autowired
   BoardMapper boardMapper;
   @Autowired
   ReplyMapper replyMapper;


   @Test
   @DisplayName("게시물을 100개 등록하고, 랜덤으로 100개의 댓글을 게시글에 등록한다.")
   void bulkInsertTest() {
      // given

      for (int i = 1; i <= 100; i++) {
         Board b = Board.builder()
               .title("Test 글" + i)
               .content("Test글 내용" + i)
               .writer("Test글 작성가" + i)
               .build();
         boardMapper.save(b);
      }

      for (int i = 1; i <= 500; i++) {
         Reply reply = Reply.builder()
               .content("Test 댓글" + i)
               .replyWriter("Test 댓글 작성자" + i)
               .boardNo((int) (Math.random()*100 +1))
               .build();

         replyMapper.save(reply);
      }

   }

   @Test
   @DisplayName("100번 게시물의 댓글 목록을 조회했을 때 결과 리스트의 사이즈는 n이어야 한다.")
   void findAllTest() {
      // given
      int boardNo = 100;

      Page page = new Page();
//      page.setPageNo(3);

      // when
      List<Reply> replyList = replyMapper.findAll(boardNo, page);

      // then
      assertEquals(2, replyList.size());
   }

   @Test
   @DisplayName("100번 게시물의 댓글 중 n번 댓글을 삭제하면 n번 댓글 조회되지 않을 것이다. 100번 전체조회하면 리스트 하나 줄어있어야 한다.")
   void deleteTest() {
      int boardNo = 77;
      int replyNo = 124;

      replyMapper.delete(replyNo);
      Reply reply = replyMapper.findOne(replyNo);

      assertNull(reply);
      assertNotEquals(6, replyMapper.count(boardNo));
   }

   @Test
   @DisplayName("63번 댓글의 댓글 내용을 수정하면 다시 조회했을 때 수정된 내용이 조회되어야 한다.")
   void modifyTest() {
      int replyNo = 102;
      String newReplyText = "수정 updatedate 확인용";
      Reply reply = Reply.builder()
            .content(newReplyText)
            .replyNo(replyNo)
            .build();

      replyMapper.modify(reply);
      Reply foundReply = replyMapper.findOne(replyNo);

      assertEquals(newReplyText, foundReply.getContent());

   }


}


































package project.blog.community.project.mapper;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import project.blog.community.project.entity.Board;
import project.blog.community.project.entity.Category;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static project.blog.community.project.entity.Category.*;

@SpringBootTest
class BoardMapperTest {

   @Autowired
   BoardMapper boardMapper;

   @Test
   @DisplayName("게시물 등록하기")
   void postTest() {
      // given

      // when
/*        Board board = Board.builder()
                .title("두번째 게시물 작성")
                .content("두번째 게시물 작성자는 account_number로 했습니다.")
                .writer("tjtkdvl")
                .category(NORMAL)
                .build();

        boardMapper.save(board);*/
      // then
   }

   @Test
   @DisplayName("게시물 확인")
   void findOneTest() {
      // given
//        int boardNo = 1;
//        // when
//        Board board = boardMapper.findOne(boardNo);
//
//        // then
//        System.out.println(board.toString());
//        assertNotNull(board);

   }

   @Test
   @DisplayName("모든 게시글 조회")
   void findAllTest() {
      // given
//        List<Board> boardList = boardMapper.findAll();
//
//        // when
//        assertEquals(boardList.size(), 2);

      // then
   }

   @Test
   @DisplayName("게시글 더미데이터 생성")
   void dummyBoardTest() {
      // given

      // 100개의 게시물 생성
/*        for (int i = 0; i < 100; i++) {
            Board board = Board.builder()
                    .title(i + 4 + "번째 게시물 제목")
                    .content(String.format("%d번째 게시물의 내용을 작성합니다.\n 게시물 test용", i + 4))
                    .writer("tjtkdvl")
                    .category(i % 2 == 0 ? NORMAL : GAME)
                    .build();

            boardMapper.save(board);*/
//        }


      // when

      // then
   }
}

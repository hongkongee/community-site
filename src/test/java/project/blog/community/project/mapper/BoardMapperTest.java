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


}
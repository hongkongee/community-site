package project.blog.community.project.mapper;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import project.blog.community.project.entity.Diary;

import java.time.LocalDate;
import java.time.LocalDateTime;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class DiaryMapperTest {

    @Autowired
    DiaryMapper diaryMapper;

    @Test
    @DisplayName("저장하기")
    void todoSave() {
        // when
        /*        Board board = Board.builder()
                .title("두번째 게시물 작성")
                .content("두번째 게시물 작성자는 account_number로 했습니다.")
                .writer("tjtkdvl")
                .category(NORMAL)
                .build();

        boardMapper.save(board);*/

        Diary diary = Diary.builder()
                .toDo("할일 테스트2")
                .regDate(LocalDate.of(2024, 04, 11).atStartOfDay())
                .build();
        diaryMapper.todoSave(diary);

    }

    @Test
    @DisplayName("whatdo 추가")
    void whatdoSave() {
        // when
        Diary diary = Diary.builder()
                .whatDo("whatdo 테스트 3")
                .regDate(LocalDate.of(2024, 04, 20).atStartOfDay())
                .build();
        diaryMapper.whatdoSave(diary);

    }


}







































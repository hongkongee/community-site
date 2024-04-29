package project.blog.community.project.mapper;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import project.blog.community.project.entity.Diary;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class DiaryMapperTest {

    @Autowired
    DiaryMapper diaryMapper;

    @Test
    @DisplayName("저장하기")
    void todoSave() {
        /*
        // when
        Diary diary = Diary.builder()
                .toDo("할일 테스트2")
                .regDate(LocalDate.of(2024, 04, 11).atStartOfDay())
                .build();
        diaryMapper.todoSave(diary);

        */
    }

    @Test
    @DisplayName("whatdo 추가")
    void whatdoSave() {
        /*
        // when
        Diary diary = Diary.builder()
                .whatDo("whatdo 테스트 3")
                .regDate(LocalDate.of(2024, 04, 20).atStartOfDay())
                .build();
        diaryMapper.whatdoSave(diary);

         */

    }

    @Test
    @DisplayName("전체 일정을 조회했을 때 결과 리스트의 사이즈는 n이어야 한다.")
    void findAllTest() {
        // given
        List<Diary> diaryList = diaryMapper.findAll();

        // when
        assertEquals(diaryList.size(), 6);

    }

    @Test
    @DisplayName("게시물 확인")
    void findOneTest() {
        // given
        int diaryNo = 3;

        // when
        Diary diary = diaryMapper.findOne(diaryNo);

        // then
        System.out.println(diary.toString());
        assertNotNull(diary);
    }

    @Test
    @DisplayName("50개의 더미 일정을 만들어서 테스트")
    void dummyTodoTest() {
//        // given
//        for(int i = 0; i < 50; i++) {
//            Diary diary = Diary.builder()
//                    .toDo(i + 6 + "번째 날짜의 할일")
//                    .regDate(LocalDate.of(2024, 4, 25).atStartOfDay())
//                    .build();
//
//            diaryMapper.todoSave(diary);
//        }

    }

    @Test
    @DisplayName("50개의 더미 일기를 만들어서 테스트")
    void dummyWhatdoTest() {
//        // given
//        for (int i=0; i<50; i++) {
//            Diary diary = Diary.builder()
//                    .whatDo(i + 10 + "번째 날짜의 일기")
//                    .regDate(LocalDate.of(2024, 4, 25).atStartOfDay())
//                    .build();
//            diaryMapper.whatdoSave(diary);
//        }

    }

    @Test
    @DisplayName("diary 삭제")
    void deleteTodo() {
        // given
        int diaryNo = 51;

        // when
        diaryMapper.todoDelete(diaryNo);
        Diary diary = diaryMapper.findOne(diaryNo);

        // then
        assertNull(diary);
    }

    @Test
    @DisplayName("100번째 todo 수정")
    void todoModifyTest() {
        // given
        int diaryNo = 100;
        String newTodo = "수정 todo 확인용";
        Diary diary = Diary.builder()
                .toDo(newTodo)
                .diaryNo(diaryNo)
                .build();
        diaryMapper.modifyTodo(diary);
        Diary foundDiary = diaryMapper.findOne(diaryNo);

        assertEquals(newTodo, foundDiary.getToDo());

    }

    @Test
    @DisplayName("100번째 whatdo 수정")
    void whatdoModifyTest() {
        // given
        int diaryNo = 100;
        String newWhatdo = "수정 whatdo 확인용!";
        Diary diary = Diary.builder()
                .whatDo(newWhatdo)
                .diaryNo(diaryNo)
                .build();
        diaryMapper.modifyWhatdo(diary);
        Diary foundDiary = diaryMapper.findOne(diaryNo);

        assertEquals(newWhatdo, foundDiary.getWhatDo());
        // when

        // then
    }


}







































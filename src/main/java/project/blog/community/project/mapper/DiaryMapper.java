package project.blog.community.project.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import project.blog.community.project.entity.Diary;

import java.util.List;

@Mapper
public interface DiaryMapper {

    // todo저장
    void todoSave(Diary diary);

    // whatdo저장
    void whatdoSave(Diary diary);

    // 전체 글 조회
    List<Diary> findAll();

    // 날짜 별 글을 조회 todoList
    List<Diary> findTodoList(@Param("regDate") String regDate, @Param("myAccount") String myAccount);

    // 날짜 별 글을 조회 whatdoList
    List<Diary> findWhatdoList(String regDate);

    // 글 개별 조회
    Diary findOne(int diaryNo);

    // todo삭제
    void todoDelete(int diaryNo);

    // whatdo삭제
    void whatdoDelete(int diaryNo);

    // todo수정
    void modifyTodo(Diary diary);

    // whatdo수정
    void modifyWhatdo(Diary diary);
}

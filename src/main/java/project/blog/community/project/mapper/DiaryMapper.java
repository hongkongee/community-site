package project.blog.community.project.mapper;

import org.apache.ibatis.annotations.Mapper;
import project.blog.community.project.entity.Diary;

import java.util.List;

@Mapper
public interface DiaryMapper {

    void todoSave(Diary diary); // todoSave저장

    void whatdoSave(Diary diary); // whatSave저장

    List<Diary> findAll(); // 전체 글

    Diary findOne(int diaryNo); // 글 하나

    void todoDelete(int diaryNo); // 삭제

    void whatdoDelete(int diaryNo); // 삭제

    void modifyTodo(int diaryNo); // todo수정

    void modifyWhatdo(int diaryNo); // whatdo 수정
}

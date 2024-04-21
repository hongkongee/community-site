package project.blog.community.project.mapper;

import org.apache.ibatis.annotations.Mapper;
import project.blog.community.project.common.CodeSearch;
import project.blog.community.project.common.MyCodePage;
import project.blog.community.project.entity.MyCode;

import java.util.List;
@Mapper
public interface MyCodeMapper {
    List<MyCode> findAll(CodeSearch page);

List<MyCode> endAll(MyCodePage page);


    MyCode findOne(int codeNo);

    //사진등록
    void save(MyCode myCode);

    //사진삭제
    void delete(int codeNo);


    int getCount();

    int getEndCount();
}

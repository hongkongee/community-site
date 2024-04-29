package project.blog.community.project.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import project.blog.community.project.common.CodeSearch;
import project.blog.community.project.common.MyCodePage;
import project.blog.community.project.entity.MyCode;

import java.util.List;
@Mapper
public interface MyCodeMapper {
    List<MyCode> findAll(@Param("page") CodeSearch page, @Param("account") String account);

    List<MyCode> endAll(@Param("page") MyCodePage page, @Param("account") String myAccount);


    MyCode findOne(int codeNo);


    void save(MyCode myCode);


    void delete(int codeNo);

    void update(MyCode myCode);

    int getCount(@Param("page") CodeSearch page, @Param("account") String account);


    int getEndCount();
}

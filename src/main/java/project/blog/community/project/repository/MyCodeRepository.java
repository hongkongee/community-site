package project.blog.community.project.repository;

import org.apache.ibatis.annotations.Mapper;
import project.blog.community.project.common.MyCodePage;
import project.blog.community.project.entity.MyCode;

import java.util.List;

@Mapper
public interface MyCodeRepository {

    //목록조회
List<MyCode> findAll(MyCodePage page);



    //상세보기
    MyCode findOne(int galleryNo);

    //사진등록
     void save(MyCode myCode);

    //사진삭제
    void delete(int photoNumber);

}

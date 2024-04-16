package project.blog.community.project.mapper;

import org.apache.ibatis.annotations.Mapper;
import project.blog.community.project.entity.Gallery;

import java.util.List;
@Mapper
public interface GalleryMapper {
    List<Gallery> findAll();



    //상세보기
    Gallery findOne(int galleryNo);

    //사진등록
    void save(Gallery gallery);

    //사진삭제
    void delete(int photoNumber);


}

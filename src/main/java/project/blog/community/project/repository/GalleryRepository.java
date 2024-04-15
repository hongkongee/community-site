package project.blog.community.project.repository;

import project.blog.community.project.entity.Gallery;

import java.util.List;

public interface GalleryRepository {

    //목록조회
List<Gallery> findAll();



    //상세보기
     Gallery findOne(int galleryNo);

    //사진등록
     void save(Gallery gallery);

    //사진삭제
    void delete(int photoNumber);

}

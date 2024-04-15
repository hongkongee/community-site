package project.blog.community.project.repository;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import project.blog.community.project.entity.Gallery;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class GalleryRepositoryImplTest {

    @Autowired
private GalleryRepository repository;

    @Test
    @DisplayName("사진 등록300")
    void bulkInsertTest() {
        // given
        for (int i = 1; i <= 10; i++) {
            Gallery gallery = new Gallery();
            gallery.setPhotoLink();
        }
        // when

        // then
    }

    @Test
    @DisplayName("300게시글 조회")
    void findAllTest() {
        // given

        // when

        // then
    }

}








package project.blog.community.project.repository;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import project.blog.community.project.entity.Gallery;

import java.time.LocalDateTime;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class GalleryRepositoryImplTest {

    @Autowired
private GalleryRepository repository;

    @Test
    @DisplayName("사진 등록10")
    void bulkInsertTest() {
        // given
        for (int i = 1; i <= 10; i++) {
            Gallery gallery = new Gallery();
            gallery.setTitle("제목" + i);
            gallery.setPhotoLink("이미지" + i);
            gallery.setUser("user" + i);


            // when
            repository.save(gallery);
        }
        // then
        // 필요한 경우 예상 결과를 확인하는 코드를 작성합니다.
    }

    @Test
    @DisplayName("300게시글 조회")
    void findAllTest() {
        // given

        // when

        // then
    }

}








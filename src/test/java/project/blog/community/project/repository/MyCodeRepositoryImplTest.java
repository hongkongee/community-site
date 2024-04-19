package project.blog.community.project.repository;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import project.blog.community.project.entity.MyCode;
import project.blog.community.project.mapper.MyCodeMapper;

import static org.junit.jupiter.api.Assertions.*;


@SpringBootTest
class MyCodeRepositoryImplTest {

    @Autowired
    private MyCodeMapper mapper;

    @Test
    @DisplayName("사진 등록10")
    void bulkInsertTest() {
        // given
        for (int i = 1; i <= 10; i++) {
            MyCode myCode = new MyCode();
            myCode.setTitle("html" + i);
            myCode.setContent("내용" + i);
            myCode.setWriter("user" + i);


            // when
            mapper.save(myCode);
        }
        // then
        // 필요한 경우 예상 결과를 확인하는 코드를 작성합니다.
    }

    @Test
    @DisplayName("")
    void deleteTest() {
        // given
        int bno = 24;
        // when
        mapper.delete(bno);
        MyCode mycode = mapper.findOne(bno);
        // then
        assertNull(mycode);
    }

    @Test
    @DisplayName("")
    void findOne() {
        // given
        int bno = 19;
        String name = "html9";
        // when
        MyCode myCode = mapper.findOne(bno);
        String title = myCode.getTitle();
        // then
        assertEquals(name, title);
    }


}








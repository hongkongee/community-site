//package project.blog.community.project.mapper;
//
//import org.junit.jupiter.api.DisplayName;
//import org.junit.jupiter.api.Test;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.test.context.SpringBootTest;
//import project.blog.community.project.entity.Market;
//import project.blog.community.project.entity.Reply;
//
//import static org.junit.jupiter.api.Assertions.*;
//
//@SpringBootTest
//class MarketMapperTest {
//    @Autowired //객체 주입
//    MarketMapper marketMapper;
//
//    @Test
//    @DisplayName("등록테스트")
//    void saveTest() {
//        // given
//
//        //내가 작성
//        Market market = Market.builder()
//                .textTitle("hhh")
//                .textContent("abc1234")
//                .textWriter("123123")
//                .boardNo(1231232)
//                .build();
//
//        marketMapper.save(market);
//    }
//
//
//    @Test
//    @DisplayName("조회테스트")
//    void findAllTest(){
//        marketMapper.findAll();
//    }
//
//    void modifyTest() {
//        int boardNo = 123123;
//        String textContent = "123"; //아래서 수정해도 되긴함
//        Market market = Market.builder()
//                .textContent("수정댓글")
//                .boardNo(123)
//                .build();
//
////        // when
////        marketMapper.modify(textContent);
////
//}
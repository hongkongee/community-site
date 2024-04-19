package project.blog.community.project.controller;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import project.blog.community.project.entity.Market;
import project.blog.community.project.mapper.MarketMapper;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class MarketControllerTest {

    @Autowired//의존성 주입
    MarketMapper marketMapper;

    @Test
    @DisplayName("데이터 등록")
    void save() {
        for (int i = 1; i < 20; i++) {
            Market market = new Market();
            market.setTextWriter("작성자" + i);
            market.setTextTitle("제목" + i);
            market.setTextContent("내용" + i);
            marketMapper.save(market);
        }

    }

}
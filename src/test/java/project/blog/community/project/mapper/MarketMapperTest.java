package project.blog.community.project.mapper;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import project.blog.community.project.entity.Favorite;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class MarketMapperTest {

    @Autowired
    MarketMapper marketMapper;

    @Test
    @DisplayName("즐겨찾기 추가하기")
    void addFavorite() {
        // given
        Favorite favorite = Favorite.builder()
                .accountNumber("tjtkdvl")
                .boardNo(1)
                .build();

        // when
        marketMapper.addFav(favorite);

        // then
        // 추가적인 검증 코드를 작성해도 좋습니다.
    }
}
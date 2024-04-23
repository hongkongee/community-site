package project.blog.community.project.mapper;

import org.apache.ibatis.annotations.Mapper;
import project.blog.community.project.entity.Board;
import project.blog.community.project.entity.Favorite;
import project.blog.community.project.entity.Market;

import java.util.List;

@Mapper
public interface MarketMapper {
    void save(Market market);
    void modify(Market market);

    List<Market> findAll();
    void updateViewCount(int boardNo);

    Market findOne(int boardNo);

    void delete(int boardNo);

//    List<Board> getAddFavList(int boardNo, boolean addFav);

    // 즐겨찾기 추가
    void addFav(Favorite favorite);

    // 유저가 즐겨찾기한 boardNo를 찾기
    List<Integer> checkFav(String accountNumber);

    // 기존 즐겨찾기 삭제
    void removeFav(Favorite favorite);

//    List<Board> addFavList(int boardNo, boolean addFav);
}

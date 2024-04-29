package project.blog.community.project.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import project.blog.community.project.dto.request.MarketRateRequestDTO;
import project.blog.community.project.entity.Favorite;
import project.blog.community.project.entity.Market;
import project.blog.community.project.entity.Rate;

import java.util.List;

@Mapper
public interface MarketMapper {
    void save(Market market);
    void modify(Market market, String currentLoginMemberAccount);

    List<Market> findAll();

    List<Market> findFour();


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

    void updateRateBoard(@Param("writer") String textWriter, @Param("avg") float rateAvg);

    void updateRateWriter(String textWriter);

//    List<Board> addFavList(int boardNo, boolean addFav);

    int checkRate(String accountNumber);

    Rate checkRateRelation(MarketRateRequestDTO dto);

    void addRate(MarketRateRequestDTO dto);

    List<Rate> checkRateByUser(String textWriter);

    List<Integer> selectByAccountNumber(String currentLoginMemberAccount);

    float rateAverage(String textWriter);

}

package project.blog.community.project.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import project.blog.community.project.entity.Board;
import project.blog.community.project.entity.Category;

import java.util.List;

@Mapper
public interface BoardMapper {

    // 게시물 등록
    void save(Board board);

    // 목록 조회 (type: 인기순, 최신순, amount: 한 페이지 글 개수)
    List<Board> findAll(@Param("type") String type, @Param("amount") int amount);

    // 특정 카테고리의 게시글 조회
    List<Board> findCategory(@Param("category") String category, @Param("amount") int amount);

    // 상세 조회
    Board findOne(int bno);


    void updateViewCount(int bno);

    void updateReportCount(int bno);

    void updateLikeCount(@Param("bno") int bno, @Param("number") int number);

}

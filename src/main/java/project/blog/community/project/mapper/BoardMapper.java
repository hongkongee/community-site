package project.blog.community.project.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import project.blog.community.project.common.Search;
import project.blog.community.project.entity.Board;

import java.util.List;

@Mapper
public interface BoardMapper {

    // 게시물 등록
    void save(Board board);

    // 목록 조회
    List<Board> findAll();

    // 특정 카테고리의 게시글 조회
    List<Board> findCategory(String category);

    // 상세 조회
    Board findOne(int bno);


    void updateViewCount(int bno);

    void updateReportCount(int bno);

    void updateLikeCount(@Param("bno") int bno, @Param("number") int number);

    // 총 게시물의 개수 리턴
    int getCount(Search page);

    // 페이지 findAll
    List<Board> findAll(Search page);


    // 내 게시물만 보이는 findMine
    List<Board> findMine(@Param("page") Search page, @Param("account") String currentLoginMemberAccount);
}

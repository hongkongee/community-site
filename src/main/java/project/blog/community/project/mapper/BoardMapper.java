package project.blog.community.project.mapper;

import org.apache.ibatis.annotations.Mapper;
import project.blog.community.project.entity.Board;

import java.util.List;

@Mapper
public interface BoardMapper {

    // 게시물 등록
    void save(Board board);

    // 목록 조회
    List<Board> findAll();

    // 상세 조회
    Board findOne(int bno);


    void updateViewCount(int bno);

    void updateReportCount(int bno);
}

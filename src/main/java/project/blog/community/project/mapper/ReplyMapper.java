package project.blog.community.project.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import project.blog.community.project.common.Page;
import project.blog.community.project.entity.Reply;

import java.util.List;

@Mapper
public interface ReplyMapper {

   // 댓글 등록
   void save(Reply reply);

   // 댓글 수정 (내용)
   void modify(Reply reply);

   // 댓글 삭제
   void delete(int replyNo);

   // 댓글 개별 조회
   Reply findOne(int replyNo);

   // 댓글 전체 목록 조회
   List<Reply> findAll(@Param("bn") int boardNo, @Param("p") Page page);

   // 댓글 총 개수 조회
   int count(int boardNo);


}



















































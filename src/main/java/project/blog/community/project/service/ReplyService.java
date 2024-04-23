package project.blog.community.project.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import project.blog.community.project.common.Page;
import project.blog.community.project.common.PageMaker;
import project.blog.community.project.dto.request.ReplyModifyRequestDTO;
import project.blog.community.project.dto.request.ReplyPostRequestDTO;
import project.blog.community.project.dto.response.ReplyDetailResponseDTO;
import project.blog.community.project.dto.response.ReplyListResponseDTO;
import project.blog.community.project.entity.Reply;
import project.blog.community.project.mapper.ReplyMapper;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ReplyService {

   private final ReplyMapper mapper;

   public void register(ReplyPostRequestDTO dto) {

      Reply reply = dto.toEntity();

      mapper.save(reply);
   }

   public ReplyListResponseDTO getList(int boardNo, Page page) {
      List<ReplyDetailResponseDTO> dtoList = new ArrayList<>();

      List<Reply> replyList = mapper.findAll(boardNo, page);
      for (Reply reply : replyList) {
         dtoList.add(new ReplyDetailResponseDTO(reply));
      }

      int count = mapper.count(boardNo);

      return ReplyListResponseDTO.builder()
            .replies(dtoList)
            .count(count)
            .pageInfo(new PageMaker(page, count))
            .build();

   }

   public void modify(ReplyModifyRequestDTO dto) {

      Reply reply = dto.toEntity();
      mapper.modify(reply);

   }

   public void delete(Integer replyNo) throws Exception{
      mapper.delete(replyNo);
   }
}













































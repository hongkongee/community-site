package project.blog.community.project.service;

import jakarta.servlet.http.HttpSession;
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
import project.blog.community.util.LoginUtils;

import java.util.ArrayList;
import java.util.List;

import static project.blog.community.util.LoginUtils.*;

@Service
@RequiredArgsConstructor
public class ReplyService {

   private final ReplyMapper mapper;

   public void register(ReplyPostRequestDTO dto, HttpSession session) {

      Reply reply = dto.toEntity();
      reply.setAccount(getCurrentLoginMemberAccount(session));

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













































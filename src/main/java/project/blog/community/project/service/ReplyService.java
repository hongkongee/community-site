package project.blog.community.project.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import project.blog.community.project.dto.request.ReplyPostRequestDTO;
import project.blog.community.project.dto.response.ReplyDetailResponseDTO;
import project.blog.community.project.entity.Reply;
import project.blog.community.project.mapper.ReplyMapper;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ReplyService {

   private final ReplyMapper mapper;

   public void register(ReplyPostRequestDTO dto) {

      Reply reply = dto.toEntity();

      mapper.save(reply);
   }

   public List<ReplyDetailResponseDTO> getList(int boardNo) {
      List<Reply> replyList = mapper.findAll(boardNo);
      return null;
   }

}













































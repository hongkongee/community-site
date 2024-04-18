package project.blog.community.project.api;


import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import project.blog.community.project.dto.request.ReplyPostRequestDTO;
import project.blog.community.project.dto.response.ReplyDetailResponseDTO;
import project.blog.community.project.service.ReplyService;

import java.util.List;

@Controller
@RequestMapping("api/v1/replies")
@RequiredArgsConstructor
@Slf4j
public class ReplyApiController {

   private final ReplyService replyService;

   @GetMapping("/{boardNo}")
   public ResponseEntity<?> list(@PathVariable int boardNo) {
      log.info("api/v1/replies{}: GET!!!", boardNo);

      List<ReplyDetailResponseDTO> dtoList = replyService.getList(boardNo);

      return ResponseEntity.ok().body(dtoList);
   }

   @PostMapping
   @ResponseBody
   public ResponseEntity<?> create(@Validated @RequestBody ReplyPostRequestDTO dto, BindingResult result) {

      if (result.hasErrors()) {
         return ResponseEntity
               .badRequest()
               .body(result.toString());
      }

      log.info("/api/v1/replies: POST!!");
      log.info("dto: {}", dto);

      replyService.register(dto);

      return ResponseEntity.ok().body("success");


   }


}













































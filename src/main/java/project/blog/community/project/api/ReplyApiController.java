package project.blog.community.project.api;


import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.eclipse.tags.shaded.org.apache.regexp.RE;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import project.blog.community.project.common.Page;
import project.blog.community.project.dto.request.ReplyModifyRequestDTO;
import project.blog.community.project.dto.request.ReplyPostRequestDTO;
import project.blog.community.project.dto.response.ReplyDetailResponseDTO;
import project.blog.community.project.dto.response.ReplyListResponseDTO;
import project.blog.community.project.service.ReplyService;

import java.util.List;

@RestController
@RequestMapping("api/v1/replies")
@RequiredArgsConstructor
@Slf4j
public class ReplyApiController {

   private final ReplyService replyService;

   @GetMapping("/{boardNo}/page/{pageNo}")
   public ResponseEntity<?> list(@PathVariable int boardNo, @PathVariable int pageNo) {
      log.info("api/v1/replies{}: GET!!!", boardNo);
      log.info("pageNo: {}", pageNo);

      Page page = new Page();
      page.setPageNo(pageNo);
      page.setAmount(5);

      ReplyListResponseDTO replies = replyService.getList(boardNo, page);

      return ResponseEntity.ok().body(replies);
   }

   @PostMapping
   @ResponseBody
   public ResponseEntity<?> create(@Validated @RequestBody ReplyPostRequestDTO dto, BindingResult result,
                                   HttpSession session) {

      if (result.hasErrors()) {
         return ResponseEntity
               .badRequest()
               .body(result.toString());
      }

      log.info("/api/v1/replies: POST!!");
      log.info("dto: {}", dto);

      replyService.register(dto, session);

      return ResponseEntity.ok().body("success");

   }

   @PutMapping
   public ResponseEntity<?> update(@Validated @RequestBody ReplyModifyRequestDTO dto, BindingResult result) {

      if (result.hasErrors()) {
         return ResponseEntity
               .badRequest()
               .body(result.toString());
      }

      log.info("/api/v1/replies: PUT!");
      log.info("dto: {}", dto);

      replyService.modify(dto);
      return ResponseEntity.ok().body("modSuccess");

   }

   @DeleteMapping("/{replyNo}")
   public ResponseEntity<?> remove(@PathVariable Integer replyNo) {
      if (replyNo == null) {
         return ResponseEntity
               .badRequest()
               .body("댓글 번호가 전달되지 않음!");
      }
      log.info("/api/v1/replies/{}: DELETE", replyNo);

      try {
         replyService.delete(replyNo);
         return ResponseEntity
               .ok()
               .body("delSuccess");
      } catch (Exception e) {
         return ResponseEntity
               .internalServerError()
               .body(e.getMessage());
      }


   }


}













































package project.blog.community.project.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import project.blog.community.project.dto.request.SignUpRequestDto;
import project.blog.community.project.service.UserService;
import project.blog.community.util.MailSenderService;

@Controller
@RequestMapping("/users")
@RequiredArgsConstructor
@Slf4j
public class UserController {

   private UserService userService;
   private final MailSenderService mailSenderService;

   @GetMapping("/sign-up")
   public void signUp() {
      log.info("/users/sign-up: GET!!");
   }

   @GetMapping("/check/{type}/{keyword}")
   @ResponseBody
   public ResponseEntity<?> check(@PathVariable String type,
                                  @PathVariable String keyword) {
      log.info("/users/check: GET!");
      log.info("type = {}", type);
      log.info("keyword = {]", keyword);

      boolean flag = userService.checkDuplicateValue(type, keyword);

      return ResponseEntity.ok().body(flag);
   }

   @PostMapping("/sign-up")
   public String signUp(SignUpRequestDto dto) {
      log.info("/users/sign-up: POST!");
      log.info("dto = {}", dto);

      userService.join(dto);
      return "redirect:/";

   }

   // 로그인 페이지
   @GetMapping("/sign-in")
   public void signIN() {
   }

   // 이메일 인증
   @PostMapping("/email")
   @ResponseBody
   public ResponseEntity<String> mailCheck(@RequestBody String email) {
      log.info("이메일 인증 요청 들어옴: {}", email);
      try {
         String authNum = mailSenderService.joinEmail(email);
         return ResponseEntity.ok().body(authNum);
      } catch (Exception e) {
         e.printStackTrace();
         return ResponseEntity.internalServerError().body("이메일 전송 과정에서 에러 발생!");
      }
   }






}













































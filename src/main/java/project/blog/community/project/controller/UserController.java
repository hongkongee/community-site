package project.blog.community.project.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import project.blog.community.project.dto.request.SignUpRequestDto;
import project.blog.community.project.service.UserService;

@Controller
@RequestMapping("/users")
@RequiredArgsConstructor
@Slf4j
public class UserController {

   private UserService userService;

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






}













































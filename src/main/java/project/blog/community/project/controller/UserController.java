package project.blog.community.project.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import project.blog.community.project.dto.request.LoginRequestDTO;
import project.blog.community.project.dto.request.SignUpRequestDto;
import project.blog.community.project.service.LoginResult;
import project.blog.community.project.service.UserService;

@Controller
@RequestMapping("/users")
@RequiredArgsConstructor
@Slf4j
public class UserController {

   private final UserService userService;

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
      return "redirect:/home/main";

   }

   // 로그인 양식 화면 요청 처리
   @GetMapping("/sign-in")
   public void signIn() {
      log.info("/users/sign-in: GET!!");
   }

   //로그인 검증 요청
   @PostMapping("/sign-in")
   public String signIn(LoginRequestDTO dto,
                        RedirectAttributes ra) {
      log.info("/users/sign-in: POST!!");
      log.info("dto = {}", dto);

      LoginResult result = userService.authenticate(dto);
      log.info("result = {}", result);

      ra.addFlashAttribute("result", result);

      if (result == LoginResult.SUCCESS) {
         return "redirect:/home/main";
      }

      return "redirect:/users/sign-in";

   }






}













































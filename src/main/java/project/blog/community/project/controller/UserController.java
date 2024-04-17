package project.blog.community.project.controller;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
import project.blog.community.util.MailSenderService;

@Controller
@RequestMapping("/users")
@RequiredArgsConstructor
@Slf4j
public class UserController {

   private final UserService userService;
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
                        RedirectAttributes ra,
                        HttpServletResponse response,
                        HttpServletRequest request) {
      log.info("/users/sign-in: POST!!");
      log.info("dto = {}", dto);

      LoginResult result = userService.authenticate(dto);
      log.info("result = {}", result);

      ra.addFlashAttribute("result", result);

      if (result == LoginResult.SUCCESS) {
         // makeLoginCookie(dto, response);
         userService.maintainLoginState(request.getSession(), dto.getAccountNumber());
         return "redirect:/home/main";
      }

      return "redirect:/users/sign-in";

   }

   private void makeLoginCookie(LoginRequestDTO dto, HttpServletResponse response) {
      //쿠키 로그인 기록을 저장
      Cookie cookie = new Cookie("login", dto.getAccountNumber());

      cookie.setMaxAge(86400);
      cookie.setPath("/");

      // 쿠키가 완성 됐다면 응답
      response.addCookie(cookie);
   }

   // 로그아웃 요청 처리
   @GetMapping("/sign-out")
   public String signOut(HttpSession session) {

      // 세션에서 로그인 정보 기록 삭제
      session.removeAttribute("login");

      // 세션 전체 무효화 (초기화)
      session.invalidate();

      return "redirect:/";

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













































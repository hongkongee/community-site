package project.blog.community.project.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import project.blog.community.project.dto.response.BoardMyListResponseDTO;
import project.blog.community.project.dto.response.FollowerResponseDTO;
import project.blog.community.project.dto.response.LoginUserResponseDTO;
import project.blog.community.project.dto.response.MypageUserResponseDTO;
import project.blog.community.project.service.BoardService;
import project.blog.community.project.service.FollowingService;
import project.blog.community.project.service.GameService;
import project.blog.community.project.service.UserService;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static project.blog.community.util.LoginUtils.getCurrentLoginMemberAccount;

@Controller
@RequiredArgsConstructor
@RequestMapping("/mypage")
@Slf4j
public class MyPageController {

   private final UserService userService;
   private final FollowingService followingService;
   private final BoardService boardService;
   private final GameService gameService;

   @GetMapping("/home/{account}")
   public String myHome(@PathVariable String account, HttpServletRequest request, Model model){
      log.info("/mypage/home/{}: GET!", account);
      
      // 홈페이지 유저 정보 가져오기
      MypageUserResponseDTO userInformation = userService.getUserInformation(account);
      model.addAttribute("user", userInformation);

//      log.info("user: " + userInformation.toString());


      // 로그인한 유저의 정보가져오기
      HttpSession session = request.getSession();
      LoginUserResponseDTO loginDto = (LoginUserResponseDTO) session.getAttribute("login");

//      String loginAccount = getCurrentLoginMemberAccount(session);
      model.addAttribute("login", loginDto);
//      log.info(loginDto.toString());
      String myAccount = loginDto.getAccountNumber();

      // 나(로그인한 유저)의 팔로잉 정보 가져오기
      List<FollowerResponseDTO> myFollowing = followingService.findUserFollowing(myAccount);
      List<String> myFollowingAccount = new ArrayList<>();

      for (FollowerResponseDTO dto : myFollowing) {
         myFollowingAccount.add(dto.getAccountNumber());
      }

      log.info(" ===== 나의 팔로잉 유저 목록: ===== ");
      for (String s : myFollowingAccount) {
         log.info(s + " ");
      }
      model.addAttribute("myfollowings", myFollowingAccount);
      
      // 팔로잉 정보 가져오기
      List<FollowerResponseDTO> userFollowing = followingService.findUserFollowing(account);

/*      for (FollowerResponseDTO dto : userFollowing) {
         log.info(dto.toString());
      }*/

      model.addAttribute("followings", userFollowing);


      // 팔로워 정보 가져오기
      List<FollowerResponseDTO> userFollower = followingService.findUserFollower(account);

      log.info(" ===== 팔로워 유저 목록: ===== ");
   /*   for (FollowerResponseDTO dto : userFollower) {
         log.info(dto.toString());
      }*/
      model.addAttribute("followers", userFollower);
      
      // 유저의 인기 게시물 가져오기
      List<BoardMyListResponseDTO> boardList = boardService.getUserList(userInformation.getAccountNumber());
      log.info("user Hot List : " );
      for (BoardMyListResponseDTO post : boardList) {
         log.info(post.toString());
      }
      model.addAttribute("posts", boardList);

      // 나의 중고마켓 평가 가져오기
      




      return "mypage/mypage";
   }

   // 자기소개 수정하기
   @PutMapping("/intro")
   @ResponseBody
   public ResponseEntity<String> introSubmit(@RequestBody Map<String, String> requestBody,
                                             HttpServletRequest request,
                                             BindingResult result) {
      String introduction = requestBody.get("introduction");
      log.info("/mypage/intro: PUT! " + introduction);

      if (result.hasErrors()) {
         return ResponseEntity
                 .badRequest()
                 .body(result.toString());
      }

      HttpSession session = request.getSession();

      session.getAttribute("login");
      // 세션 유틸리티 메서드로 로그인한 유저 ID 가져오기
      String myAccount = getCurrentLoginMemberAccount(session);

      // 자기소개 수정하기
      boardService.modifyMyIntro(myAccount, introduction);


      return ResponseEntity.ok().body("modSuccess");
   }

   // 포인트 일일 지급
   @PostMapping("/dailypoint")
   @ResponseBody
   public ResponseEntity<?> getDailyPoint(HttpServletRequest request, BindingResult result) {

      if (result.hasErrors()) {
         return ResponseEntity
                 .badRequest()
                 .body(result.toString());
      }

      HttpSession session = request.getSession();
      LoginUserResponseDTO loginDto = (LoginUserResponseDTO) session.getAttribute("login");
      String myAccount = loginDto.getAccountNumber();
      
      // 포인트 증가시키기
      int todayPoint = gameService.todayRandomPoint(myAccount);


      return ResponseEntity.ok().body(todayPoint);

   }


}













































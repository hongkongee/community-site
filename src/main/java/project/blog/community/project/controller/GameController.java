package project.blog.community.project.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.Banner;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import project.blog.community.project.dto.request.RpsRequestDTO;
import project.blog.community.project.dto.response.LoginUserResponseDTO;
import project.blog.community.project.dto.response.MypageUserResponseDTO;
import project.blog.community.project.service.GameService;
import project.blog.community.project.service.UserService;

@Controller
@RequiredArgsConstructor
@RequestMapping("/game")
@Slf4j
public class GameController {

    private final GameService gameService;
    private final UserService userService;

    // 홈페이지 - 가위바위보 view
    @GetMapping("/rps")
    public String rpsList(HttpServletRequest request, Model model) {
        log.info("/game/rps: GET");

        // 로그인한 유저 ID 가져오기
        HttpSession session = request.getSession();
        LoginUserResponseDTO loginDto = (LoginUserResponseDTO) session.getAttribute("login");
        String myAccount = loginDto.getAccountNumber();

        // 로그인한 유저 정보 가져오기
        MypageUserResponseDTO userInformation = userService.getUserInformation(myAccount);

        model.addAttribute("user", userInformation);



        // /WEB-INF/views/~~~~~.jsp
        return "home/gamerps";
    }


    // 가위바위보 게임 (비동기)
    @PostMapping("/rps/start")
    @ResponseBody
    public ResponseEntity<String> rpsGame(@RequestBody RpsRequestDTO dto, HttpServletRequest request) {
        // bp: 유저가 입력한 가위바위보를 위한 베팅 금액
        log.info("/game/rps/start: POST, {}", dto.toString());
        // scissors: 가위, rock: 바위, paper: 보

        // 로그인한 유저 정보 가져오기
        HttpSession session = request.getSession();
        LoginUserResponseDTO loginDto = (LoginUserResponseDTO) session.getAttribute("login");
        String myAccount = loginDto.getAccountNumber();

        // 가위바위보 결과
        String result = gameService.rpsPointCalc(dto, myAccount);
        System.out.println(result);


        return ResponseEntity.ok().body(result);

    }

    // 로또 페이지
    @GetMapping("/lotto")
    public String lotto() {
        log.info("/game/lotto: GET");

        // /WEB-INF/views/~~~~~.jsp
        return "game/lotto";
    }

}

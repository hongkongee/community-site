package project.blog.community.project.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import project.blog.community.project.dto.request.ClaimRequestDTO;
import project.blog.community.project.dto.request.RpsRequestDTO;
import project.blog.community.project.service.GameService;


@Controller
@RequestMapping("/home")
@RequiredArgsConstructor
@Slf4j
public class HomeController {

    private final GameService gameService;

    // 홈페이지 - 메인페이지 view
    @GetMapping("/main")
    public String main() {
        log.info("/home/main: GET");

        // /WEB-INF/views/~~~~~.jsp
        return "home/main";
    }

    // 홈페이지 - 전체게시글 view
    @GetMapping("/all")
    public String allBoardList() {
        log.info("/home/all: GET");

        // /WEB-INF/views/~~~~~.jsp
        return "home/all";
    }

    // 홈페이지 - 게시글 조회 view
    @GetMapping("/detail")
    public String detail() {
        log.info("/home/detail: GET");

        // /WEB-INF/views/~~~~~.jsp
        return "home/detail";
    }

    // 게시글 작성자 신고 (비동기)
    @PostMapping("/detail/claim")
    @ResponseBody
    public ResponseEntity<String> claim(@RequestBody ClaimRequestDTO dto) {
        log.info("/home/detail/claim: POST: {}", dto);

        // 신고 체크박스, 신고 내용에 관련한 DB에 저장 (mapper)
        // 만약 신고 횟수가 특정 횟수 이상일 경우 해당 user 계정 정지 or 추방


        return ResponseEntity.ok().body("신고 완료");

    }

    // 홈페이지 - 가위바위보 view
    @GetMapping("/rps")
    public String list() {
        log.info("/home/rps: GET");

        // /WEB-INF/views/~~~~~.jsp
        return "home/gamerps";
    }


    // 가위바위보 게임 (비동기)
    @PostMapping("/rps/game")
    @ResponseBody
    public ResponseEntity<String> rpsGame(@RequestBody RpsRequestDTO dto) {
        // bp: 유저가 입력한 가위바위보를 위한 베팅 금액
        log.info("/home/rps/game: POST, {}", dto.toString());
        // scissors: 가위, rock: 바위, paper: 보


        // 가위바위보 결과
        String result = gameService.rpsPointCalc(dto);
        System.out.println(result);


        return ResponseEntity.ok().body(result);

    }

}

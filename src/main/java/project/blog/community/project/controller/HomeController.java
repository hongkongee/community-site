package project.blog.community.project.controller;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.WebUtils;
import project.blog.community.project.dto.request.LikeRequestDTO;
import project.blog.community.project.dto.request.ReportRequestDTO;
import project.blog.community.project.dto.request.RpsRequestDTO;
import project.blog.community.project.dto.response.BoardDetailResponseDTO;
import project.blog.community.project.dto.response.BoardListResponseDTO;
import project.blog.community.project.service.BoardService;
import project.blog.community.project.service.GameService;
import project.blog.community.project.service.ManagementService;
import project.blog.community.util.FileUtils;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import static project.blog.community.util.LoginUtils.getCurrentLoginMemberAccount;


@Controller
@RequestMapping("/home")
@RequiredArgsConstructor
@Slf4j
public class HomeController {

    private final GameService gameService;
    private final ManagementService managementService;
    private final BoardService boardService;

    // rootPath = "C:/MyWorkspace/pictures/"
    @Value("${file.upload.root-path}")
    private String rootPath;

    // 홈페이지 - 메인페이지 view
    @GetMapping("/main")
    public String main() {
        log.info("/home/main: GET");


        // /WEB-INF/views/~~~~~.jsp
        return "home/main";
    }

    // 홈페이지 - 전체게시글 view
    @GetMapping("/all")
    public String allBoardList(Model model) {
        log.info("/home/all: GET");


        // 보여주고 싶은 게시물 리스트
        List<BoardListResponseDTO> dtoList = boardService.getList();

        model.addAttribute("bList", dtoList);

        // 로그인 정보 가져오기


        // /WEB-INF/views/~~~~~.jsp
        return "home/all";
    }

    // 카테고리에 따른 하위 게시판 목록 페이지 view
    @GetMapping("/board/{category}")
    public String categoryBoardList(@PathVariable("category") String category, Model model) {
        log.info("/home/{}: GET", category);

        List<BoardListResponseDTO> categoryList = boardService.getCategoryList(category);
//        log.info(categoryList.toString());
        model.addAttribute("bList", categoryList);

        return "home/all";

    }

    // 홈페이지 - 게시글 상세 페이지 view
    @GetMapping("/detail/{bno}")
    public String detail(@PathVariable("bno") int bno,  HttpServletRequest request, Model model) {
        log.info("/home/detail/{}: GET", bno);
        BoardDetailResponseDTO dto = boardService.getDetail(bno);

        model.addAttribute("b", dto);
        log.info("image path: " + dto.getPostImg());

        Cookie c = WebUtils.getCookie(request, "like" + bno);


        if (c != null) { // 이미 좋아요를 눌렀다면
            model.addAttribute("l", 1);
        } else { // 좋아요를 누르지 않았다면
            model.addAttribute("l", 0);
        }

        // /WEB-INF/views/~~~~~.jsp
        return "home/detail";
    }

    // 게시글 작성자 신고 (비동기)
    @PostMapping("/detail/report")
    @ResponseBody
    public ResponseEntity<String> report(@RequestBody ReportRequestDTO dto) {
        log.info("/home/detail/report: POST: {}", dto);

        // 신고 체크박스, 신고 내용에 관련한 DB에 저장 (mapper)
        managementService.report(dto);

        // 만약 신고 횟수가 특정 횟수 이상일 경우 해당 user 계정 정지 or 추방


        return ResponseEntity.ok().body("신고 완료");

    }

    // 좋아요 수 바꾸기 (비동기)
    @PostMapping("/detail/like")
    @ResponseBody
    public ResponseEntity<Integer> report(@RequestBody LikeRequestDTO dto,
                                          HttpServletRequest request,
                                          HttpServletResponse response) {
        log.info("/home/detail/like: POST: {}, {}", dto.getBno(), dto.getNumber());


        // 좋아요 수 1 증가 또는 1 감소시키기
        int isCookie = boardService.changeLike(dto, request, response);


        return ResponseEntity.ok().body(isCookie);

    }

    // 글쓰기 페이지 view
    @GetMapping("/write")
    public String writeBoard(Model model) {
        log.info("/home/write: GET");


        // /WEB-INF/views/~~~~~.jsp
        return "home/write";
    }
    
    // 글쓰기 제출 페이지 (DTO 안쓰고)
    @PostMapping("/write")
    public String writeSubmit(@RequestParam("category") String category,
                              @RequestParam("title") String title,
                              @RequestParam("content") String content,
                              @RequestParam("file") MultipartFile uploadedImage,
                              HttpServletRequest request) {

        log.info("/home/write: POST, {}, {}, {}", category, title, content);
        log.info("file-name: {}", uploadedImage.getOriginalFilename());
        log.info("file-size: {}KB", uploadedImage.getSize() / 1024.0); // getSize()는 MB 단위
        log.info("file-type: {}", uploadedImage.getContentType());

        // 세션에서 자신의 account 가져오기
        HttpSession session = request.getSession();
        session.getAttribute("login");
        String writer = getCurrentLoginMemberAccount(session);

        // 서버에 파일 업로드 지시
        String savePath = FileUtils.uploadFile(uploadedImage, rootPath);
        log.info("save-path: {}", savePath);


        // board table 에 게시글 저장하기: writer, title, content, file-image (파일 경로), category
        boardService.saveBoard(category, title, content, savePath, writer);

        return "home/all";
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

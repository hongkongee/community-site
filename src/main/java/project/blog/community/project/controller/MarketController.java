package project.blog.community.project.controller;

import io.micrometer.common.util.StringUtils;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.catalina.connector.Request;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.Banner;
import org.springframework.http.ResponseEntity;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import project.blog.community.project.common.*;
import project.blog.community.project.dto.request.MarketModifyRequestDTO;
import project.blog.community.project.dto.request.MarketRateRequestDTO;
import project.blog.community.project.dto.request.MarketWriteRequestDTO;
import project.blog.community.project.dto.response.*;
import project.blog.community.project.entity.Board;
import project.blog.community.project.entity.Reply;
import project.blog.community.project.service.MarketService;
import project.blog.community.project.service.ReplyService;
import project.blog.community.util.LoginUtils;
import project.blog.community.util.upload.FileUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static project.blog.community.util.LoginUtils.getCurrentLoginMemberAccount;

@Controller
@RequestMapping("/market")

@RequiredArgsConstructor
@Slf4j
public class MarketController {
    private final MarketService marketService;

    @Value("${googleMap.app-key}")
    private String googleMapKey;

    @Value("${file.upload.root-path}")
    private String rootPath;

    //메인
//    @GetMapping("/main")
//    public String mainPage() {
//        log.info("/market/main: GET");
//
//        // /WEB-INF/views/~~~~~.jsp
//        return "market/MarketMain";
//    }

    //리스트 뷰
    @GetMapping("/list")
    public String list(Model model, HttpServletRequest request, @ModelAttribute("s") Search page) {


        log.info("/market/list: GET");
        page.setAmount(10);

        List<MarketListResponseDTO> dtoList = marketService.getList(request, page);
        log.info("dtoList: {}", dtoList);

        PageMaker pageMaker = new PageMaker(page, marketService.getCountAll(page));
        log.info( "count all is " + marketService.getCountAll(page));

        //정보를 jsp로 전달 -> key-value 형태로 데이터를 추가
        model.addAttribute("bList", dtoList); //jsp로 전달하는 역할
        model.addAttribute("maker", pageMaker);

        log.info("isFavorite" + dtoList);
        // /WEB-INF/views/~~~~~.jsp
        return "market/MarketList";
    }


    //글쓰기 화면
    @GetMapping("/write")
    public String write() {
        log.info("/market/write: GET 글쓰기");
        return "market/MarketWrite";
    }


    //글쓰고 리다이렉트
    @PostMapping("/write")
    public String write(MarketWriteRequestDTO dto, @RequestParam("formFile") MultipartFile file, HttpServletRequest request) {
        log.info("/market/write : POST, dto: {}", dto);
        log.info("Uploaded file name: {}", file.getOriginalFilename());
        log.info("File size: {}", file.getSize());

        //현재 로그인한 유저 ID
        HttpSession session = request.getSession();
        session.getAttribute("login");

        // 세션 유틸리티 메서드로 로그인한 유저 ID 가져오기
        String currentLoginMemberAccount = getCurrentLoginMemberAccount(session);

        String filePath = FileUtils.uploadFile(file, rootPath);

        marketService.register(dto, filePath, currentLoginMemberAccount);
        return "redirect:/market/list";

    }


    //디테일 뷰
    @GetMapping("/detail/{boardNo}")
    public String detail(@PathVariable("boardNo") int boardNo, Model model) {
        log.info("/market/detail/{}: GET", boardNo);
        MarketDetailResponse dto = marketService.getDetail(boardNo);


        int rate = marketService.getRate(dto.getTextWriter());


        model.addAttribute("b", dto);
        model.addAttribute("rate", rate);
        log.info("rate = " + rate); //누계

        return "market/MarketDetail";
    }



    //수정하기
    @PostMapping("/detail/{boardNo}")
    @ResponseBody //response 할 때 추가함 //비동기
    public ResponseEntity<String> update(@Validated MarketModifyRequestDTO dto, @RequestPart(value = "formFile", required = false) MultipartFile file,
                                         BindingResult result) {


        //에러 없을시 건너뜀 : 400에러
        if (result.hasErrors()) {
            return ResponseEntity
                    .badRequest()
                    .body(result.toString());
        }

        log.info("/detail: PUT, dto: {}", dto);

        String filePath = null;
        if (file != null) {
            filePath = FileUtils.uploadFile(file, rootPath);
        }

        //성공시 200
        marketService.modify(dto, filePath);
        return ResponseEntity.ok().body("modSuccess"); //담음
    }


    //삭제
    @DeleteMapping("/detail/{boardNo}")
    public String delete(@PathVariable("boardNo") int boardNo) {
        log.info("/delete/{}: GET, boardNo:", boardNo);
        marketService.delete(boardNo);

        return "redirect:/market/list";
    }

    // 즐겨찾기 boardNo 게시물에 즐겨찾기를 눌렀을 때 발생
    @PostMapping("/list/{boardNo}")
    //@ResponseBody //메서드의 반환 값이 HTTP 응답 본문으로 사용
    public ResponseEntity<?> addFavList(Model model,
                                        @PathVariable("boardNo") int boardNo,
                                        @RequestBody Map<String, Object> isAddFav,
                                        HttpSession session) {

        log.info("/list/{}: POST!", boardNo);
        log.info("isAddFav: {}", isAddFav);
        boolean flag = (Boolean) isAddFav.get("isAddFav");
        log.info("addFavList flag: {}", flag);


        // 즐겨찾기를 DB에 추가하는 기능
        marketService.updateFav(boardNo, session, String.valueOf(flag));
        return ResponseEntity.ok().body("success");
    }

    // 좋아요, 평가 기능
    @PostMapping("/detail")
    @ResponseBody
    public ResponseEntity<?> rate(@RequestBody MarketRateRequestDTO dto, HttpServletRequest request) {
        log.info("/market/detail: post {}", dto.toString());
        //글번호

        //항상 request, session 오고(비로그인含) session 안에 로그인이 있는지 판단
        HttpSession session = request.getSession();
        session.getAttribute("login");
        // 세션 유틸리티 메서드로 로그인한 유저 ID 가져오기
        String myAccount = getCurrentLoginMemberAccount(session);

        // HttpServletRequest가 null인 경우에도 처리

        if (myAccount == null) { // 로그인을 안 한 경우
            return ResponseEntity.ok().body("로그인이 필요합니다."); // MockHttpSession을 사용하여 HttpSession 생성
        }

        // 중복 확인하기 (이미 내가 해당 게시물에 좋아요 평가를 했는지 확인)
        boolean flag = marketService.isDuplication(dto);

        log.info("rate get flag{} ", flag);
        if (flag) { // 중복
            return ResponseEntity.ok().body("이미 추천한 게시물입니다.");
            
        } else {
            marketService.addRate(dto); // rate 저장하기
            return ResponseEntity.ok().body("좋아요를 추가했습니다.");
        }

    }
//

    //동기 페이징 처리
    @GetMapping("/listPage")
    public String listPage(Model model, @ModelAttribute("s") Search page, HttpServletRequest request) {
        System.out.println("search = " + page);
        log.info("/market/listPage: GET!!!");

        //보여주고 싶은 게시물 리스트
        List<MarketListResponseDTO> marketList = marketService.getMarketList(page, request);

        // 페이징 버튼 알고리즘 적용 -> 사용자가 요청한 페이지 정보, 총 게시물 개수를 전달.
        // 페이징 알고리즘 자동 호출.
        PageMaker pageMaker = new PageMaker(page, marketService.getCount(page, request));


        model.addAttribute("bList", marketList);
        model.addAttribute("maker", pageMaker);

        log.info(marketList.toString());

        return "market/list";
    }




    // 비동기 페이징 처리
//    @GetMapping("/list/page/{pageNo}")
//    public ResponseEntity<?> list(@PathVariable int boardNo, @PathVariable int pageNo) {
//        log.info("api/v1/replies{}: GET!!!", boardNo);
//        log.info("pageNo: {}", pageNo);
//
//        Page page = new Page();
//        page.setPageNo(pageNo);
//        page.setAmount(5);
//
//        MarketPageListResponseDTO getPage = marketService.getList(boardNo, page);
//
//        return ResponseEntity.ok().body(getPage);
//    }

}
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
import project.blog.community.project.common.PageMaker;
import project.blog.community.project.common.Search;
import project.blog.community.project.dto.request.BoardModifyRequestDTO;
import project.blog.community.project.dto.request.LikeRequestDTO;
import project.blog.community.project.dto.request.ReportRequestDTO;
import project.blog.community.project.dto.response.*;
import project.blog.community.project.service.*;
import project.blog.community.util.FileUtils;

import java.util.List;
import java.util.Map;

import static project.blog.community.util.LoginUtils.getCurrentLoginMemberAccount;


@Controller
@RequestMapping("/home")
@RequiredArgsConstructor
@Slf4j
public class HomeController {

   private final ManagementService managementService;
   private final BoardService boardService;
   private final UserService userService;
   private final MarketService marketService;

   // rootPath = "C:/MyWorkspace/pictures/"
   @Value("${file.upload.root-path}")
   private String rootPath;

   // 메인페이지
   // 홈페이지 - 메인페이지 view (인기순)
   @GetMapping("/main")
   public String mainPage(Model model) {
      log.info("/home/main: GET");

      List<BoardListResponseDTO> dtoList = boardService.getHotList("popular");

      model.addAttribute("bList", dtoList);
      model.addAttribute("r", 0); // recent 여부

      // 중고 거래 게시판 불러오기
      List<MainMarketResponseDTO> marketList = marketService.getRecentList();
      model.addAttribute("mList", marketList);


      // /WEB-INF/views/~~~~~.jsp
      return "home/main";
   }


   // 메인페이지 인기 게시글 정렬 선택 (최신순)
   @GetMapping("/main/recent")
   public String sortBoard(Model model) {
      log.info("/home/main/sort: GET ");


      List<BoardListResponseDTO> dtoList = boardService.getHotList("recent");

      model.addAttribute("bList", dtoList);
      model.addAttribute("r", 1);

      // 중고 거래 게시판 불러오기
      List<MainMarketResponseDTO> marketList = marketService.getRecentList();
      model.addAttribute("mList", marketList);


      return "home/main";
   }

   // 홈페이지 - 전체게시글 view
   @GetMapping("/board/all")
   public String allBoardList(Model model, @ModelAttribute("s") Search page) {
      log.info("/home/board/all: GET");
      log.info("search = " + page);
      // page: type, keyword, pageNo(페이지 번호), amount(한 화면의 게시물 수)
      page.setAmount(20);

      // 보여주고 싶은 게시물 리스트
      List<BoardListResponseDTO> dtoList = boardService.getList(page);

      // 페이징 버튼 알고리즘 적용 -> 사용자가 요청한 페이지 정보, 총 게시물 개수를 전달.
      // 페이징 알고리즘 자동 호출.
      PageMaker pageMaker = new PageMaker(page, boardService.getCountAll(page));

      model.addAttribute("bList", dtoList);
      model.addAttribute("maker", pageMaker);
      model.addAttribute("li", "전체 게시판");
      model.addAttribute("c", "all");

      // 로그인 정보 가져오기


      // /WEB-INF/views/~~~~~.jsp
      return "home/all";
   }

   // 검색하기 (유저의 아이디, 검색어)
   @GetMapping("/board/all/{account}")
   public String userSearchTitleList(@PathVariable String account, Model model, String keyword) {
      log.info("/home/board/all/{}: GET", account);
      Search page = new Search();
      page.setKeyword(keyword);



      log.info("search = " + page);
      // page: type, keyword, pageNo(페이지 번호), amount(한 화면의 게시물 수)
      page.setAmount(20);

      // 보여주고 싶은 게시물 리스트
      List<BoardListResponseDTO> dtoList = boardService.getListUserSearch(page, account);

      // 페이징 버튼 알고리즘 적용 -> 사용자가 요청한 페이지 정보, 총 게시물 개수를 전달.
      // 페이징 알고리즘 자동 호출.
      PageMaker pageMaker = new PageMaker(page, boardService.getCountSearch(page, account));

      model.addAttribute("bList", dtoList);
      model.addAttribute("maker", pageMaker);
      model.addAttribute("li", "전체 게시판");
      model.addAttribute("c", "all"); // 페이징을 위한 url 정보

      // 로그인 정보 가져오기


      // /WEB-INF/views/~~~~~.jsp
      return "home/all";
   }


   // 카테고리에 따른 하위 게시판 목록 페이지 view
   @GetMapping("/board/{category}")
   public String categoryBoardList(@PathVariable("category") String category, Model model, @ModelAttribute("s") Search page) {
      log.info("/home/{}: GET", category);
      page.setAmount(20);

      List<BoardListResponseDTO> categoryList = boardService.getCategoryList(category, page);
      PageMaker pageMaker = new PageMaker(page, boardService.getCountCategory(category, page));


      // 카테고리에 따른 게시판 이름 작성
      String listName = boardService.stringToCategoryDescription(category);

      model.addAttribute("bList", categoryList);
      model.addAttribute("maker", pageMaker);
      model.addAttribute("li", listName);
      model.addAttribute("c", category);

      return "home/all";

   }

   // 홈페이지 - 게시글 상세 페이지 view
   @GetMapping("/detail/{bno}")
   public String detail(@PathVariable("bno") int bno, HttpServletRequest request, Model model) {
      log.info("/home/detail/{}: GET", bno);
      BoardDetailResponseDTO dto = boardService.getDetail(bno);

      model.addAttribute("b", dto);
      log.info("image path: " + dto.getPostImg());
      log.info("b.category: " + dto.getCategory());

//        Cookie c = WebUtils.getCookie(request, "like" + bno);
      // 좋아요 이미 눌렀는지 확인하기
      int like = boardService.checkLike(request, bno);
      log.info("already pushed like or not? : " + like);

      if (like > 0) { // 이미 좋아요를 눌렀다면
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
   public ResponseEntity<?> report(@RequestBody ReportRequestDTO dto, HttpServletRequest request, HttpServletResponse response) {
      log.info("/home/detail/report: POST: {}", dto.toString());

      // 로그인 정보
      HttpSession session = request.getSession();
      LoginUserResponseDTO loginDto = (LoginUserResponseDTO) session.getAttribute("login");
      String myAccount = loginDto.getAccountNumber();

      // 쿠키 존재 확인하기

      try {
         Cookie c = WebUtils.getCookie(request, "report");
         String cookieValue = c.getValue();
         log.info("cookie's name is " + cookieValue);
         if (cookieValue.equals(myAccount)) {
            return ResponseEntity.ok().body(-1); // 오늘 신고 이미 눌렀는데?

         } else {
            // 쿠키가 있긴 있는데 다른 유저의 것
            // 신고 체크박스, 신고 내용에 관련한 DB에 저장 (mapper)
            managementService.report(dto, myAccount, response);
            return ResponseEntity.ok().body(1);

         }
      } catch (NullPointerException e) {
         // 쿠키가 없는 상태
         // 신고 체크박스, 신고 내용에 관련한 DB에 저장 (mapper)
         managementService.report(dto, myAccount, response);
         return ResponseEntity.ok().body(1);
      }

      // 신고를 이미 했는지 확인
      


   }

   // 좋아요 수 바꾸기 (비동기)
   @PostMapping("/detail/like")
   @ResponseBody
   public ResponseEntity<Integer> report(@RequestBody LikeRequestDTO dto,
                                         HttpServletRequest request) {
      log.info("/home/detail/like: POST: {}, {}", dto.getBno(), dto.getNumber());


      // 좋아요 수 1 증가 또는 1 감소시키기
      int isCookie = boardService.changeLike(dto, request);


      return ResponseEntity.ok().body(isCookie);

   }

   // 글쓰기 페이지 view
   @GetMapping("/write")
   public String writeBoard(Model model) {
      log.info("/home/write: GET");


      // /WEB-INF/views/~~~~~.jsp
      return "home/write";
   }

   // 글 삭제
   @GetMapping("/remove/{bno}")
   @ResponseBody
   public ResponseEntity<?> deleteBoard(@PathVariable("bno") int bno) {
      log.info("/home/remove: GET! {}", bno);

      boardService.delete(bno);
      return ResponseEntity.ok().body("삭제 완료");

   }
   
   // 글 수정 페이지 view
   @GetMapping("/modify/{bno}")
   public String modifyBoard(@PathVariable int bno, Model model) {
      log.info("/home/modify/{}: GET!", bno);
      

      BoardDetailResponseDTO modifyDetail = boardService.getModifyDetail(bno);
      model.addAttribute("m", modifyDetail);

      return "home/modify";
   }

   // 글 수정 제출 form태그 post
   @PostMapping("/modify")
   public String modifySubmit(BoardModifyRequestDTO dto) {
      log.info("/home/modify : POST! {}", dto);

      log.info("file-name: {}", dto.getFile().getOriginalFilename());
      log.info("file-size: {}KB", dto.getFile().getSize() / 1024.0); // getSize()는 MB 단위
      log.info("file-type: {}", dto.getFile().getContentType());

      // 서버에 파일 업로드 지시
      String savePath = null;

      if (dto.getFile().getSize() == 0) {
         // 아무것도 업로드 안함 -> 수정할 때는 원래 있었던 이미지 파일을 유지하는게 좋을듯, DB 수정은 안함
         BoardDetailResponseDTO modifyDetail = boardService.getModifyDetail(dto.getBno());
         String storedImgPath = modifyDetail.getPostImg();
         savePath = storedImgPath;

         boardService.modifyBoard(dto, savePath);

      } else {

         // 무언가 업로드 -> 새로 업로드
         savePath = FileUtils.uploadFile(dto.getFile(), rootPath);

         // DB에 정보 수정
         boardService.modifyBoard(dto, savePath);
      }

      log.info("save-path: {}", savePath);



      return "redirect:/home/detail/" + dto.getBno();
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
      String savePath = null;

      if (uploadedImage.getSize() == 0) {
         savePath = null;
      } else {
         savePath = FileUtils.uploadFile(uploadedImage, rootPath);
      }
      log.info("save-path: {}", savePath);


      // board table 에 게시글 저장하기: writer, title, content, file-image (파일 경로), category
      boardService.saveBoard(category, title, content, savePath, writer);

      return "redirect:/home/board/" + category;
   }

   // 오른쪽 사이드바 포인트 렌더링
   @PostMapping("/snb")
   @ResponseBody
   public ResponseEntity<?> myPoint(HttpServletRequest request) {
      log.info("/home/snb: POST!!!");

      // 로그인 유저 account 가져오기
      HttpSession session = request.getSession();
      session.getAttribute("login");
      String myAccount = getCurrentLoginMemberAccount(session);

      // 로그인 유저 정보 가져오기
      MypageUserResponseDTO myInfo = userService.getUserInformation(myAccount);
      int point = myInfo.getPoint();
      log.info("my point is " + point);


      return ResponseEntity.ok().body(point);
   }


}

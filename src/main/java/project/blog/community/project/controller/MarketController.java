package project.blog.community.project.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import project.blog.community.project.common.marketSearch;
import project.blog.community.project.dto.request.MarketModifyRequestDTO;
import project.blog.community.project.dto.request.MarketWriteRequestDTO;
import project.blog.community.project.dto.response.MarketDetailResponse;
import project.blog.community.project.dto.response.MarketListResponseDTO;
import project.blog.community.project.dto.response.MarketModifyResponse;
import project.blog.community.project.entity.Board;
import project.blog.community.project.entity.Reply;
import project.blog.community.project.service.MarketService;

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

//    @Value("${googleMap.app-key}")
    private String googleMapKey;

    @GetMapping("/main")
    public String mainPage() {
        log.info("/market/main: GET");

        // /WEB-INF/views/~~~~~.jsp
        return "market/MarketMain";
    }

    @GetMapping("/list")
    public String list(Model model, HttpServletRequest request) {

        log.info("/market/list: GET");

        List<MarketListResponseDTO> dtoList = marketService.getList(request);
        log.info("dtoList: {}", dtoList);

        //정보를 jsp로 전달 -> key-value 형태로 데이터를 추가
        model.addAttribute("bList", dtoList); //jsp로 전달하는 역할

        log.info("isFavorite" + dtoList);
        // /WEB-INF/views/~~~~~.jsp
        return "market/MarketList";
    }

    @GetMapping("/write")
    public String write(){
        log.info("/market/write: GET");
        return "market/MarketWrite";
    }

    @PostMapping("/write")
    public String write(MarketWriteRequestDTO dto, HttpServletRequest request){
        log.info("/board/write : POST, dto: {}", dto);

        //현재 로그인한 유저 ID
        HttpSession session = request.getSession();
        session.getAttribute("login");
        // 세션 유틸리티 메서드로 로그인한 유저 ID 가져오기
        String currentLoginMemberAccount = getCurrentLoginMemberAccount(session);

        marketService.register(dto, currentLoginMemberAccount);
        return "redirect:/market/list";


    }

    @GetMapping("/detail/{boardNo}")
    public String detail(@PathVariable("boardNo") int boardNo, Model model){
        log.info("/market/detail/{}: GET", boardNo);
        MarketDetailResponse dto = marketService.getDetail(boardNo);

        model.addAttribute("b", dto);
        return "market/MarketDetail";
    }



    @PutMapping("/detail/{boardNo}")
    @ResponseBody //response 할 때 추가함
    public ResponseEntity<String> update(@Validated @RequestBody MarketModifyRequestDTO dto,
                                    BindingResult result) {
        //에러 없을시 건너뜀 : 400에러
        if (result.hasErrors()) {
            return ResponseEntity
                    .badRequest()
                    .body(result.toString());
        }

        log.info("/detail: PUT, dto: {}", dto);

        //성공시 200
        marketService.modify(dto);
        return ResponseEntity.ok().body("modSuccess"); //담음
    }


    @DeleteMapping("/detail/{boardNo}")
    public String delete(@PathVariable("boardNo") int boardNo){
        log.info("/delete/{}: GET, boardNo:", boardNo);
        marketService.delete(boardNo);

        return "redirect:/market/list";
    }

    // boardNo 게시물에 즐겨찾기를 눌렀을 때 발생
    @PostMapping("/list/{boardNo}")
    @ResponseBody //메서드의 반환 값이 HTTP 응답 본문으로 사용
    public ResponseEntity<?> addFavList(Model model,
                                             @PathVariable("boardNo") int boardNo,
                                             @RequestBody Map<String, Object> isAddFav,
                                             HttpSession session) {

        //@RequestBody Map<String, Object> isAddFav
        //HTTP 요청 본문에서 JSON 형식으로 전달된 데이터를
        //Map<String, Object> 타입으로 받습니다.
        // 여기서 isAddFav 키의 값은 즐겨찾기에 추가할지 제거할지를 나타내는
        // 불리언(boolean) 값입니다.



        log.info("/list/{}: POST!", boardNo);
        log.info("isAddFav: {}", isAddFav);
        boolean flag = (Boolean) isAddFav.get("isAddFav");
        log.info("flag: {}", flag);


        // 즐겨찾기를 DB에 추가하는 기능
        marketService.updateFav(boardNo, session, String.valueOf(flag));
        return ResponseEntity.ok().body("success");
    }




}

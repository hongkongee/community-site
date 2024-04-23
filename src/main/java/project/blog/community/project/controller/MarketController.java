package project.blog.community.project.controller;

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
import project.blog.community.project.dto.response.MarketListResponseDTO;
import project.blog.community.project.dto.response.MarketModifyResponse;
import project.blog.community.project.entity.Reply;
import project.blog.community.project.service.MarketService;

import java.util.ArrayList;
import java.util.List;

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
    public String list(Model model) {

        log.info("/market/list: GET");

        List<MarketListResponseDTO> dtoList = marketService.getList();
        log.info("dtoList: {}", dtoList);

        model.addAttribute("bList", dtoList);


        // /WEB-INF/views/~~~~~.jsp
        return "market/MarketList";
    }

    @GetMapping("/write")
    public String write(){
        log.info("/market/write: GET");
        return "market/MarketWrite";
    }

    @PostMapping("/write")
    public String write(MarketWriteRequestDTO dto){
        log.info("/board/write : POST, dto: {}", dto);

        marketService.register(dto);
        return "redirect:/market/list";


    }



    @PutMapping
    @ResponseBody //response 할 때 추가함
    public ResponseEntity<String> update(@Validated @RequestBody MarketModifyRequestDTO dto,
                                    BindingResult result) {

        //에러 없을시 건너뜀 : 400에러
        if (result.hasErrors()) {
            return ResponseEntity
                    .badRequest()
                    .body(result.toString());
        }

        //성공시 200
        marketService.modify(dto);
        return ResponseEntity.ok().body("modSuccess"); //담음
    }






}

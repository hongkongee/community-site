package project.blog.community.project.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import project.blog.community.project.dto.request.MarketModifyRequestDTO;
import project.blog.community.project.service.MarketService;

@Controller
@RequestMapping("/market")
@RequiredArgsConstructor
@Slf4j
public class MarketController {
    private final MarketService marketService;

//    @Value("${googleMap.app-key}")
    private String googleMapKey;

    @GetMapping("/main")
    public String list() {
        log.info("/market/main: GET");

        // /WEB-INF/views/~~~~~.jsp
        return "market/MarketMain";
    }

    @PutMapping("/modify")
    public ResponseEntity<?> update(@Validated @RequestBody MarketModifyRequestDTO dto,
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

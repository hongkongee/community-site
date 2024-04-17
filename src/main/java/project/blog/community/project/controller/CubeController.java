package project.blog.community.project.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("/mypage")
@Slf4j
public class CubeController {

    @GetMapping("/posting_cube")
    public String cube(){
        log.info("/mypage/posting_cube: GET!!!");

        return "posting_cube";
    }
}

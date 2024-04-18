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
public class DiaryController {

    @GetMapping("/diary")
    public String diary(){
        log.info("/mypage/diary: GET!!!");

        return "mypage/diary";
    }

}

package project.blog.community.project.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/home")
@Slf4j
public class HomeController {

    // 홈페이지 - 메인페이지
    @GetMapping("/main")
    public String main() {
        log.info("/home/main: GET");

        // /WEB-INF/views/~~~~~.jsp
        return "home/main";
    }

    // 홈페이지 - 전체게시글
    @GetMapping("/all")
    public String allBoardList() {
        log.info("/home/all: GET");

        // /WEB-INF/views/~~~~~.jsp
        return "home/all";
    }

    // 홈페이지 - 가위바위보
    @GetMapping("/rps")
    public String list() {
        log.info("/home/rps: GET");

        // /WEB-INF/views/~~~~~.jsp
        return "home/gamerps";
    }

}

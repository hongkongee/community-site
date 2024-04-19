package project.blog.community.project.controller;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import project.blog.community.project.common.PageMaker;
import project.blog.community.project.dto.response.BoardMyListResponseDTO;
import project.blog.community.project.service.BoardService;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/mypage")
@Slf4j
public class DiaryController {

    private final BoardService boardService;

    @GetMapping("/diary")
    public String diary(){
        log.info("/mypage/diary: GET!!!");

        return "mypage/diary";
    }

    @GetMapping("/posting_cube")
    public String posting_cube(Model model, HttpServletRequest request) {
        log.info("/mypage/posting_cube: GET!!!");

        // 보여주고 싶은 게시물 리스트
        List<BoardMyListResponseDTO> myList = boardService.getMyList(request);

        model.addAttribute("bList", myList);

        log.info(myList.toString());

        return "mypage/posting_cube";
    }

    

}

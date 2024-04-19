package project.blog.community.project.controller;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import project.blog.community.project.common.PageMaker;
import project.blog.community.project.common.Search;
import project.blog.community.project.dto.response.BoardDetailResponseDTO;
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
    public String diary() {
        log.info("/mypage/diary: GET!!!");

        return "mypage/diary";
    }

    @GetMapping("/posting_cube")
    public String posting_cube(Model model, @ModelAttribute("s") Search page, HttpServletRequest request) {
        System.out.println("search = " + page);
        log.info("/mypage/posting_cube: GET!!!");

        //보여주고 싶은 게시물 리스트
        List<BoardMyListResponseDTO> myList = boardService.getMyList(page, request);

        // 페이징 버튼 알고리즘 적용 -> 사용자가 요청한 페이지 정보, 총 게시물 개수를 전달.
        // 페이징 알고리즘 자동 호출.
        PageMaker pageMaker = new PageMaker(page, boardService.getCount(page));

        model.addAttribute("bList", myList);
        model.addAttribute("maker", pageMaker);

        log.info(myList.toString());

        return "mypage/posting_cube";
    }

    // 큐브 게시물 누르면 그 게시물로 이동
    @GetMapping("/posting_cube/{bno}")
    public String detail(@PathVariable("bno") int bno, @ModelAttribute("s") Search search, Model model) {
        System.out.println("/board/detail: GET! " + bno);
        BoardDetailResponseDTO dto = boardService.getDetail(bno);

        model.addAttribute("b", dto);
        return "home/detail";
    }


}

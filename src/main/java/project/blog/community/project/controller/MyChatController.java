package project.blog.community.project.controller;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import project.blog.community.project.dto.response.FollowerResponseDTO;
import project.blog.community.project.service.FollowingService;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/wel")
@Slf4j
public class MyChatController {

    private final FollowingService followingService;

    @GetMapping("/chat")
    public String chat(Model model, HttpServletRequest request) {
        log.info("/wel/chat: GET!");

        // 팔로잉 목록 조회
        List<FollowerResponseDTO> followingList = followingService.getFollowingList(10, request);
        model.addAttribute("followingList", followingList);

        return "mychat"; // mychat.jsp로 이동
    }

}
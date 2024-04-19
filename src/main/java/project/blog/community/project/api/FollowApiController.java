package project.blog.community.project.api;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import project.blog.community.project.dto.response.ReplyListResponseDTO;
import project.blog.community.project.service.FollowingService;

import static project.blog.community.util.LoginUtils.getCurrentLoginMemberAccount;

@RestController
@RequestMapping("api/v1/follow")
@RequiredArgsConstructor
@Slf4j
public class FollowApiController {

    private final FollowingService followingService;

/*    @GetMapping("")
    public ResponseEntity<?> list(HttpServletRequest request) {
        log.info("api/v1/follow: GET!!!");



        followingService.getFollowingList(request);

        return ResponseEntity.ok().body();
    }*/
}

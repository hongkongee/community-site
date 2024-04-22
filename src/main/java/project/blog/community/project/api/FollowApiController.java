package project.blog.community.project.api;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import project.blog.community.project.dto.response.FollowerResponseDTO;
import project.blog.community.project.service.FollowingService;

import java.util.List;

@RestController
@RequestMapping("/api/v1/follow")
@RequiredArgsConstructor
@Slf4j
public class FollowApiController {

    private final FollowingService followingService;

    // 팔로잉 목록 조회
    @GetMapping("/following/{number}")
    public ResponseEntity<?> followList(@PathVariable int number, HttpServletRequest request) {
        log.info("api/v1/follow/following/{}: GET!!!", number);

        // 팔로우한 사람 목록 (닉네임, id, 프로필 사진 등이 저장)
        // number: 목록에 뜰 사람 수
        try {
            List<FollowerResponseDTO> dtoList = followingService.getFollowingList(number, request);

            for (FollowerResponseDTO dto : dtoList) {
                log.info("My Follow List: {}, {}", dto.getAccountNumber(), dto.getNickname());
            }

            return ResponseEntity.ok().body(dtoList);

        } catch (NullPointerException e) {
            return ResponseEntity.ok().body(null);
        }





    }

    // 작성자 팔로잉 추가하기
    @PostMapping("/add/{writer}")
    public String addFollow(@PathVariable String writer, HttpServletRequest request) {
        log.info("api/v1/follow/add/{}: POST!", writer); // writer : accountNumber

//        followingService.addFollower(writer, request);


        return null;
    }
}

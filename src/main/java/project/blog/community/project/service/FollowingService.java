package project.blog.community.project.service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import project.blog.community.project.mapper.UserMapper;

import static project.blog.community.util.LoginUtils.getCurrentLoginMemberAccount;

@Service
@RequiredArgsConstructor
public class FollowingService {

    private final UserMapper userMapper;

    public void getFollowingList(HttpServletRequest request) {

        HttpSession session = request.getSession();
        session.getAttribute("login");

        // 세션 유틸리티 메서드로 로그인한 유저 ID 가져오기
        String currentLoginMemberAccount = getCurrentLoginMemberAccount(session);
        userMapper.findUserByFollower(currentLoginMemberAccount);

    }
}

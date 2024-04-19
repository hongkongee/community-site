package project.blog.community.project.service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.junit.validator.PublicClassValidator;
import org.springframework.stereotype.Service;
import project.blog.community.project.mapper.UserMapper;

import static project.blog.community.util.LoginUtils.getCurrentLoginMemberAccount;

@Service
@RequiredArgsConstructor
public class FollowingService {

    private final UserMapper userMapper;

    // 내 팔로잉 찾기
    public void getFollowingList(HttpServletRequest request) {

        String currentLoginMemberAccount = getMyAccount(request);

        // 내(로그인한 유저)가 팔로우한 유저 정보 찾기
        userMapper.findUserByFollower(currentLoginMemberAccount);

    }

    // 팔로우 추가하기
    public void addFollowerUser(HttpServletRequest request, String followerAccount) {

        String currentLoginMemberAccount = getMyAccount(request);

        userMapper.addFollower(currentLoginMemberAccount, followerAccount);


    }

    // 내 (로그인한 유저) 계정 찾기
    private String getMyAccount(HttpServletRequest request) {

        HttpSession session = request.getSession();
        session.getAttribute("login");

        // 세션 유틸리티 메서드로 로그인한 유저 ID 가져오기
        return getCurrentLoginMemberAccount(session);

    }

}

package project.blog.community.project.service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import project.blog.community.project.dto.response.FollowerResponseDTO;
import project.blog.community.project.entity.User;
import project.blog.community.project.mapper.UserMapper;

import java.util.ArrayList;
import java.util.List;

import static project.blog.community.util.LoginUtils.getCurrentLoginMemberAccount;

@Service
@RequiredArgsConstructor
public class FollowingService {
    // following : 팔로우 하는 유저
    // follower : 팔로우 당하는 유저 (내가 팔로우 하는 유저)

    private final UserMapper userMapper;

    // 내 팔로잉 찾기
    public List<FollowerResponseDTO> getFollowingList(int number, HttpServletRequest request) {

        String currentLoginMemberAccount = getMyAccount(request);

        // 내(로그인한 유저)가 팔로우한 유저 정보 찾기
        List<String> followers = userMapper.findUserByFollower(number, currentLoginMemberAccount);
        List<FollowerResponseDTO> dtoList = new ArrayList<>();

        for (String follower : followers) {
            User user = userMapper.findUser(follower);
            FollowerResponseDTO dto = new FollowerResponseDTO(user);
            dtoList.add(dto);
        }

        return dtoList;


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

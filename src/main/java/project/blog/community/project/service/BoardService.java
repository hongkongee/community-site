package project.blog.community.project.service;


import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.websocket.SessionException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.util.WebUtils;
import project.blog.community.project.common.Search;
import project.blog.community.project.dto.request.LikeRequestDTO;
import project.blog.community.project.dto.response.BoardDetailResponseDTO;
import project.blog.community.project.dto.response.BoardListResponseDTO;
import project.blog.community.project.dto.response.BoardMyListResponseDTO;
import project.blog.community.project.entity.Board;
import project.blog.community.project.entity.User;
import project.blog.community.project.mapper.BoardMapper;
import project.blog.community.project.mapper.UserMapper;

import java.util.ArrayList;
import java.util.List;

import static project.blog.community.util.LoginUtils.getCurrentLoginMemberAccount;

@Service
@RequiredArgsConstructor
@Slf4j
public class BoardService {

    private final BoardMapper boardMapper;
    private final UserMapper userMapper;

    // 게시판 목록을 조회
    public List<BoardListResponseDTO> getList() {
        List<BoardListResponseDTO> dtoList = new ArrayList<>();
        List<Board> boardList = boardMapper.findAll();

        for (Board board : boardList) {
            String nickname = findNickname(board.getWriter()); // writer(account)를 nickname으로 바꾸기
            BoardListResponseDTO dto = new BoardListResponseDTO(board, nickname);
            dtoList.add(dto);
        }

        return dtoList;

    }

    // 카테고리에 따라 다른 게시판 목록을 보여주는 메서드
    public List<BoardListResponseDTO> getCategoryList(String category) {
        List<BoardListResponseDTO> dtoList = new ArrayList<>();
        List<Board> boardList = boardMapper.findCategory(category);
        for (Board board : boardList) {
            String nickname = findNickname(board.getWriter()); // writer(account)를 nickname으로 바꾸기
            BoardListResponseDTO dto = new BoardListResponseDTO(board, nickname);
            dtoList.add(dto);
        }

        return dtoList;

    }

    public BoardDetailResponseDTO getDetail(int bno) {
        boardMapper.updateViewCount(bno);

        Board board = boardMapper.findOne(bno);
        String nickname = findNickname(board.getWriter());

        return new BoardDetailResponseDTO(board, nickname);

    }

    // account를 주면 nickname을 반환하는 메서드
    private String findNickname(String account) {

        try {
            User user = userMapper.findUser(account);
            return user.getNickname();
        } catch (NullPointerException e) {
            e.printStackTrace();
            return account;
        }
    }


    // 게시물의 좋아요 수 바꾸기
    public int changeLike(LikeRequestDTO dto, HttpServletRequest request, HttpServletResponse response) {
        int bno = dto.getBno();
        int number = dto.getNumber();
        boardMapper.updateLikeCount(bno, number);

        HttpSession session = request.getSession();
        session.getAttribute("login");
        // 세션 유틸리티 메서드로 로그인한 유저 ID 가져오기

        // 좋아요를 눌렀다면 해당 게시글에 대한 쿠키 만들기
        if (number > 0) {
            Cookie cookie = new Cookie("like", Integer.toString(bno));
            cookie.setMaxAge(60);
            cookie.setPath("/");
            response.addCookie(cookie);

            return 1;

        } else { // 좋아요를 안 눌렀다면 해당 게시글에 대한 쿠키 삭제하기
            Cookie cookie = WebUtils.getCookie(request, "like");
            cookie.setMaxAge(0);
            cookie.setPath("/");
            response.addCookie(cookie);

            return 0;
        }
    }

    public List<BoardMyListResponseDTO> getMyList(HttpServletRequest request) {
        List<BoardMyListResponseDTO> dtoList = new ArrayList<>();
        List<Board> boardList = boardMapper.findAll();

        for (Board board : boardList) {
            BoardMyListResponseDTO dto = new BoardMyListResponseDTO(board);
            dtoList.add(dto);
        }

        return dtoList;

    }

    public int getCount(Search page) {
        return boardMapper.getCount(page);
    }

    public List<BoardMyListResponseDTO> getMyList(Search page, HttpServletRequest request) {

        HttpSession session = request.getSession();
        session.getAttribute("login");

        String currentLoginMemberAccount = getCurrentLoginMemberAccount(session);

        List<BoardMyListResponseDTO> dtoList = new ArrayList<>();
        List<Board> boardList = boardMapper.findMine(currentLoginMemberAccount);
        for (Board board : boardList) {
            BoardMyListResponseDTO dto = new BoardMyListResponseDTO(board);
            dtoList.add(dto);
        }
        return dtoList;
    }
}

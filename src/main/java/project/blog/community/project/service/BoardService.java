package project.blog.community.project.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import project.blog.community.project.dto.request.LikeRequestDTO;
import project.blog.community.project.dto.response.BoardDetailResponseDTO;
import project.blog.community.project.dto.response.BoardListResponseDTO;
import project.blog.community.project.entity.Board;
import project.blog.community.project.entity.User;
import project.blog.community.project.mapper.BoardMapper;
import project.blog.community.project.mapper.UserMapper;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class BoardService {

    private final BoardMapper boardMapper;
    private final UserMapper userMapper;

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
    public void changeLike(LikeRequestDTO dto) {
        int bno = dto.getBno();
        int number = dto.getNumber();
        boardMapper.updateLikeCount(bno, number);
    }
}

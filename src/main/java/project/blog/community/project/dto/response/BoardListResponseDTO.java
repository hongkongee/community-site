package project.blog.community.project.dto.response;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.ToString;
import project.blog.community.project.entity.Board;
import project.blog.community.project.entity.Category;
import project.blog.community.project.entity.User;
import project.blog.community.project.mapper.UserMapper;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Getter @ToString
@EqualsAndHashCode
public class BoardListResponseDTO {

    private UserMapper userMapper;

    // 게시물 목록 화면(/home/all)에 보여주고 싶은 board의 정보
    
    private final int bno;
    private final String category;
    private final String title;
    private final String writer;
    private final String regDate;
    private final int viewCount;

    // entity를 dto로 바꾸는 생성자
    public BoardListResponseDTO(Board board) {
        this.bno = board.getBno();
        this.category = board.getCategory().getDescription();
        this.title = makeShortTitle(board.getTitle());
        this.writer = board.getWriter();
        this.regDate = makePrettierDateString(board.getRegDate());
        this.viewCount = board.getViewCount();
    }

    // account를 주면 nickname을 반환하는 함수
    private String findNickname(String account) {
//        account = account.trim();
        try {
            User user = userMapper.findUser(account);
            return user.getNickname();
        } catch (NullPointerException e) {
            e.printStackTrace();
            return account;
        }
    }

    // 날짜 포맷을 바꾸는 함수
    public static String makePrettierDateString(LocalDateTime regDate) {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy.MM.dd.");
        return dtf.format(regDate);
    }

    // 제목 길이를 줄이는 함수
    private String makeShortTitle(String title) {
        return sliceString(title, 15);
    }

    private String sliceString(String targetString, int wishLength) {
        return (targetString.length() > wishLength)
                ? targetString.substring(0, wishLength) + "..."
                : targetString;
    }

}

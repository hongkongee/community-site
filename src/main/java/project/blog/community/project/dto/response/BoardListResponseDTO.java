package project.blog.community.project.dto.response;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.ToString;
import project.blog.community.project.entity.Board;
import project.blog.community.project.mapper.UserMapper;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Random;

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
    private final int likeCount;

    private final String postImg;

    private final String regDate2;
    private final String writerAccount;

    private final int random;

    // entity를 dto로 바꾸는 생성자
    public BoardListResponseDTO(Board board, String nickname) {
        this.bno = board.getBno();
        this.category = board.getCategory().getDescription();
        this.title = makeShortTitle(board.getTitle());
        this.writer = nickname;
        this.regDate = makePrettierDateString(board.getRegDate());
        this.regDate2 = makePrettierDateString2(board.getRegDate());
        this.viewCount = board.getViewCount();
        this.postImg = board.getPostImg();
        this.likeCount = board.getLikeCount();
        this.writerAccount = board.getWriter();

        // 기본 이미지를 위한 난수 생성
        Random random = new Random();
        this.random = random.nextInt(3) + 1;


    }

    private String makePrettierDateString2(LocalDateTime regDate) {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        return dtf.format(regDate);
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

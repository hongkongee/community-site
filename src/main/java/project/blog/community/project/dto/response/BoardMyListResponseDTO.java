package project.blog.community.project.dto.response;


import lombok.*;
import project.blog.community.project.entity.Board;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Random;

@Setter
@Getter
@ToString
@EqualsAndHashCode

@AllArgsConstructor
@Builder
public class BoardMyListResponseDTO {

    private final int bno;
    private final String title; //5글자 이상이면 잘라내기
    private final String regDate;// 날짜패턴 yyyy-MM-dd HH:mm
    private final String writer;
    private int likeCount;
    private String postImg;
    private int isHeart; // 하트 체크 여부
    private final int random;



    public BoardMyListResponseDTO(Board board) {
        this.bno = board.getBno();
        this.title = makeShortTitle(board.getTitle());
        this.regDate = makePrettierDateString(board.getRegDate());
        this.likeCount = board.getLikeCount();
        this.postImg = board.getPostImg();
        this.writer = board.getWriter();

        // 기본 이미지를 위한 난수 생성
        Random random = new Random();
        this.random = random.nextInt(3) + 1;
    }

    private String makeShortTitle(String title) {
        return sliceString(title, 15);
    }

    public static String makePrettierDateString(LocalDateTime regDate) {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        return dtf.format(regDate);
    }

//    private String makeShortContent(String content) {
//        return sliceString(content, 10);
//    }

    private static String sliceString(String targetString, int wishLength) {
        return (targetString.length() > wishLength)
                ? targetString.substring(0, wishLength) + "..."
                : targetString
                ;
    }
}

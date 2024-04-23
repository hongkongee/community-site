package project.blog.community.project.dto.response;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.ToString;
import project.blog.community.project.entity.Board;
import project.blog.community.project.entity.User;
import project.blog.community.project.mapper.UserMapper;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;


@Getter @ToString
@EqualsAndHashCode
public class BoardDetailResponseDTO {
    // 게시글 상세보기 페이지에서 보여줄 데이터

    private UserMapper userMapper;

    private final int bno;
    private final String category;
    private final String title;
    private final String regDate;
    private final String writer;
    private final int viewCount;
    private final int likeCount;

    private final String content;

    public BoardDetailResponseDTO(Board board, String nickname) {
        this.bno = board.getBno();
        this.category = board.getCategory().getDescription();
        this.title = board.getTitle();
        this.writer = nickname;
        this.regDate = makeDateString(board.getRegDate());
        this.viewCount = board.getViewCount();
        this.content = board.getContent();
        this.likeCount = board.getLikeCount();
    }

    private String makeDateString(LocalDateTime regDate) {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy.MM.dd. HH:mm");
        return dtf.format(regDate);
    }

}

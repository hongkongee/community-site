package project.blog.community.project.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

@AllArgsConstructor
@Getter
@ToString
public enum Category {
    NORMAL("질문 게시판", 1),
    MARKET("자유 게시판", 2),
    GAME("코드 공유 게시판", 3),
    MOVIE("취업 게시판", 4),
    TRIP("IT 소식 게시판", 5);

    private String description;
    private int authNumber;
}

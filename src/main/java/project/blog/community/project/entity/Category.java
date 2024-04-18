package project.blog.community.project.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

@AllArgsConstructor
@Getter
@ToString
public enum Category {
    NORMAL("일반글", 1),
    MARKET("당근글", 2),
    GAME("게임글", 3),
    MOVIE("영화글", 4),
    TRIP("여행글", 5);

    private String description;
    private int authNumber;
}

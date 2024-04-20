package project.blog.community.project.dto.response;


import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import project.blog.community.project.entity.Favorite;
import project.blog.community.project.entity.Market;

import java.time.LocalDateTime;
import java.util.List;

@Getter @ToString
@EqualsAndHashCode

public class
MarketListResponseDTO {

    private final int boardNo;
    private final String textWriter;
    private final LocalDateTime updateDate;
//    private LocalDateTime updateDate;
    private final String textTitle;
//    private int rate;
    private int isFavorite;


    private int viewCount;
//    private int price;
//    private String location;
//    private String ContentImg; //XML profile_image 스네이크 케이스 자동 인식
//    private String loginMethod; //sql tbl 타입과 일치 시켜야 함

    //DB -> DTO
    public MarketListResponseDTO(Market market, List<Integer> boards) {
        this.boardNo = market.getBoardNo();
        this.textWriter = market.getTextWriter();
        this.updateDate = market.getUpdateDate();
        this.textTitle = market.getTextTitle();
        this.viewCount = market.getViewCount();

        this.isFavorite = 0;

        // favorite
        if (boards.contains(this.boardNo)) {
            this.isFavorite = 1;
        } else {
            this.isFavorite = 0;
        }

//        this.price = market.getPrice();
//        this.location = market.getLocation();
//        this.ContentImg = market.getContentImg();
//        this.loginMethod = market.getLoginMethod();

    }
}

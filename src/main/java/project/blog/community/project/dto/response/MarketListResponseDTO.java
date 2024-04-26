package project.blog.community.project.dto.response;


import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.multipart.MultipartFile;
import project.blog.community.project.entity.Favorite;
import project.blog.community.project.entity.Market;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Getter @ToString
@EqualsAndHashCode

public class
MarketListResponseDTO {

    private final int boardNo;
    private final String textWriter;
    private final String updateDate;
//    private LocalDateTime updateDate;
    private final String textTitle;
    private final int rate;
    private final int viewCount;
    private final String category;

    private int isFavorite;
    private final int price;
    private final String address;
    private final MultipartFile file;

//    private int price;
//    private String location;
//    private String ContentImg; //XML profile_image 스네이크 케이스 자동 인식
//    private String loginMethod; //sql tbl 타입과 일치 시켜야 함

    //DB -> DTO
    public MarketListResponseDTO(Market market, List<Integer> boards) {
        this.boardNo = market.getBoardNo();
        this.textWriter = market.getTextWriter();
        this.updateDate = makePrettierDateString(market.getUpdateDate());
        this.textTitle = market.getTextTitle();
        this.rate = market.getRate();
        this.viewCount = market.getViewCount();
        this.category = market.getCategory();
        this.price = market.getPrice();
        this.address = market.getAddress();
        this.file = market.getFile();
        this.isFavorite = 0;

        // favorite
        if (boards.contains(this.boardNo)) {
            this.isFavorite = 1;
        } else {
            this.isFavorite = 0;
        }

    }

    public static String makePrettierDateString(LocalDateTime updateDate) {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        return dtf.format(updateDate);//재가공
    }
//        this.price = market.getPrice();
//        this.location = market.getLocation();
//        this.ContentImg = market.getContentImg();
//        this.loginMethod = market.getLoginMethod();

}

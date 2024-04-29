package project.blog.community.project.dto.response;

import project.blog.community.project.entity.Market;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class MarketGetAddFavListResponseDTO {
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
    private final String file;


    public MarketGetAddFavListResponseDTO(Market market) {
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
        this.isFavorite = 1;

    }

    public static String makePrettierDateString(LocalDateTime updateDate) {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        return dtf.format(updateDate);//재가공
    }


}




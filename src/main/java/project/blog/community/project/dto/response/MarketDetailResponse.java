package project.blog.community.project.dto.response;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.ToString;
import project.blog.community.project.common.rate;
import project.blog.community.project.entity.Market;

import javax.management.loading.PrivateClassLoader;
import java.time.LocalDateTime;

@Getter
@ToString
@EqualsAndHashCode
public class MarketDetailResponse {
    private final int boardNo;
    private final String textTitle;
    private final String textContent;
    private final LocalDateTime updateDate;
    private final String textWriter;
    private final String category;
    private final int price;
    private final String address;

    private final String chooseReason;
    private final String message;
    private final int rate;
    private final String file;


    public MarketDetailResponse(Market market) {
        //entity -> DTO
        this.boardNo = market.getBoardNo();
        this.textTitle = market.getTextTitle();
        this.textContent = market.getTextContent();
        this.updateDate = market.getUpdateDate();
        this.textWriter = market.getTextWriter();
        this.category = market.getCategory();
        this.price = market.getPrice();
        this.address = market.getAddress();

        this.chooseReason = market.getChooseReason();
        this.message = market.getMessage();
        this.rate = market.getRate();
        this.file = market.getFile();
    }

}
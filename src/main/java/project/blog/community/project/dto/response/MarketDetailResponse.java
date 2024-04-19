package project.blog.community.project.dto.response;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.ToString;
import project.blog.community.project.entity.Market;

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



    public MarketDetailResponse(Market market) {
        //entity -> DTO

        this.boardNo = market.getBoardNo();
        this.textTitle = market.getTextTitle();
        this.textContent = market.getTextContent();
        this.updateDate = market.getUpdateDate();
        this.textWriter = market.getTextWriter();
    }

}
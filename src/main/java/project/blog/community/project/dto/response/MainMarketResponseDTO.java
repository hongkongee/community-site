package project.blog.community.project.dto.response;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.ToString;
import project.blog.community.project.entity.Market;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Getter
@ToString
@EqualsAndHashCode
public class MainMarketResponseDTO {

    private final String textWriter;
    private final String updateDate;
    private final String textTitle;
    private final int viewCount;
    private final int price;
    private final String address;

    public MainMarketResponseDTO(Market market) {
        this.textWriter = market.getTextWriter();
        this.updateDate = makePrettierDateString(market.getUpdateDate());
        this.textTitle = market.getTextTitle();
        this.viewCount = market.getViewCount();
        this.price = market.getPrice();
        this.address = market.getAddress();
    }

    // 날짜 포맷을 바꾸는 함수
    public static String makePrettierDateString(LocalDateTime regDate) {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy.MM.dd.");
        return dtf.format(regDate);
    }

}

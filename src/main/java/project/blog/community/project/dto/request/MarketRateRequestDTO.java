package project.blog.community.project.dto.request;

import lombok.*;

import java.util.List;

@Getter
@Setter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MarketRateRequestDTO {

    private int boardNo;
    private String textWriter;
    private String message;
    private String chooseReason;
    private int rateValue;




}

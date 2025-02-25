package project.blog.community.project.entity;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;
import project.blog.community.project.common.PageMaker;
import project.blog.community.project.dto.request.MarketWriteRequestDTO;
import project.blog.community.project.dto.response.MarketDetailResponse;

import java.time.LocalDateTime;
import java.util.List;

/*
CREATE TABLE tbl_market (
    board_no INT PRIMARY KEY AUTO_INCREMENT,
    text_writer VARCHAR(255) NOT NULL,
	update_date datetime DEFAULT current_timestamp,
	text_title VARCHAR(50),
    rate LONG DEFAULT(5.0),
    text_content VARCHAR(1000),
    price INT,
    location VARCHAR(255),
    content_img VARCHAR(255),
    login_method VARCHAR(50),
    view_count INT DEFAULT 0,
    favorite BOOLEAN DEFAULT FALSE
);
*/

@Setter
@Getter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Market {

    private int boardNo;

    private String textWriter;

    private LocalDateTime updateDate;

    private String textTitle;

    private int rate;

    //@Setter //원하는 필드에만 Setter 생성
    private String textContent;

    private int price;

    //private String location;
    private String address;

    private String ContentImg; //XML profile_image 스네이크 케이스 자동 인식
    //private String loginMethod; //sql tbl 타입과 일치 시켜야 함
    private int viewCount;
    private boolean addFav;
    private String category;
    private String chooseReason;
    private String message;
    private String file;

    private int count;
    private PageMaker pageInfo;
    private List<MarketDetailResponse> marketList;





    public Market(MarketWriteRequestDTO dto, String file, String writer) {
        //dto -> Entity
        this.textTitle = dto.getTextTitle();
        this.textContent = dto.getTextContent();
        this.updateDate = dto.getUpdateDate();
        this.viewCount = dto.getViewCount();
        this.category = dto.getCategory();
        this.price = dto.getPrice();
        this.address = dto.getAddress();
        this.file = file;
        this.textWriter = writer;

        //        this.rate = rate;
    }


}















































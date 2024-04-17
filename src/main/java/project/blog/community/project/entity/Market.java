package project.blog.community.project.entity;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder


public class Market{

    @Setter
    private int boardNo;

    private String textWriter;

    private LocalDateTime updateDate;

    private String textTitle;

    private int rate;

    @Setter //원하는 필드에만 Setter 생성
    private String textContent;

    private int price;

    private String location;

    private String ContentImg; //XML profile_image 스네이크 케이스 자동 인식
    private String loginMethod; //sql tbl 타입과 일치 시켜야 함




}














































package project.blog.community.project.dto.response;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.ToString;
import project.blog.community.project.entity.MyCode;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Getter @ToString @EqualsAndHashCode
public class MyCodeListResponseDTO {

    private final int codeNo;
    private final String shortTitle;
    private final String shortContent;
    private final String regDate;
    private final String writer;
    private final String programming;
    
public MyCodeListResponseDTO(MyCode myCode) {
    this.codeNo = myCode.getCodeNo();
    this.shortTitle = (myCode.getTitle() != null) ? makeShortTitle(myCode.getTitle()) : null;
    //makeShortContent(myCode.getContent());
    this.shortContent = (myCode.getContent() != null) ? makeShortContent(myCode.getContent()) : null;
    this.regDate = makePrettierDateString(myCode.getRegDate());
    this.writer = myCode.getWriter();
    this.programming = myCode.getProgramming();
}

    public static String makePrettierDateString(LocalDateTime regDate) {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        return dtf.format(regDate);
    }
    private String makeShortContent(String content) {
        return sliceString(content, 30);
    }
   private String makeShortTitle(String title) {
        return sliceString(title,5);
    }


    private static String sliceString(String targetString, int wishLength) {
        return (targetString.length() > wishLength)
                ? targetString.substring(0, wishLength) + "..."
                : targetString
                ;
    }



}

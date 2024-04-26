package project.blog.community.project.dto.request;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;

@Setter @Getter @ToString
@EqualsAndHashCode
@NoArgsConstructor

public class MarketWriteRequestDTO {
    private String textTitle;
    private String textContent;
    private LocalDateTime updateDate;
    private int viewCount;
    private String category;
    private int price;
    private String address;
    private MultipartFile file;

}


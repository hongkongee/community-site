package project.blog.community.project.dto.response;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.*;
import project.blog.community.project.entity.Diary;

import java.time.LocalDate;

@Getter
@Setter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DiaryDetailResponseDTO {

    private int diaryNo;
    private String toDo;
    private String whatDo;
    private String writer;

    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate regDate;


    // 엔티티 변환
    public DiaryDetailResponseDTO(Diary diary) {
        this.diaryNo = diary.getDiaryNo();
        this.regDate = diary.getRegDate();
        this.writer = diary.getWriter();
        this.toDo = diary.getToDo();
        this.whatDo = diary.getWhatDo();
    }



}

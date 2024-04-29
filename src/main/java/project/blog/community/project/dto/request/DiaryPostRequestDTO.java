package project.blog.community.project.dto.request;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;
import project.blog.community.project.entity.Diary;

import java.time.LocalDate;

@Setter @Getter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DiaryPostRequestDTO {



    @Size(min = 1, max = 20)
    private String todoText;

    @Size(min = 5, max = 200)
    private String whatdoText;

    @NotNull
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate regDate;


    public Diary toEntity() {
        return Diary.builder()
                .toDo(this.todoText)
                .whatDo(this.whatdoText)
                .regDate(this.regDate)
                .build();
    }

}

package project.blog.community.project.dto.response;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;
import project.blog.community.project.dto.request.DiaryPostRequestDTO;
import project.blog.community.project.entity.Diary;

import java.time.LocalDate;
import java.util.List;

@Setter
@Getter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DiaryListResponseDTO {


    private List<DiaryDetailResponseDTO> todos;
    private List<DiaryPostRequestDTO> whatdos;



}

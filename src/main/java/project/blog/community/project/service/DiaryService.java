package project.blog.community.project.service;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import project.blog.community.project.dto.request.DiaryPostRequestDTO;
import project.blog.community.project.dto.response.DiaryDetailResponseDTO;
import project.blog.community.project.dto.response.DiaryListResponseDTO;
import project.blog.community.project.dto.response.LoginUserResponseDTO;
import project.blog.community.project.entity.Diary;
import project.blog.community.project.mapper.DiaryMapper;

import java.util.ArrayList;
import java.util.List;

import static project.blog.community.util.LoginUtils.getCurrentLoginMemberAccount;

@Service
@RequiredArgsConstructor
@Slf4j
public class DiaryService {

    private final DiaryMapper diaryMapper;

    public void registerTodo(DiaryPostRequestDTO dto, HttpSession session) {

        Diary diary = dto.toEntity();
        diary.setWriter(getCurrentLoginMemberAccount(session));

        diaryMapper.todoSave(diary);
    }


    public void registerWhatdo(DiaryPostRequestDTO dto, HttpSession session) {

        Diary diary = dto.toEntity();
        diary.setWriter(getCurrentLoginMemberAccount(session));

        diaryMapper.whatdoSave(diary);

    }

    public List<DiaryDetailResponseDTO> getTodoList(String regDate, HttpSession session) {
        List<DiaryDetailResponseDTO> dtoList = new ArrayList<>();
        LoginUserResponseDTO loginDto = (LoginUserResponseDTO) session.getAttribute("login");
        String myAccount = loginDto.getAccountNumber();

        List<Diary> todoList = diaryMapper.findTodoList(regDate, myAccount);
        for (Diary diary : todoList) {
            dtoList.add(new DiaryDetailResponseDTO(diary));
        }
        log.info("diaryList: {}", todoList);

        return dtoList;
    }

    public List<DiaryDetailResponseDTO> getWhatdoList(String regDate) {
        List<DiaryDetailResponseDTO> dtoList = new ArrayList<>();

        List<Diary> whatdoList = diaryMapper.findWhatdoList(regDate);
        for (Diary diary : whatdoList) {
            dtoList.add(new DiaryDetailResponseDTO(diary));
        }
        log.info("diaryList: {}", whatdoList);

        return dtoList;
    }




}


































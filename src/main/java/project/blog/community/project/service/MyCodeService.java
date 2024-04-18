package project.blog.community.project.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import project.blog.community.project.common.MyCodePage;
import project.blog.community.project.dto.request.MyCodeWriteRequestDTO;
import project.blog.community.project.dto.response.MyCodeListResponseDTO;
import project.blog.community.project.entity.MyCode;
import project.blog.community.project.mapper.MyCodeMapper;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class MyCodeService {
    private final MyCodeMapper mapper;


    public void register(MyCodeWriteRequestDTO dto) {
        MyCode myCode = new MyCode(dto);
        mapper.save(myCode);
    }

    public List<MyCodeListResponseDTO> getList(MyCodePage page) {
        List<MyCodeListResponseDTO> dtoList = new ArrayList<>();
        //List<MyCode> galleryList = mapper.findAll(page);
        List<MyCode> myCodeList = mapper.findAll(page);
        for (MyCode myCode : myCodeList) {
            MyCodeListResponseDTO dto = new MyCodeListResponseDTO(myCode);
            dtoList.add(dto);
        }
        return dtoList;
    }

    public void delete(int bno) {
        mapper.delete(bno);
    }

    public int getCount() {
        return mapper.getCount();

    }
}

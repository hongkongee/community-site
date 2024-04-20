package project.blog.community.project.service;

import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import project.blog.community.project.common.MyCodePage;
import project.blog.community.project.dto.request.MyCodeWriteRequestDTO;
import project.blog.community.project.dto.response.MyCodeDetailResponseDTO;
import project.blog.community.project.dto.response.MyCodeListResponseDTO;
import project.blog.community.project.entity.MyCode;
import project.blog.community.project.mapper.MyCodeMapper;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class MyCodeService {
    private static final Logger log = LoggerFactory.getLogger(MyCodeService.class);
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
public List<MyCodeListResponseDTO> endgetList(MyCodePage page){
        List<MyCodeListResponseDTO> mylist = new ArrayList<>();
        List<MyCode> endlist = mapper.endAll(page);
    for (MyCode myCode : endlist) {
        MyCodeListResponseDTO dto = new MyCodeListResponseDTO(myCode);
        mylist.add(dto);

    }
    return mylist;
}


    public void delete(int bno) {
        mapper.delete(bno);
    }

    public int getCount() {
        return mapper.getCount();

    }

    public MyCodeDetailResponseDTO getDetail(int bno) {
        log.info("detail GET!");
        log.info(String.valueOf(bno));
        MyCode myCode = mapper.findOne(bno);

        return new MyCodeDetailResponseDTO(myCode);
    }
}

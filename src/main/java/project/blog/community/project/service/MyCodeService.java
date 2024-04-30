package project.blog.community.project.service;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import project.blog.community.project.common.CodeSearch;
import project.blog.community.project.common.MyCodePage;
import project.blog.community.project.dto.request.MyCodeWriteRequestDTO;
import project.blog.community.project.dto.response.LoginUserResponseDTO;
import project.blog.community.project.dto.response.MyCodeDetailResponseDTO;
import project.blog.community.project.dto.response.MyCodeListResponseDTO;
import project.blog.community.project.entity.MyCode;
import project.blog.community.project.mapper.MyCodeMapper;
import project.blog.community.util.LoginUtils;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class MyCodeService {
    private static final Logger log = LoggerFactory.getLogger(MyCodeService.class);
    private final MyCodeMapper mapper;


    public void register(MyCodeWriteRequestDTO dto, HttpSession session) {
        MyCode myCode = new MyCode(dto);
        myCode.setWriter(LoginUtils.getCurrentLoginMemberAccount(session));
        mapper.save(myCode);
    }

    public List<MyCodeListResponseDTO> getList(CodeSearch page, HttpSession session) {
        List<MyCodeListResponseDTO> dtoList = new ArrayList<>();
        //List<MyCode> galleryList = mapper.findAll(page);

        LoginUserResponseDTO loginDto = (LoginUserResponseDTO) session.getAttribute("login");
        String myAccount = loginDto.getAccountNumber();

        List<MyCode> myCodeList = mapper.findAll(page, myAccount);
        log.info("myCodeList: {}", myCodeList);
        for (MyCode myCode : myCodeList) {
            MyCodeListResponseDTO dto = new MyCodeListResponseDTO(myCode);

            dtoList.add(dto);
        }
        return dtoList;
    }
public List<MyCodeListResponseDTO> endgetList(MyCodePage page, HttpSession session){

    LoginUserResponseDTO loginDto = (LoginUserResponseDTO) session.getAttribute("login");
    String myAccount = loginDto.getAccountNumber();

        List<MyCodeListResponseDTO> mylist = new ArrayList<>();
        List<MyCode> endlist = mapper.endAll(page, myAccount);
    for (MyCode myCode : endlist) {
        MyCodeListResponseDTO dto = new MyCodeListResponseDTO(myCode);
        mylist.add(dto);

    }
    return mylist;
}


    public void delete(int bno) {
        mapper.delete(bno);
    }

    public void update(MyCodeWriteRequestDTO dto){
        MyCode myCode = new MyCode(dto);
        mapper.update(myCode);
    }



    public int getCount(CodeSearch page, HttpSession session) {
        LoginUserResponseDTO loginDto = (LoginUserResponseDTO) session.getAttribute("login");
        String myAccount = loginDto.getAccountNumber();

        return mapper.getCount(page, myAccount);

    }

    public MyCodeDetailResponseDTO getDetail(int bno) {
        log.info("detail GET!");
        log.info(String.valueOf(bno));
        MyCode myCode = mapper.findOne(bno);

        return new MyCodeDetailResponseDTO(myCode);
    }



}

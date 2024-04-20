package project.blog.community.project.controller;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import project.blog.community.project.common.CodeSearch;
import project.blog.community.project.common.MyCodePage;
import project.blog.community.project.common.MyCodeMaker;
import project.blog.community.project.dto.request.MyCodeWriteRequestDTO;
import project.blog.community.project.dto.response.MyCodeDetailResponseDTO;
import project.blog.community.project.dto.response.MyCodeListResponseDTO;
import project.blog.community.project.service.MyCodeService;

import java.util.List;
//CREATE TABLE my_code(
//	code_no INT PRIMARY KEY AUTO_INCREMENT,
//    title VARCHAR(100) NOT NULL,
//    content VARCHAR(2000),
//    reg_date DATETIME DEFAULT current_timestamp,
//	writer VARCHAR(50)
//
//);
@Controller
@RequiredArgsConstructor
@RequestMapping("/wel")
@Slf4j
public class MyCodeController {

    private final MyCodeService service;
@GetMapping("/myCode")
public String gallery(Model model, MyCodePage page){
    log.info("page: {}", page);
    List<MyCodeListResponseDTO> dtoList = service.getList(page);


    MyCodeMaker myCodeMaker = new MyCodeMaker(page, service.getCount());

    model.addAttribute("gList", dtoList);
    model.addAttribute("maker", myCodeMaker);
    return "mycode";
}
@GetMapping("/endMyCode")
public String endCode(Model model, MyCodePage page){
   List<MyCodeListResponseDTO> endList = service.endgetList(page);
    MyCodeMaker myCodeMaker = new MyCodeMaker(page, service.getCount());
    model.addAttribute("gList",endList);
    model.addAttribute("maker",myCodeMaker);
    return "mycode";
}

@PostMapping("/write")
public String write(MyCodeWriteRequestDTO dto){
    System.out.println("write post get");
    System.out.println("dto = {}" + dto);

    service.register(dto);
    return "redirect:/wel/myCode";
}



@GetMapping("/write")
    public String write(){




    return "mycodewrite";
}
    @GetMapping("/codedelete")
        public String delete(int bno){
        log.info("codedelete: GET!!");
        service.delete(bno);

        return "redirect:/wel/myCode";

}
    @GetMapping("/codedetail")
    public String detail(int bno,Model model) {
        log.info("detail get!!");


        MyCodeDetailResponseDTO dto = service.getDetail(bno);
        log.info("dto: {}", dto);

        model.addAttribute("b",dto);
        return "codedetail";
    }


}




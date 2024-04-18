package project.blog.community.project.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import project.blog.community.project.common.MyCodePage;
import project.blog.community.project.common.MyCodeMaker;
import project.blog.community.project.dto.request.MyCodeWriteRequestDTO;
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
    return "myCode";
}
@PostMapping("write")
public String write(MyCodeWriteRequestDTO dto){
    System.out.println("write post get");
    System.out.println("dto = {}" + dto);

    service.register(dto);
    return "redirect:/wel/mycode";
}



@GetMapping("/write")
    public String write(){




    return "mycodewrite";
}
@GetMapping("/delete")
    public String delete(int bno){

    service.delete(bno);

    return "redirect:/wel/mycode";

}

}




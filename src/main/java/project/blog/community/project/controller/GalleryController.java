package project.blog.community.project.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import project.blog.community.project.dto.request.GalleryWriteRequestDTO;
import project.blog.community.project.dto.response.GalleryListResponseDTO;
import project.blog.community.project.entity.Gallery;
import project.blog.community.project.mapper.GalleryMapper;
import project.blog.community.project.service.GalleryService;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/wel")
@Slf4j
public class GalleryController {

    private final GalleryService service;
@GetMapping("/gallery")
public String gallery(Model model){
    List<GalleryListResponseDTO> dtoList = service.getList();
    model.addAttribute("gList", dtoList);
    return "gallery";
}
@PostMapping("write")
public String write(GalleryWriteRequestDTO dto){
    System.out.println("write post get");
    System.out.println("dto = " + dto);

    service.register(dto);
    return "redirect:/wel/gallery";
}



@GetMapping("/write")
    public String write(){




    return "gallerywrite";
}

}

package project.blog.community.project.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import project.blog.community.project.dto.request.GalleryWriteRequestDTO;
import project.blog.community.project.dto.response.GalleryListResponseDTO;
import project.blog.community.project.entity.Gallery;
import project.blog.community.project.repository.GalleryRepository;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class GalleryService {
    private final GalleryRepository repository;



    public void register(GalleryWriteRequestDTO dto) {
        Gallery gallery = new Gallery(dto);
        repository.save(gallery);
    }

    public List<GalleryListResponseDTO> getList() {
        List<GalleryListResponseDTO> dtoList = new ArrayList<>();
        List<Gallery> galleryList = repository.findAll();
        for (Gallery gallery : galleryList) {
            GalleryListResponseDTO dto = new GalleryListResponseDTO(gallery);
       dtoList.add(dto);
        }
        return dtoList;
    }
}

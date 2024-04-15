package project.blog.community.project.repository;

import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import project.blog.community.project.entity.Gallery;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class GalleryRepositoryImpl implements GalleryRepository{

    protected final JdbcTemplate template;

    @Override
    public List<Gallery> findAll() {
        return null;
    }

    @Override
    public Gallery findOne(int galleryNo) {
        return null;
    }

    @Override
    public void save(Gallery gallery) {

    }

    @Override
    public void delete(int photoNumber) {

    }
}

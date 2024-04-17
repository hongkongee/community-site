package project.blog.community.project.repository;

import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import project.blog.community.project.entity.Gallery;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class GalleryRepositoryImpl implements GalleryRepository {

    protected final JdbcTemplate template;

    class GalleryMapper implements RowMapper<Gallery>{

        @Override
        public Gallery mapRow(ResultSet rs, int rowNum) throws SQLException {
            Gallery gallery = new Gallery(
            rs.getInt("photo_number"),
                    rs.getString("title") ,
            rs.getTimestamp("reg_date").toLocalDateTime(),
                    rs.getString("photo_link"),
                    rs.getString("user_name")

            );



            return gallery;
        }
    }
    @Override
    public List<Gallery> findAll() {
        String sql ="SELECT * FROM gallery ORDER BY photo_number DESC";
        return template.query(sql,new GalleryMapper());
    }

    @Override
    public Gallery findOne(int galleryNo) {
        return null;
    }

    @Override
    public void save(Gallery gallery) {
        String sql = "INSERT INTO gallery (title, photo_link, user_name )" +
                "VALUES (?, ?, ?)";
        template.update(sql, gallery.getTitle(), gallery.getPhotoLink(),gallery.getUser() );
    }

    @Override
    public void delete(int photoNumber) {

    }
}

package project.blog.community.project.repository;

import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import project.blog.community.project.common.MyCodePage;
import project.blog.community.project.entity.MyCode;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class MyCodeRepositoryImpl implements MyCodeRepository {

    protected final JdbcTemplate template;
//CREATE TABLE my_code(
//	code_no INT PRIMARY KEY AUTO_INCREMENT,
//    title VARCHAR(100) NOT NULL,
//    content VARCHAR(2000),
//    reg_date DATETIME DEFAULT current_timestamp,
//	writer VARCHAR(50)
//
//);
    class GalleryMapper implements RowMapper<MyCode>{

        @Override
        public MyCode mapRow(ResultSet rs, int rowNum) throws SQLException {
            MyCode myCode = new MyCode(
            rs.getInt("code_no"),
                    rs.getString("title") ,
                    rs.getString("content"),
                    rs.getTimestamp("reg_date").toLocalDateTime(),
                    rs.getString("writer")

            );



            return myCode;
        }
    }
    @Override
    public List<MyCode> findAll(MyCodePage page) {
        String sql ="SELECT * FROM gallery ORDER BY code_no DESC LIMIT ?, ?";
        return template.query(sql, new Object[]{page.getPageStart(), page.getAmount()}, new GalleryMapper());
    }

    @Override
    public MyCode findOne(int galleryNo) {
        return null;
    }

    @Override
    public void save(MyCode gallery) {
        String sql = "INSERT INTO gallery (title, content, writer )" +
                "VALUES (?, ?, ?)";
        template.update(sql, gallery.getTitle(), gallery.getContent(),gallery.getWriter() );
    }

    @Override
    public void delete(int photoNumber) {
String sql = "DELETE FROM gallery WHERE photo_number=?";
    template.update(sql, photoNumber);
    }
}

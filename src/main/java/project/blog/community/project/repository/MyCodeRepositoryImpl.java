package project.blog.community.project.repository;

import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import project.blog.community.project.common.MyCodePage;
import project.blog.community.project.entity.MyCode;
import project.blog.community.project.mapper.MyCodeMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class MyCodeRepositoryImpl implements MyCodeRepository {

//CREATE TABLE my_code(
//	code_no INT PRIMARY KEY AUTO_INCREMENT,
//    title VARCHAR(100) NOT NULL,
//    content VARCHAR(2000),
//    reg_date DATETIME DEFAULT current_timestamp,
//	writer VARCHAR(50)
//
//);
    class MyCodeMapper implements RowMapper<MyCode>{

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
    protected final JdbcTemplate template;

    @Override
    public List<MyCode> findAll(MyCodePage page) {
        String sql ="SELECT * FROM my_code ORDER BY code_no DESC LIMIT ?, ?";
        return template.query(sql, new Object[]{page.getPageStart(), page.getAmount()}, new MyCodeMapper());
    }

    @Override
    public MyCode findOne(int codeNo) {
        String sql = "SELECT * FROM my_code WHERE code_no=?";
        try {
            return template.queryForObject(sql, new Object[]{codeNo}, new MyCodeMapper());
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public void save(MyCode myCode) {
        String sql = "INSERT INTO my_code (title, content, writer )" +
                "VALUES (?, ?, ?)";
        template.update(sql, myCode.getTitle(), myCode.getContent(),myCode.getWriter() );
    }

    @Override
    public void delete(int codeNo) {
        String sql = "DELETE FROM my_code WHERE code_no=?";
        template.update(sql, codeNo);
    }
}

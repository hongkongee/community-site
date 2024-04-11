package project.blog.community.project.repository;

import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@Repository
public class JdbcRepository {

   // DB 연결 설정 정보 (세팅)

   private String url = "jdbc:mysql://localhost:3306/community_db?serverTimezone=Asia/Seoul"; // DB URL 주소
   private String username = "community"; // 계정명
   private String password = "community"; // 비밀번호

   // JDBC 드라이버 로딩
   public JdbcRepository() {
      try {
         Class.forName("com.mysql.cj.jdbc.Driver");
      } catch (ClassNotFoundException e) {
         e.printStackTrace();
      }
   }

   // 데이터베이스 커넥션 얻기
   public Connection getConnection() throws SQLException {
      // 데이터 전달해서 DB 접속을 전담하는 Connection을 받아오기
      return DriverManager.getConnection(url, username, password);
   }




}













































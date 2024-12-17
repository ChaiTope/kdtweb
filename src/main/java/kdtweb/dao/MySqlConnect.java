package kdtweb.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MySqlConnect {
   private String url = "jdbc:mysql://localhost:3306/kdtweb";
   private String options = "serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";
   private String userid = "root";
   private String userpass = "5094";
   
   //Connection 객체 반환하는 메서드
   public Connection getConn() throws SQLException, ClassNotFoundException {
	   Class.forName("com.mysql.cj.jdbc.Driver");
	   Connection conn = DriverManager.getConnection(this.url + "?" + this.options, this.userid, this.userpass);
	   return conn;
   }
}

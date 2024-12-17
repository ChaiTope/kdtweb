package kdtweb.dao;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class KdtwebDao {
   private DataSource dataSource;
   //생성자
   public KdtwebDao() {
	   try {
		   Context initContext = new InitialContext();
		   Context cnt = (Context) initContext.lookup("java:comp/env");
		   this.dataSource = (DataSource) cnt.lookup("jdbc/kdtwebDB");
	   }catch(Exception e) {
		   e.printStackTrace();
	   }
   }
   
   public Connection getConn() throws SQLException {
	   System.out.println("db연결 성공");
	   return dataSource.getConnection();
   }
}

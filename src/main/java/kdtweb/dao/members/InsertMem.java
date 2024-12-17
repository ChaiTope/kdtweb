package kdtweb.dao.members;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kdtweb.beans.User;
import kdtweb.dao.KdtwebDao;

public class InsertMem {
   //필드로 접속객체를 생성	
   private KdtwebDao dao = new KdtwebDao();
   private CloseResource reso = new CloseResource();
   private Connection conn = null;
   private PreparedStatement pstmt = null;
   
   public int insertMember(User user) throws SQLException {
	   	   
	   int rs = 0;
	   
	   String sql = "insert into members (userid, userpass, username, useremail, usertel, userpost, useraddr1, useraddr2, useraddrexc)"
  		     + " values (?,?,?,?,?,?,?,?,?)";
	   try {
		   
		   conn = this.dao.getConn();
		   pstmt = conn.prepareStatement(sql);
		   pstmt.setString(1, user.getUserid());
		   pstmt.setString(2, user.getUserpass());
		   pstmt.setString(3, user.getUsername());
		   pstmt.setString(4, user.getUseremail());
		   pstmt.setString(5, user.getUsertel());
		   pstmt.setInt(6, user.getUserpost());
		   pstmt.setString(7, user.getUseraddr1());
		   pstmt.setString(8, user.getUseraddr2());
		   pstmt.setString(9, user.getUseraddrexc());
		   
		   rs = pstmt.executeUpdate();
		   
	   }catch(SQLException e) {
		   e.printStackTrace();
	   }finally {
		   reso.closeResource(conn, pstmt);
	   }
	   return rs;
   }
}

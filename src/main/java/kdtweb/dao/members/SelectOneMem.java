package kdtweb.dao.members;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kdtweb.beans.User;
import kdtweb.dao.KdtwebDao;

public class SelectOneMem {
	   //필드로 접속객체를 생성	
	   private KdtwebDao dao = new KdtwebDao();
	   private CloseResource reso = new CloseResource();
	   private Connection conn = null;
	   private PreparedStatement pstmt = null;
	   private ResultSet rs = null;

	   public User selectOneMem(String userid) throws SQLException{
		   User user = null;
		   String sql = "select * from members where userid=?";
		   try {
			   conn = dao.getConn();
			   pstmt = conn.prepareStatement(sql);
			   pstmt.setString(1, userid);
			   rs = pstmt.executeQuery();
			   
			   if(rs.next()) {
				   user = new User();
				   user.setId(rs.getInt("id"));
				   user.setUserid(userid);
				   user.setUsername(rs.getString("username"));
				   user.setUseremail(rs.getString("useremail"));
				   user.setUsertel(rs.getString("usertel"));
				   user.setUserpost(rs.getInt("userpost"));
				   user.setUseraddr1(rs.getString("useraddr1"));
				   user.setUseraddr2(rs.getString("useraddr1"));
				   user.setUseraddrexc(rs.getString("useraddrexc"));
				   user.setRdate(rs.getTimestamp("rdate"));
				   user.setGrade(rs.getInt("grade"));
			   }
			   
		   }catch(SQLException e) {
			   e.printStackTrace();
		   }finally {
			   reso.closeResource(conn, pstmt, rs);
		   }
		   return user;   
	   }
	   
	   public int selectOneMem(String userid, String userpass) throws SQLException{
		   int res = 0;
		   String sql = "select * from members where userid=? and userpass=?";
		   try {
			   conn = this.dao.getConn();
			   pstmt = conn.prepareStatement(sql);
			   pstmt.setString(1, userid);
			   pstmt.setString(2, userpass);
			   rs = pstmt.executeQuery();
		   
			   if(rs.next()) {
                 res = 1;
			   }
			   
		   }catch(SQLException e) {
			   e.printStackTrace();
		   }finally {
			   reso.closeResource(conn, pstmt, rs);
		   }
		   
		   return res;     
	   }
}

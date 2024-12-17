package kdtweb.dao.members;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kdtweb.beans.User;
import kdtweb.dao.KdtwebDao;

public class UpdateMem {
	   //필드로 접속객체를 생성	
	   private KdtwebDao dao = new KdtwebDao();
	   private CloseResource reso = new CloseResource();
	   private Connection conn = null;
	   private PreparedStatement pstmt = null;
	
	   public int updateMember(User user) throws SQLException{
		   int rs = 0;
		   String sql = "UPDATE members SET userpass=?, username=?, useremail=?, usertel=?"
				       +", userpost=?, useraddr1=?, useraddr2=?, useraddrexc=?"
				       +" where userid=?";
		   try {
			   
			   conn = this.dao.getConn();
			   pstmt = conn.prepareStatement(sql);
			   
			   pstmt = conn.prepareStatement(sql);
		
			   pstmt.setString(1, user.getUserpass());
			   pstmt.setString(2, user.getUsername());
			   pstmt.setString(3, user.getUseremail());
			   pstmt.setString(4, user.getUsertel());
			   pstmt.setInt(5, user.getUserpost());
			   pstmt.setString(6, user.getUseraddr1());
			   pstmt.setString(7, user.getUseraddr2());
			   pstmt.setString(8, user.getUseraddrexc());
			   pstmt.setString(9, user.getUserid());
			   
			   rs = pstmt.executeUpdate();
			   
		   }catch(SQLException e) {
			   e.printStackTrace();
		   }finally {
			   reso.closeResource(conn, pstmt);
		   }
		    
		   return rs;
	   }
	   
	   public int adminMemEdit(int id, int grade) {
		   int rs = 0;
		   String sql = "UPDATE members SET grade=? where id = ?";
		   try {
			   conn = this.dao.getConn();
			   pstmt = conn.prepareStatement(sql);
			   pstmt.setInt(1, grade);
			   pstmt.setInt(2, id);
			   rs = pstmt.executeUpdate();
			   
		   }catch(SQLException e) {
			   e.printStackTrace();
		   }finally {
			   reso.closeResource(conn, pstmt);
		   }
		   
		   return rs;		   
	   }
}

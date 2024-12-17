package kdtweb.dao.members;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kdtweb.beans.User;
import kdtweb.dao.KdtwebDao;

public class DeleteMem {
	   //필드로 접속객체를 생성	
	   private KdtwebDao dao = new KdtwebDao();
	   private CloseResource reso = new CloseResource();
	   private Connection conn = null;
	   private PreparedStatement pstmt = null;
	   private ResultSet rs = null;
	
	   public int deleteMem(String userid) throws SQLException {
		   
		   int res = 0;
		   String sql = "delete from members where userid=?";
		   try {
			   
			   conn = dao.getConn();
			   pstmt = conn.prepareStatement(sql);
			   pstmt.setString(1, userid);
			   res = pstmt.executeUpdate();
			   
		   }catch(SQLException e) {
			   e.printStackTrace();
		   }finally {
			   reso.closeResource(conn, pstmt);
		   }
		   
		   return res;
	   }
	   
	   
	   public int deleteMem(int id) throws SQLException {
		   
		   int res = 0;
		   String sql = "delete from members where id=?";
		   try {
			   
			   conn = dao.getConn();
			   pstmt = conn.prepareStatement(sql);
			   pstmt.setInt(1, id);
			   res = pstmt.executeUpdate();
			   
		   }catch(SQLException e) {
			   e.printStackTrace();
		   }finally {
			   reso.closeResource(conn, pstmt);
		   }
		   
		   return res;
	   }
}

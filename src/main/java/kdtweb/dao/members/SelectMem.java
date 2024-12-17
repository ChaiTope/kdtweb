package kdtweb.dao.members;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import kdtweb.beans.User;
import kdtweb.dao.KdtwebDao;

public class SelectMem {
	   //필드로 접속객체를 생성	
	   private KdtwebDao dao = new KdtwebDao();
	   private CloseResource reso = new CloseResource();
	   private Connection conn = null;
	   private PreparedStatement pstmt = null;
	   private Statement st = null;
	   private ResultSet rs = null;
	   private User user = new User();
	   
	   public List<User> selectMem() throws SQLException {
		   List<User> userList = new ArrayList<>();
		   String sql = "select * from members order by id desc";
		   try {
			   conn = dao.getConn();
			   st = conn.createStatement();
			   rs = st.executeQuery(sql);
			   while(rs.next()) {
				  User user = new User();
				   user.setId(rs.getInt("id"));
				   user.setUserid(rs.getString("userid"));
				   user.setUsername(rs.getString("username"));
				   user.setUseremail(rs.getString("useremail"));
				   user.setUsertel(rs.getString("usertel"));
				   user.setUserpost(rs.getInt("userpost"));
				   user.setUseraddr1(rs.getString("useraddr1"));
				   user.setUseraddr2(rs.getString("useraddr1"));
				   user.setUseraddrexc(rs.getString("useraddrexc"));
				   user.setRdate(rs.getTimestamp("rdate"));
				   user.setGrade(rs.getInt("grade"));
				   userList.add(user);
			   }
		   }catch(SQLException e) {
			   e.printStackTrace();
		   }finally {
			   reso.closeResource(conn, pstmt, rs);
		   }
	
		   return userList;
	   }
}

package kdtweb.dao.members;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CloseResource {
   public void closeResource(Connection conn, PreparedStatement pstmt) {
	 if(conn != null) {
		 try{
		    conn.close();
	     }catch(SQLException e) {	 
   	     }
	 } 
	 if(pstmt != null) {
		 try{
			 pstmt.close();
		 }catch(SQLException e) {
			 
		 }
	  } 
   }
   public void closeResource(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		 if(conn != null) {
			 try{
			    conn.close();
		     }catch(SQLException e) {	 
	   	     }
		 } 
		 if(pstmt != null) {
			 try{
				 pstmt.close();
			 }catch(SQLException e) {
				 
			 }
		  }
		 if(rs != null) {
			 try {
				 rs.close();
			 }catch(SQLException e) {}
		 }
   }
}

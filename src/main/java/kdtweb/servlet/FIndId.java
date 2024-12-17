package kdtweb.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kdtweb.dao.MySqlConnect;


@WebServlet("/findid")
public class FIndId extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		PrintWriter out = response.getWriter();
		int count = 0;
		MySqlConnect dbCon = new MySqlConnect();
		String findId = request.getParameter("userid");
		try {
			conn = dbCon.getConn();
			String sql = "select count(*) from members where userid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, findId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
	           count = rs.getInt(1);
	           if(count > 0 || findId.equals("admin")) {
	        	   out.print("false");
	           }else {
	        	   out.print("true");
	           }
			}
		}catch(SQLException | ClassNotFoundException e) {
			System.out.println("db 접속 에러" + e.getMessage());
		}finally {
			if(rs != null) try {rs.close();}catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {}
			if(conn != null) try {conn.close();}catch(SQLException e) {}
		}
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

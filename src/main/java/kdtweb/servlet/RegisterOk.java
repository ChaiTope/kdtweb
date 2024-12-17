package kdtweb.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kdtweb.dao.MySqlConnect;

@WebServlet("/registerok")
public class RegisterOk extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		res.setContentType("text/html;charset=utf-8");
		req.setCharacterEncoding("UTF-8");
		PrintWriter out = res.getWriter();
		int postcode = 0;
		
		String userid = req.getParameter("userid");
		String userpass = req.getParameter("userpass");
		String username = req.getParameter("username");
		String email = req.getParameter("email");
		String tel = req.getParameter("tel");
		
		String userpost = req.getParameter("postcode");
		if(userpost != null && !userpost.isEmpty()) {
			try{
				postcode = Integer.parseInt(userpost);
			}catch(NumberFormatException e) {
				postcode = 0;
			}
		}
		
		String useraddr1 = req.getParameter("useraddr1");
		String useraddr2 = req.getParameter("useraddr2");
		String useraddrexc = req.getParameter("useraddrexc");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		MySqlConnect dbcon = new MySqlConnect();
		try {
			conn = dbcon.getConn();
			System.out.println("db 접속 성공");
			
		    String sql = "insert into members (userid, userpass, username, useremail, usertel, userpost, useraddr1, useraddr2, useraddrexc)"
		    		     + " values (?,?,?,?,?,?,?,?,?)";
			
		    pstmt =  conn.prepareStatement(sql);
		    pstmt.setString(1, userid);
		    pstmt.setString(2, userpass);
		    pstmt.setString(3, username);
		    pstmt.setString(4, email);
		    pstmt.setString(5, tel);
		    pstmt.setInt(6, postcode);
		    pstmt.setString(7, useraddr1);
		    pstmt.setString(8, useraddr2);
		    pstmt.setString(9, useraddrexc);

		    pstmt.executeUpdate();
		    //select 일 경우 pstmt.executeQuery();
		    // System.out.println(pstmt);

		    HttpSession session = req.getSession();
		    session.setAttribute("userid", userid);
		    //res.sendRedirect("index.jsp");
		    String query = "<script>alert('회원가입이 완료되었습니다.'); location.href='index.jsp';</script>";
		    out.println(query);
		    
		    
		}catch(SQLException | ClassNotFoundException e) {
		    System.out.println("db접속 에러" + e.getMessage());
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try { conn.close(); } catch(SQLException e) {}
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

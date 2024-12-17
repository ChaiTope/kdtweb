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
import javax.servlet.http.HttpSession;

import kdtweb.dao.MySqlConnect;

@WebServlet("/testok")  // JSP에서 form action="testok"에 맞는 서블릿 경로
public class TestOk extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {

		res.setContentType("text/html;charset=utf-8");
		req.setCharacterEncoding("UTF-8");
		PrintWriter out = res.getWriter();
		
        // JSP에서 전송된 파라미터 받기
        String testid = req.getParameter("testid");
        String testpass = req.getParameter("testpass");
        String tel1 = req.getParameter("tel1");
        String tel2 = req.getParameter("tel2");
        String tel3 = req.getParameter("tel3");
        
        // 전화번호 합치기
        String tel = tel1 + "-" + tel2 + "-" + tel3;
        
        // 데이터 검증 및 처리 로직 (여기서는 간단히 출력)
        System.out.println("아이디: " + testid);
        System.out.println("비밀번호: " + testpass);
        System.out.println("전화번호: " + tel);

        // 예를 들어 DB에 저장하거나 다른 로직을 수행할 수 있음
        Connection conn = null;
		PreparedStatement pstmt = null;
		MySqlConnect dbcon = new MySqlConnect();
		ResultSet rs = null;
		
		try {
			conn = dbcon.getConn();
			System.out.println("db 접속 성공");
			
		    String sql = "insert into testbbs (userid, userpass, usercall)"
		    		     + " values (?,?,?)";
			
		    pstmt =  conn.prepareStatement(sql);
		    pstmt.setString(1, testid);
		    pstmt.setString(2, testpass);
		    pstmt.setString(3, tel);

		    pstmt.executeUpdate();
		    //select 일 경우 pstmt.executeQuery();
		    // System.out.println(pstmt);

		    HttpSession session = req.getSession();
		    session.setAttribute("userid", testid);
		    //res.sendRedirect("index.jsp");
		    String query = "<script>alert('회원가입이 완료되었습니다.'); location.href='index.jsp';</script>";
		    out.println(query);
//		    
//		    rs = (pstmt.executeQuery());
//		    System.out.println(rs);
		    
		}catch(SQLException | ClassNotFoundException e) {
		    System.out.println("db접속 에러" + e.getMessage());
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try { conn.close(); } catch(SQLException e) {}
		}

    }
}

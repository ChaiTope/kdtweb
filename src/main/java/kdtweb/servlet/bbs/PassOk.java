package kdtweb.servlet.bbs;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kdtweb.dao.bbs.Board;


@WebServlet("/passok")
public class PassOk extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       Board bbs = new Board();
       long num = 0;
       String pass =request.getParameter("pass");
       String strNum =request.getParameter("num");
       if(strNum != null && !strNum.isEmpty()) {
    	   num = Long.parseLong(strNum);
       }
       int result = 0;
       try {
		  result = bbs.isPass(num, pass);

	   } catch (SQLException e) {
		  e.printStackTrace();
	   }
       String rs = String.valueOf(result);
       response.setContentType("text/plain");
       response.setCharacterEncoding("UTF-8");
       response.getWriter().write(rs);
       response.getWriter().flush();
      
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

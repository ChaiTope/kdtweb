package kdtweb.servlet.bbs;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kdtweb.beans.BoardDto;
import kdtweb.dao.bbs.Board;


@WebServlet("/bbswriteok")
public class BbsWriteOk extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		BoardDto bbsDto = new BoardDto();
		Board bbs = new Board();
		
		//1. request.getParameter
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		String writer = request.getParameter("writer");
		String userid = (session.getAttribute("userid") != null)?
				                  (String)session.getAttribute("userid"):"guest";
		
		String password = (session.getAttribute("userid") != null)? 
				             (String)session.getAttribute("userid"):
				              request.getParameter("password");
		
		bbsDto.setTitle(title);
		bbsDto.setContents(contents);
		bbsDto.setWriter(writer);
		bbsDto.setPassword(password);
		bbsDto.setUserid(userid);
		int rs = 0;
		try {
			rs = bbs.inserBoard(bbsDto);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response.setContentType("application/json; charset=utf-8");
		String result = "{\"result\": "+ rs +" }";
        response.getWriter().write(result);
        response.getWriter().flush();
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

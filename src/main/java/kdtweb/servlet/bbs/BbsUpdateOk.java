package kdtweb.servlet.bbs;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kdtweb.beans.BoardDto;
import kdtweb.dao.bbs.Board;


@WebServlet("/bbsupdateok")
public class BbsUpdateOk extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		BoardDto dto = new BoardDto();
		Board bbs = new Board();
		
		String title= request.getParameter("title");
		String contents = request.getParameter("contents");
		String writer = request.getParameter("writer");
		String password = request.getParameter("password");
		String strNum = request.getParameter("num");
		long num = 0;
		int res = 0;
		if(strNum != null && !strNum.isEmpty()) {
			num = Long.parseLong(strNum);
		}
		dto.setTitle(title);
		dto.setContents(contents);
		dto.setWriter(writer);
		dto.setPassword(password);
		dto.setNum(num);
		try {
			res = bbs.updateBoard(dto);
		}catch(SQLException e) {
			e.printStackTrace();
		}
		response.setContentType("application/json; charset=utf-8");
		String result = "{\"result\": "+ res + " }";
		response.getWriter().write(result);
		response.getWriter().flush();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

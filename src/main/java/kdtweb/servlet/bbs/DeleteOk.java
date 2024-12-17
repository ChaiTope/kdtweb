package kdtweb.servlet.bbs;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kdtweb.dao.bbs.Board;


@WebServlet("/deleteOk")
public class DeleteOk extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       PrintWriter out = response.getWriter();
       response.setContentType("text/plain");
       response.setCharacterEncoding("UTF-8");   
       Board bbs = new Board();
       long num = 0;
       int res = 0;
       String strNum = request.getParameter("num");
       if(strNum != null && !strNum.isEmpty()) {
    	   num = Long.parseLong(strNum);
       }
       String auth = request.getParameter("auth");
              
       if(!"ok".equals(auth)) {
    	  String goOut = "<script>alert('정상적이지 않은 방법으로 접근하셨습니다.');location.href='bbs.jsp';</script>";  
          out.println(goOut);
       }
       try {
    	  res = bbs.deleteBoard(num);
       }catch(SQLException e) {}
       
      // String result = "{\"result\" : "+res+"}";
       //System.out.println(result);
       out.print(res); //줄바꿈 처리를 없애고 값만 가도록
       out.flush();  //출력스트림 전송
       out.close();  //스트림 닫음
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

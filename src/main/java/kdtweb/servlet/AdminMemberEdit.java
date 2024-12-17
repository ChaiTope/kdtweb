package kdtweb.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kdtweb.dao.members.DeleteMem;
import kdtweb.dao.members.UpdateMem;


@WebServlet("/adminedt")
public class AdminMemberEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String reid = request.getParameter("id");
		String lv = request.getParameter("lv");
		int id=0, grade=0;
		if(reid != null && !reid.isEmpty()) id = Integer.parseInt(reid);
		if(lv != null && !lv.isEmpty()) grade = Integer.parseInt(lv);
		PrintWriter out = response.getWriter();
		
		UpdateMem upmem = new UpdateMem();
		DeleteMem delmem = new DeleteMem();
		int res = 0;
		
		try {
			if(grade == 99) {
			   res = delmem.deleteMem(id);	
			}else {
			   res = upmem.adminMemEdit(id, grade);	
			}
		
			out.print(res);
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

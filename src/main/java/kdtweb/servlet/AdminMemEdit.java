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

import kdtweb.dao.KdtwebDao;

@WebServlet("/adminmemedit")
public class AdminMemEdit extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        // 파라미터로 회원 ID와 등급을 받음
        String id = request.getParameter("id");
        String level = request.getParameter("lv");

        Connection conn = null;
        PreparedStatement pstmt = null;
        KdtwebDao dao = new KdtwebDao();

        try {
            conn = dao.getConn(); // DB 연결

            if (Integer.parseInt(level) == 99) {
                // 등급이 99인 경우 회원을 삭제
                String deleteSql = "DELETE FROM members WHERE id = ?";
                pstmt = conn.prepareStatement(deleteSql);
                pstmt.setInt(1, Integer.parseInt(id));
            } else {
                // 그 외의 경우 등급 업데이트
                String updateSql = "UPDATE members SET grade = ? WHERE id = ?";
                pstmt = conn.prepareStatement(updateSql);
                pstmt.setInt(1, Integer.parseInt(level));  // 변경할 등급
                pstmt.setInt(2, Integer.parseInt(id));      // 회원 ID
            }

            int result = pstmt.executeUpdate();  // 쿼리 실행

            if (result > 0) {
                out.print(1);  // 성공 시 1 반환
            } else {
                out.print(0);  // 실패 시 0 반환
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.print(0);  // 오류 발생 시 0 반환
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}


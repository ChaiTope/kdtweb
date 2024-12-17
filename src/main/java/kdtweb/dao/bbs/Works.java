package kdtweb.dao.bbs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kdtweb.beans.WorksDto;
import kdtweb.dao.KdtwebDao;
import kdtweb.dao.members.CloseResource;

public class Works {
   //필드
   private KdtwebDao dao = new KdtwebDao();
   private CloseResource reso = new CloseResource();
   private Connection conn;
   private PreparedStatement pstmt = null;
   private ResultSet rs = null;
   
   public ArrayList<WorksDto> lBoard() throws SQLException {
   
      ArrayList<WorksDto> boardList = new ArrayList<>();
      String sql = "select * from works order by lv desc, gr asc";
      System.out.println(sql);
      try {
         conn = this.dao.getConn();
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery();
         
         while(rs.next()) {
            WorksDto bbsDto = new WorksDto();   
            bbsDto.setId(rs.getInt("id"));      
            bbsDto.setLv(rs.getInt("lv"));
            bbsDto.setGr(rs.getInt("gr"));
            bbsDto.setDepth(rs.getInt("depth"));
            bbsDto.setTitle(rs.getString("title"));
            
            boardList.add(bbsDto);
         }
         
      }catch(SQLException e) {
         e.printStackTrace();
      }finally {
         reso.closeResource(conn, pstmt, rs);
      }
      return boardList;
   }
}

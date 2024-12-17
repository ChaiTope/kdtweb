package kdtweb.dao.bbs;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import kdtweb.beans.BoardDto;
import kdtweb.dao.KdtwebDao;
import kdtweb.dao.members.CloseResource;

public class Board implements BoardInterface{

	//필드
	private KdtwebDao dao = new KdtwebDao();
	private CloseResource reso = new CloseResource();
	private Connection conn;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	@Override
	public int inserBoard(BoardDto bbs) throws SQLException {
		int res = 0;
		
		String sql = "insert into bbs_bbs "
				    +" (title, contents, writer, userid, password) "
				    +" value (? ,?, ?, ? , ?)";
		try {
			
			conn = this.dao.getConn();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bbs.getTitle());
			pstmt.setString(2, bbs.getContents());
			pstmt.setString(3, bbs.getWriter());
			pstmt.setString(4, bbs.getUserid());
			pstmt.setString(5, bbs.getPassword());
			
			res = pstmt.executeUpdate();
			
			
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			reso.closeResource(conn, pstmt);
		}
		
		return res;
	}
	@Override
	public int updateBoard(BoardDto bbs) throws SQLException {
		
		int res = 0;
		String sql = "update bbs_bbs SET title =?, contents=?, writer=? where num=?";
		try {
			conn = this.dao.getConn();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, bbs.getTitle());
			pstmt.setString(2, bbs.getContents());
			pstmt.setString(3, bbs.getWriter());
			pstmt.setLong(4, bbs.getNum());
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			reso.closeResource(conn, pstmt);
		}
		
		return res;
	}
	@Override
	public int deleteBoard(long num) throws SQLException {
		
		int res = 0;
		String sql = "delete form bbs_bbs where num=?";
		try {
			conn = this.dao.getConn();
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, num);
			res = pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			reso.closeResource(conn, pstmt);
		}
		
		return res;
	}
	@Override
	public ArrayList<BoardDto> listBoard() throws SQLException {
		ArrayList<BoardDto> boardList = new ArrayList<>();
		String sql = "select * from bbs_bbs order by num desc";
		try {
			conn = this.dao.getConn();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();	
			
			while(rs.next()) {
				BoardDto bbsDto = new BoardDto();
				bbsDto.setNum(rs.getLong("num"));
				bbsDto.setTitle(rs.getString("title"));
				bbsDto.setContents(rs.getString("contents"));
				bbsDto.setWriter(rs.getString("writer"));
				bbsDto.setUserid(rs.getString("userid"));
				bbsDto.setPassword(rs.getString("password"));
				bbsDto.setCount(rs.getInt("count"));
				bbsDto.setWdate(rs.getTimestamp("wdate"));

		        //출력은 yyyy-mm-dd이렇게 24시 이내는 HH:mm
						Timestamp wdate = rs.getTimestamp("wdate");
						//wdate를 unix타임으로 변환
						long wdateMills = wdate.getTime();
						//현재시간을 unix타임으로 변환
						long currentTimeMills = System.currentTimeMillis();
						//현재시간에서 글 쓴 시간을 빼서 24시간 이내인지 확인
						long diffTime = currentTimeMills - wdateMills;
						long rsDiffTime = diffTime/(60 * 60 * 1000); //시간단위 변환

						SimpleDateFormat dateFormat;
						if(rsDiffTime < 24) {
							dateFormat = new SimpleDateFormat("HH:mm");
						}else {
							dateFormat = new SimpleDateFormat("yyyy-MM-dd");
						}
						bbsDto.setViewDate(dateFormat.format(new Date(wdateMills)));
				boardList.add(bbsDto);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}finally {
			reso.closeResource(conn, pstmt, rs);
		}
		return boardList;
	}
	@Override
	public BoardDto viewBoard(long num) throws SQLException {
	    BoardDto bbsDto = null;
	    
	    // 조회수 증가 쿼리
	    String updateCountSql = "UPDATE bbs_bbs SET count = count + 1 WHERE num = ?";
	    String selectSql = "SELECT num, title, contents, writer, count, wdate FROM bbs_bbs WHERE num = ?";

	    try {
	        conn = this.dao.getConn();
	        
	        // 조회수 증가
	        pstmt = conn.prepareStatement(updateCountSql);
	        pstmt.setLong(1, num);
	        pstmt.executeUpdate(); // 조회수 증가 실행
	        
	        // 게시글 내용 조회
	        pstmt = conn.prepareStatement(selectSql);
	        pstmt.setLong(1, num);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            bbsDto = new BoardDto();
	            bbsDto.setNum(rs.getLong("num"));
	            bbsDto.setTitle(rs.getString("title"));
	            bbsDto.setContents(rs.getString("contents"));
	            bbsDto.setWriter(rs.getString("writer"));
	            bbsDto.setCount(rs.getInt("count")); // 조회수도 가져옴
	            bbsDto.setWdate(rs.getTimestamp("wdate"));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        reso.closeResource(conn, pstmt, rs);
	    }

	    return bbsDto;
	}

	
	

}

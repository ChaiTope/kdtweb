package kdtweb.dao.bbs;

import java.sql.SQLException;
import java.util.ArrayList;

import kdtweb.beans.BoardDto;

public interface BoardInterface {
  
	int inserBoard(BoardDto bbs) throws SQLException;
	int updateBoard(BoardDto bbs) throws SQLException;
	int deleteBoard(long num) throws SQLException;
	ArrayList<BoardDto> listBoard() throws SQLException; 
	BoardDto viewBoard(long num) throws SQLException;
}

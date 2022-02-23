package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Board;
import util.JdbcConnection;

public class BoardDao {
	
	public int nextNum() {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select boardseq.nextval from dual";
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			return rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JdbcConnection.close(con, pstmt, rs);
		}
		return 0;
	}
	
	
	public int insertBoard(Board board) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement pstmt = null;
		String sql = "insert into board values(?,?,?,?,?,?,?,sysdate,?,0,?,?,?)";
		// column name을 생략하면 create table column 순으로 입력
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board.getNum());
			pstmt.setString(2, board.getWriter());
			pstmt.setString(3, board.getPass());
			pstmt.setString(4, board.getSubject());
			pstmt.setString(5, board.getContent());
			pstmt.setString(6, board.getFile1());
			pstmt.setString(7, board.getBoardid());
			pstmt.setString(8, board.getIp());
			pstmt.setInt(9, board.getRef());
			pstmt.setInt(10, board.getReflevel());
			pstmt.setInt(11, board.getRefstep());
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JdbcConnection.close(con, pstmt, null);
		}
		
		
		return 0;
	}
	
	public int boardCount(String boardid) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select count(*) from board where boardid = ?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, boardid);
			rs = pstmt.executeQuery();
			rs.next();
			return rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JdbcConnection.close(con, pstmt, rs);
		}
		return 0;
	}
	public List<Board> boardList(int pageInt,int limit,int boardcount,String boardid) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from "+ 
		" (select rownum rnum, a.* from "+
		" (select * from board where boardid = ? order by ref desc, refstep asc) a) "+
		" where rnum between ? and ? ";
		List<Board> li = new ArrayList<Board>();
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, boardid);
			pstmt.setInt(2, (pageInt-1)*limit+1);
			pstmt.setInt(3, pageInt * limit);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Board b = new Board();
				b.setNum(rs.getInt("num"));
				b.setWriter(rs.getString("writer"));
				b.setPass(rs.getString("pass"));
				b.setSubject(rs.getString("subject"));
				b.setContent(rs.getString("content"));
				b.setFile1(rs.getString("file1"));
				b.setBoardid(rs.getString("boardid"));
				b.setRegdate(rs.getDate("regdate"));
				b.setIp(rs.getString("ip"));
				b.setReadcnt(rs.getInt("readcnt"));
				b.setRef(rs.getInt("ref"));
				b.setReflevel(rs.getInt("reflevel"));
				b.setRefstep(rs.getInt("refstep"));
				li.add(b);
			}
			return li;
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JdbcConnection.close(con, pstmt, rs);
		}
		return null;
	}
	
	public Board boardOne(int num) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from board where num = ?";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Board b = new Board();
				b.setNum(rs.getInt("num"));
				b.setWriter(rs.getString("writer"));
				b.setPass(rs.getString("pass"));
				b.setSubject(rs.getString("subject"));
				b.setContent(rs.getString("content"));
				b.setFile1(rs.getString("file1"));
				b.setBoardid(rs.getString("boardid"));
				b.setRegdate(rs.getDate("regdate"));
				b.setIp(rs.getString("ip"));
				b.setReadcnt(rs.getInt("readcnt"));
				b.setRef(rs.getInt("ref"));
				b.setReflevel(rs.getInt("reflevel"));
				b.setRefstep(rs.getInt("refstep"));
				return b;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JdbcConnection.close(con, pstmt, rs);
		}
		return null;
	}
	
	public int boardUpdate(Board board) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement pstmt = null;
		String sql = "update board set subject = ?, content = ?, file1 = ?"
				+ " where num = ?";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board.getSubject());
			pstmt.setString(2, board.getContent());
			pstmt.setString(3, board.getFile1());
			pstmt.setInt(4, board.getNum());
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JdbcConnection.close(con, pstmt, null);
		}
		return 0;
	}
	public void readCountUp(int num) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement pstmt = null;
		String sql = "update board set readcnt = readcnt+1"
				+ " where num = ?";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,num);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JdbcConnection.close(con, pstmt, null);
		}
	}
	
	public int boardDelete(int num) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement pstmt = null;
		String sql = "delete from board where num = ?";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,num);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JdbcConnection.close(con, pstmt, null);
		}
		return 0;
	}
	
	public void refStepAdd(int ref, int refstep) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement pstmt = null;
		String sql = "update board set refstep = refstep + 1 where ref = ? and refstep > ?";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,ref);
			pstmt.setInt(2,refstep);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JdbcConnection.close(con, pstmt, null);
		}
	}
}

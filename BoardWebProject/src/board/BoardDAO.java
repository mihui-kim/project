package board;

import java.sql.*;
import java.util.*;

import org.apache.jasper.tagplugins.jstl.core.Out;

import util.JDBCUtil;

public class BoardDAO {
	
	//생성자
	private BoardDAO() {}
	
	//객체생성(내부인스턴스)
	private static BoardDAO boardDAO=new BoardDAO();
	
	//외부접근 가능한 리턴값 (외부인스턴스)
	public static BoardDAO getInstance() {
		return boardDAO;
	}
	
	//------------------------------------------------------------------------
	//DB연결, 질의에 사용할 객체 선언
	private Connection conn=null;
	private PreparedStatement pstmt=null;
	private ResultSet rs=null;
	
	
	//------------------------------------------------------------------------
	//게시판 글작성 메소드 (안내창 따로 하지않을것.. int는 필요없어서 void 타입으로 설정함) =원글!
	public void insertBoard(BoardDTO board) {
		
		/* 작업A. board에서 가장 큰 번호를 구함 -> 이 번호로 그룹할 아이디 값을 결정 */
		String sql1="select max(num) from board";
		/* 작업B. 같은 그룹화 아이디이거나(ref), 글순서가(re_step)크다면  1을 증가시킴  == 댓글을 담기면 글순서를 증가시킴 */
		String sql2="update board set re_step=re_step+1 where ref=? and re_step>?";
		/* 작업C. 최종적으로 원글 또는 댓글을 추가함 */
		String sql3="insert into board(writer, subject, content, ref, re_step, re_level) values(?, ?, ?, ?, ?, ?)";
		
		int num=board.getNum();
		int ref=board.getRef();
		int re_step=board.getRe_step();
		int re_level=board.getRe_level();
		int number=0;
		
		try {
			conn = JDBCUtil.getConnection();
			
			/* 글번호의 최대값 획득 -> A부분 */
			pstmt=conn.prepareStatement(sql1);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				number=rs.getInt(1)+1; 					//최대값이 있다면 (글이 있다면) 최대값+1
			} else {				
				number=1;								//최대값이 없다면 (글이 없다면) 1
			}
			
			/* 댓글그룹, 댓글수, 댓글깊이를 수정  -> B부분 */
			if(num != 0) {								//댓글이라면...
				pstmt=conn.prepareStatement(sql2);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeUpdate();
				re_step=re_step+1;
				re_level=re_level+1;
			} else {									//댓글이 아니라면... (원글이라면)
				ref=number;
				re_step=0;
				re_level=0;
			}
			
			/* 글등록 처리 -> C부분 */
			pstmt = conn.prepareStatement(sql3);
			pstmt.setString(1, board.getWriter());
			pstmt.setString(2, board.getSubject());
			pstmt.setString(3, board.getContent());
			pstmt.setInt(4, ref);
			pstmt.setInt(5, re_step);
			pstmt.setInt(6, re_level);
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
	}
	
	//게시판 글보기(전체) 메소드 -> 여러개는 배열 또는 List를 사용
	//변경해보자. 페이지당 10건의 데이터만 출력되도록 하기
	public List<BoardDTO> getBoardList(int start, int size) {
		List<BoardDTO> boardList = new ArrayList<BoardDTO>();
		BoardDTO board = null;
		
		String sql="select * from board order by ref desc, re_step asc limit ?, ?";
		
		try {
			conn=JDBCUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, start-1); 	//limit은 0번부터 시작하므로 1을 빼줌
			pstmt.setInt(2, size);		//size는 개수 (크기)
			rs=pstmt.executeQuery();
			
			/* 1단계: 글번호, 제목, 작성자, 작성일, 조회수의 5가지 정보를 board에 저장 */
			/* 2단계: board를 boardList에 저장 */
			while(rs.next()) {
				board=new BoardDTO();
				board.setNum(rs.getInt("num"));
				board.setSubject(rs.getString("subject"));
				board.setWriter(rs.getString("writer"));
				board.setRegDate(rs.getTimestamp("regDate"));
				board.setReadcount(rs.getInt("readcount"));
				board.setRef(rs.getInt("ref"));
				board.setRe_step(rs.getInt("re_step"));
				board.setRe_level(rs.getInt("re_level"));
				boardList.add(board);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return boardList;
	}
	
	//게시판 글보기(1건) 메소드
	public BoardDTO getBoard(int num) {
		BoardDTO board = new BoardDTO();
		String sql1="update board set readcount=readcount+1 where num=?";
		String sql2="select * from board where num=?";
		
		try {
			conn=JDBCUtil.getConnection();
			
			/* 조회수 증가 */
			pstmt=conn.prepareStatement(sql1);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			/* 글 상세보기 */
			pstmt=conn.prepareStatement(sql2);
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			
			if(rs.next()) { 
				board.setNum(rs.getInt("num"));
				board.setWriter(rs.getString("writer"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setRegDate(rs.getTimestamp("regDate"));
				board.setReadcount(rs.getInt("readcount"));
				board.setRef(rs.getInt("ref"));
				board.setRe_step(rs.getInt("re_step"));
				board.setRe_level(rs.getInt("re_level"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return board;
	}
	
	//게시판 글수정 폼에서 글보기 메소드
	public BoardDTO getBoardUpdateForm(int num) {
		BoardDTO board=new BoardDTO();
		String sql="select * from board where num=?";
		
		try {
			conn=JDBCUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				/* 글 수정 폼에서 수정하는 2가지 정보 */
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return board;
	}
	
	//게시판 글수정 메소드
	public void updateboard(BoardDTO board) {
		String sql="update board set subject=?, content=? where num=?";
		
		try {
			conn=JDBCUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, board.getSubject());
			pstmt.setString(2, board.getContent());
			pstmt.setInt(3, board.getNum());
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
	}
	
	//게시판 글삭제 메소드
	public int deleteBoard(int num, String writer, String pwd) {
		String sql1="select pwd from member where id=?";
		String sql2="delete from board where num=?";
		int cnt=0;
		
		try {
			conn=JDBCUtil.getConnection();
			/* member테이블에서 id(writer)에 해당하는 dbPwd를 구함 */
			pstmt=conn.prepareStatement(sql1);
			pstmt.setString(1, writer);
			rs=pstmt.executeQuery();
			
			/* pwd와 dbPwd가 일치할 때 num에 해당하는 글을 삭제함 */
			if(rs.next()) {
				String dbPwd=rs.getString("pwd");
				if(pwd.equals(dbPwd)) {
					pstmt=conn.prepareStatement(sql2);
					pstmt.setInt(1, num);
					cnt=pstmt.executeUpdate();
					
				}
			} 
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cnt;
	}
	
	//전체 글수 획득
	public int getBoardCount() {
		String sql="select count(*) from board";
		int cnt=0;
		
		try {
			conn=JDBCUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			rs.next();
			cnt=rs.getInt(1);
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cnt;
	}
	
}

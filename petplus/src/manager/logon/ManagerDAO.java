package manager.logon;

import java.sql.*;

import util.JDBCUtil;

public class ManagerDAO {
	//싱글톤 패턴
	private ManagerDAO() { }
	private static ManagerDAO instance = new ManagerDAO();
	public static ManagerDAO getInstance() {
		return instance;
	}
	
	
	//DB연결 & 질의를 위한 변수선언
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	
	//관리자 확인 메소드 (id, pwd)
	public int checkManager(String managerId, String managerPwd) {
		String sql = "select * from manager where managerId=? and managerPwd=?";
		int cnt = 0;
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, managerId);
			pstmt.setString(2, managerPwd);
			rs=pstmt.executeQuery();
			
			if(rs.next()) cnt = 1;
			else cnt = 0;
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cnt;
	}
}

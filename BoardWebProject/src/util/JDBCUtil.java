package util;

import java.sql.*;
import javax.naming.*;
import javax.sql.DataSource;

public class JDBCUtil {
	
	//
	public static Connection getConnection() throws Exception {
		Context initCtx=new InitialContext(); 
		Context envCtx=(Context)initCtx.lookup("java:comp/env"); 
		DataSource ds=(DataSource)envCtx.lookup("jdbc/db01"); 
		return ds.getConnection();
	}
	
	//Connection, PrepareStatement 닫는 메소드 -> insert, update, delete 작업
	public static void close(Connection conn, PreparedStatement pstmt) {
		if(pstmt!=null) try {pstmt.close();} catch(Exception e) {e.printStackTrace();}
		if(conn!=null) try {conn.close();} catch(Exception e) {e.printStackTrace();}
	}
	//Connection, PrepareStatement 닫는 메소드 -> select 작업
	public static void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		if(rs!=null) try {rs.close();} catch(Exception e) {e.printStackTrace();}
		if(pstmt!=null) try {pstmt.close();} catch(Exception e) {e.printStackTrace();}
		if(conn!=null) try {conn.close();} catch(Exception e) {e.printStackTrace();}
	}
}


package member;

import java.sql.*;
import util.JDBCUtil;


public class MemberDAO {
	
	//Singleton Pattern : 클래스의 인스턴스를 하나만 생성하는 방법
	//생성자 (private라서 내부만 사용가능한 상황)
	private MemberDAO() {}
	
	//객체생성 (외부에서 사용할 수 있도록 객체를 만듬)
	private static MemberDAO memberDAO=new MemberDAO();
	
	//??생성 (외부에서 사용할 수 있도록 객체를 public static으로 만들어서 리턴값으로 돌려줌) 
	public static MemberDAO getInstance() {
		return memberDAO;
	}
	
	
	//-----------------------------------------------------------------------------
	//DB연결, 질의에 사용할 객체 선언
	private Connection conn=null;
	private PreparedStatement pstmt=null;
	private ResultSet rs=null;
	
	
	//-----------------------------------------------------------------------------
	//회원 ID 중복 체크
	public int checkId(String id) {
		String sql="select * from member where id=?";
		int cnt=0;
		try {
			conn=JDBCUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			
			/* 아이디가 이미 존재 (사용 불가) */
			if(rs.next()) {cnt=0;}
			/* 아이디가 없음 (사용 가능) */
			else {cnt=1;}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cnt;
	}
	
	//-----------------------------------------------------------------------------
	//회원가입 메소드
	public int insertMember(MemberDTO member) {
		String sql="insert into member values(?, ?, ?, ?, ?, ?, now())";
		int cnt=0; 
		
		try {
			conn=JDBCUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPwd());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getEmail());
			pstmt.setString(5, member.getTel());
			pstmt.setString(6, member.getAddress());
			cnt=pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return cnt;
	}
	
	//로그인 메소드
	public int login(String id, String pwd) {
		String sql="select * from member where id=?";
		int cnt=0;  //-1 아이디없음 0 아이디비밀번호다름 1 아이디비밀번호일치
		
		try {
			conn=JDBCUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			
			//아이디 있을 때
			if(rs.next()) {
				String dbPwd=rs.getString("pwd");
				//비밀번호 일치
				if(pwd.equals(dbPwd)) {
					cnt=1;
				//비밀번호 불일치
				} else {
					cnt=0;
				}
				
			//아이디 없을 때
			} else {
				cnt=-1;
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cnt;
	}
	
	//회원정보 보기 메소드 (1명, 자신의 정보)
	public MemberDTO getMember(String id) {
		String sql="select * from member where id=?";
		MemberDTO member=new MemberDTO();
		try {
			conn=JDBCUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			
			if(rs.next()) { //rs에 있는(db)결과를 member에 넣는작업 -> 가입일을 제외한 모든 정보를 member테이블로부터 가져와서 member객체에 저장
				member.setId(rs.getString("id"));
				member.setPwd(rs.getString("pwd"));
				member.setName(rs.getString("name"));
				member.setEmail(rs.getString("email"));
				member.setTel(rs.getString("tel"));
				member.setAddress(rs.getString("address"));
				member.setRegDate(rs.getTimestamp("regDate"));
			} else {
				
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return member;
	}
	
	//회원정보 수정 메소드
	public int updateMember(MemberDTO member) {
		String sql="update member set pwd=?,name=?,email=?,tel=?,address=? where id=?";
		int cnt =0; 
		
		try {
			conn=JDBCUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, member.getPwd());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getTel());
			pstmt.setString(5, member.getAddress());
			pstmt.setString(6, member.getId());
			cnt=pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return cnt;
	}
	
	//회원탈퇴 메소드 (+해당 회원 정보 삭제 시 작성한 글도 모두 삭제되도록 처리)
	public int deleteMember(String id, String pwd) throws Exception {
		String sql1="delete from member where id=? and pwd=?";
		String sql2="delete from board where writer=?";
		int cnt=0;
		
		try {
			//--------------------------A. 트랜잭션 처리 : autocommit 기능을 off 한다. - 기본 셋팅값을 설정한 것
			conn=JDBCUtil.getConnection();
			conn.setAutoCommit(false);
			
			/* 1단계 : 계정삭제 작업 */
			pstmt=conn.prepareStatement(sql1);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			cnt=pstmt.executeUpdate();
			
			/* 2단계 : 탈퇴 한 계정의 글 삭제 */
			pstmt=conn.prepareStatement(sql2);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			
			//--------------------------B. 트랜잭션 처리 : 모든 작업이 완료되었을 때 커밋을 실행
			conn.commit();
		
			//--------------------------C. 트랜잭션 처리 : autocommit 기능을 on 한다. - 다시 default값으로 설정해둔 것
			conn.setAutoCommit(true);
			
		} catch(Exception e) {
			conn.rollback(); /* 트랜잭션 처리 시 예외가 발생했을 때 롤백을 한다.  */
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return cnt;
	}
	
}

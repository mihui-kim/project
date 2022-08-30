<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 전체보기</title>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Fredoka+One&display=swap');
	@import url('https://fonts.googleapis.com/css2?family=Jua&display=swap');
	@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
	
	/* 상단 */ 
	#container {width: 1000px; margin: 0 auto;}
	.m_title {font-family: 'Fredoka One', cursive; font-size: 3em; text-align: center;}
	.m_title a {text-decoration: none; color: #6799FF;}
	.s_title {font-family: 'Jua', sans-serif; font-size: 2em; text-align: center; margin-bottom: 20px; color: gray;}
	.s_cnt {float: left;}
	input[type="text"], input[type="password"] {height: 19px;}
	.top_info {text-align: right;}
	.top_info a {text-decoration: none;}
	.s_id, .s_logout, .s_write {clear: both; font-family: 'Jua', sans-serif; font-size: 1.2em;}
	.s_cnt {font-family: 'Jua', sans-serif; font-size: 1.2em;} 
	.s_id a, .s_cnt {color: gray;}
	.s_logout a {color: #F29661;}
	.s_write a {color: #6799FF;}
	
	/* 중단 */
	table {width: 100%; border-collapse: collapse;}
	td a {text-decoration: none; color: black;}
	tr {height: 30px;}
	th {background: #79ABFF; color: white; font-family: 'Jua', sans-serif; font-size: 1.1em; font-weight: lighter;}
	td {font-family: 'Noto Sans KR', sans-serif;}
	tr:nth-child(2n+1) {background: #f1f1f7;}
	tr:last-child {border-bottom: 10px solid #79ABFF;}
	.center {text-align: center;}
	.left {padding-left: 5px;}
	.left a {text-decoration: none;}
	.left a:hover {font-weight: bold; color: #F29661;}
	.no_board {text-align: center;}
	
	/* 하단 */
	#paging {text-align: center; margin-top: 20px; }
	#pBox {display: inline-block; width: 20px; height: 20px; padding: 5px; margin: 5px; 
			font-family: 'Jua', sans-serif; font-size: 1em; text-decoration: none; color: gray;}
	.pBox_c {background: #79ABFF; border-radius: 7px; color: white; }
	#pBox:hover {background: #79ABFF; color: white; border-radius: 7px;}
	
</style>
</head>
<body>
	<%
	String memberId=(String)session.getAttribute("memberId"); //강제캐스팅
	if(memberId==null) {
		out.print("<script>location='../logon/memberLoginForm.jsp'</script>");
	}
	
	//날짜 형식 클래스
	SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	
	//-----------------------------------------------------------------------------페이징(paging)처리
	/* 변수 선언 */
	int pageSize=10; 									//1페이지에 10건의 게시글을 보여줌
	String pageNum=request.getParameter("pageNum");
	
	if(pageNum==null) pageNum="1";
	
	int currentPage=Integer.parseInt(pageNum); 			 //현재 페이지
	int startRow = (currentPage -1) * pageSize+1; 		 //현재 페이지의 첫번째 행
	int endRow=currentPage * pageSize;					 //현재 페이지의 마지막 행
	//------------------------------------------------------------------------------
	
	
	//BoardDAO 클래스 연결
	BoardDAO boardDAO = BoardDAO.getInstance();
	
	//전체 글수 획득
	int cnt=boardDAO.getBoardCount();
	
	//게시판 전체 정보를 currentPate의 pageSize 크기만큼 획득
	List<BoardDTO> boardList = boardDAO.getBoardList(startRow, pageSize);
	
	//매 페이지마다 전체글수에 대한 역순번호
	int number=cnt-((currentPage-1)*pageSize); 			

	
	%>
	<div id="container">
		<div class="m_title"><a href="#">DEV TALK</a></div>
		<div class="s_title">전체 게시판</div>
		<div class="top_info">
		<span class="s_cnt">전체글수 : <%=cnt%>건</span>
		<span class="s_id"><a href="../member/memberInfoForm.jsp">‍🧒🏻<%=memberId%>님</a></span>
		&emsp;<span class="s_logout"><a href="../logon/memberLogout.jsp">🔑로그아웃</a></span>
		&emsp;<span class="s_write"><a href="boardWriteForm.jsp">📝글 등록</a></span></div><br>
	
	
	<table>
		<tr>
			<th width="7%">번호</th>
			<th width="55%">제목</th>
			<th width="13%">작성자</th>
			<th width="18%">작성일</th>
			<th width="7%">조회수</th>
		</tr>
		<% if(number == 0) { %>
			<tr><td colspan="5"  class="no_board">등록된 게시글이 없습니다.</td></tr>
		<% } else { 
			 for(BoardDTO board : boardList) { 
			 	int num=board.getNum();
		%>
				<tr>
					<td class="center"><%=number--%></td>
					<td class="left">
						<%
						int width=0;
						if(board.getRe_level() > 0) { /* 원글은 0번이니까, 댓글이라면... */
							width=board.getRe_level() * 10;
							out.print("<img src='../images/re.png' width='"+width+"' height='16'>");
							out.print("<img src='../images/level.png' width='20px'>");
						}%>
						<a href="boardContent.jsp?num=<%=num%>&pageNum=<%=pageNum%>"><%=board.getSubject()%></a>
						<%
						if(board.getReadcount()>=30) {
							out.print("<img src='../images/hot.png' width='30px'>"); 
						}%>
				
					</td>
					<td class="center"><%=board.getWriter()%></td>
					<td class="center"><%=sdf.format(board.getRegDate())%></td>
					<td class="center"><%=board.getReadcount()%></td>
				</tr>	
		<% }  } %>
	</table>
	<div id="paging">
	<%
	if(cnt>0) {
		int pageCount=(cnt/pageSize) + (cnt%pageSize==0? 0:1);	//전체 페이지 수, 뒷자리 1~10이면 한페이지를 어차피 추가해야 하므로 나머지가 0이 아닐 때는 1을 더해준다
		int startPage=1;										//시작 페이지 번호
		int pageBlock=10;										//페이징의 개수, 화면에서 보이는 페이지 목록 범위
		
		/* 시작 페이지 설정 */
		if(currentPage%10 != 0) startPage=(currentPage/10)*10+1;
		else startPage=(currentPage/10-1) * 10 + 1;
		
		/* 끝 페이지 설정 */
		int endPage = startPage + pageBlock - 1;
		if(endPage > pageCount) endPage = pageCount;			//마지막 페이지보다 큰 페이지는 없기 때문에, endPage자리에 마지막 페이지수라고 저장한 것
	
		/* 맨 처음 페이지 이동처리*/
		if(startPage > 10)
			out.print("<a href='boardList.jsp?pageNum=1'><div id='pBox' title='첫 페이지'>" + "<<" + "</div></a>");
		
		/* 이전 페이지 이동처리 */
		if(startPage > 10) {
			out.print("<a href='boardList.jsp?pageNum="+(currentPage-10)+"' title='이전 10페이지'><div id='pBox'>" + "<" + "</div></a>");
		}
		
		/* 페이징 블럭 처리 */
		for(int i=startPage; i<=endPage; i++) {
			if(currentPage == i) { //선택된 페이지 표현
				out.print("<div id='pBox' class='pBox_c'>" + i + "</div>");
			} else {
				out.print("<a href='boardList.jsp?pageNum="+i+"'><div id='pBox'>" + i + "</div></a>");	//i숫자를 이용해 페이지를 바꿈
			}
		}
		
		/* 다음 페이지 이동처리 */
		if(endPage < pageCount) {
			int movePage=currentPage+10;
			if(movePage>pageCount) movePage=pageCount;
			out.print("<a href='boardList.jsp?pageNum="+ movePage +"' title='다음 10페이지'><div id='pBox'>" + ">" + "</div></a>");
		}
		
		/* 맨 끝 페이지 이동처리 */
		if(endPage < pageCount) {
			out.print("<a href='boardList.jsp?pageNum=" + pageCount + "' title='마지막 페이지'><div id='pBox'>" + ">>" + "</div></a>");
		}
	} 
	%>
	</div>
	</div>
</body>
</html>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 각각의 상세페이지</title>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Fredoka+One&display=swap');
	@import url('https://fonts.googleapis.com/css2?family=Jua&display=swap');
	@import url('https://fonts.googleapis.com/css2?family=Sunflower:wght@300&display=swap');
	@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
	
	/* 상단 */ 
	#container {width: 500px; margin: 0 auto;}
	.m_title {font-family: 'Fredoka One', cursive; font-size: 3em; text-align: center;}
	.m_title a {text-decoration: none; color: #6799FF;}
	.s_title, .s_title_re {font-family: 'Jua', sans-serif; font-size: 2em; text-align: center; margin-bottom: 20px; color: gray;}
	
	/* 본문 */
	table {width: 100%; border: 1px solid #ccc; border-collapse: collapse;}
	tr {height: 40px;}
	th, td {border: 1px solid gray;}
	th {background: #D9E5FF; font-family: 'Jua', sans-serif; font-size: 1.0em; font-weight: lighter; color: gray;}
	td {padding-left: 10px; font-family: 'Noto Sans KR', sans-serif;}
	.c_id {color: #6799FF;}
	#subject {height: 20px;}
	.c_text {padding: 10px;}
	
	/* 하단 */
	.btns {text-align: center; margin-top: 30px;}
	.btns input {width: 110px; height: 40px; border-radius: 20px; border: none; background: #6799FF; color: white; font-weight: bold;
				font-family: 'Jua', sans-serif; font-size: 1em; font-weight: lighter; cursor: pointer;}
	.content_row {height: 300px;}
	.content_row td {vertical-align: baseline;}
</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		let form = document.ContentForm;
		let num=form.num.value;
		
		//글수정 버튼을 클릭
		let btn_update=document.getElementById("btn_update");
		btn_update.addEventListener("click", function() {
			if(form.id.value==form.writer.value) { /* 권한이 없으면 수정 불가하게 만듬 */
				form.action='boardUpdateForm.jsp';
				form.submit();
			} else {
				alert('수정 권한이 없습니다.');
				return;
			}
		})
		
		//글삭제 버튼을 클릭
		let btn_delete=document.getElementById("btn_delete");
		btn_delete.addEventListener("click", function() {
			if(form.id.value==form.writer.value) { /* 권한이 없으면 삭제 불가하게 만듬 */
				form.action='boardDeleteForm.jsp';
				form.submit();
			} else {
				alert('삭제 권한이 없습니다.');
				return;
			}
		})
		
		if(form.id.value!=form.writer.value) {
		btn_update.style.display='none';  /* 권한이 없으면 버튼 자체가 보이지 않게 만듬 (공간자체가 삭제) */
		btn_delete.style.display='none';
		}
		
		
		//댓글작성 버튼 클릭
		let btn_review=document.getElementById("btn_review");
		btn_review.addEventListener("click", function() {
			form.submit();
		})
		
		//게시글보기 버튼을 클릭
		let pageNum=form.pageNum.value;
		let btn_boardList=document.getElementById("btn_boardList");
		btn_boardList.addEventListener("click", function() {
			location='boardList.jsp?pageNum=' + pageNum; //해당 페이지에서 글보기를 한 후 다시 전체게시글로 돌아갔을 때 해당 페이지에 머물러 있는 것
		})
	})
</script>
</head>
<body>
<%
String memberId=(String)session.getAttribute("memberId");
if(memberId==null) {
	out.print("<script>location='../logon/memberLoginForm.jsp';</script>");
}

SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");


String pageNum=request.getParameter("pageNum");
int num=Integer.parseInt(request.getParameter("num"));
BoardDAO boardDAO = BoardDAO.getInstance();
BoardDTO board = boardDAO.getBoard(num);

//원글의 정보
int ref=board.getRef();
int re_step=board.getRe_step();
int re_level=board.getRe_level();

%>
	<div id="container">
		<div class="m_title"><a href="boardList.jsp">DEV TALK</a></div>
		<div class="s_title">글 상세보기</div>
		
		<form action="boardWriteForm.jsp" method="post" name="ContentForm">
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<input type="hidden" name="num" value="<%=board.getNum()%>">
		
		<!-- id와 wirter를 이용하여 로그인한 회원과 글작성자 확인 -->
		<input type="hidden" name="id" value="<%=memberId%>">				<!-- 로그인 아이디(계정)-->
		<input type="hidden" name="writer" value="<%=board.getWriter()%>"> 	<!-- 글 작성자(주인) -->
		
		<!-- 댓글 처리 -->
		<input type="hidden" name="ref" value="<%=ref%>">
		<input type="hidden" name="re_step" value="<%=re_step%>">
		<input type="hidden" name="re_level" value="<%=re_level%>">
			<table>
				<tr>
					<th width="15%">글번호</th>
					<td width="85%"><%=board.getNum()%></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td><%=board.getWriter()%></td>
				</tr>
				<tr>
					<th>제목</th>
					<td><%=board.getSubject()%></td>
				</tr>
				<tr class="content_row">
					<th>내용</th>
					<td><%=board.getContent()%></td>
				</tr>
				<tr>
					<th>등록일</th>
					<td><%=sdf.format(board.getRegDate())%></td>
				</tr>
				<tr>
					<th>조회수</th>
					<td><%=board.getReadcount()%></td>
				</tr>
			</table>
			<div class="btns">
				<input type="button" value="글 수정" id="btn_update">&ensp;
				<input type="button" value="글  삭제" id="btn_delete">&ensp;
				<input type="button" value="댓글 작성" id="btn_review">&ensp;
				<input type="button" value="게시글 보기" id="btn_boardList">
			</div>
		</form>
	</div>
</body>
</html>
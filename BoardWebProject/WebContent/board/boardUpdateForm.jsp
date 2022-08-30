<%@page import="board.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정 폼</title>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Fredoka+One&display=swap');
	@import url('https://fonts.googleapis.com/css2?family=Jua&display=swap');
	@import url('https://fonts.googleapis.com/css2?family=Sunflower:wght@300&display=swap');
	@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
	
	/* 상단 */ 
	#container {width: 500px; margin: 0 auto;}
	.m_title {font-family: 'Fredoka One', cursive; font-size: 3em; text-align: center;}
	.m_title a {text-decoration: none; color: #6799FF;}
	.s_title {font-family: 'Jua', sans-serif; font-size: 2em; text-align: center; margin-bottom: 30px; color: gray;}
	
	/* 본문 */
	table {width: 100%;  border: 1px solid #ccc; border-collapse: collapse;}
	tr {height: 50px;}
	th, td {border: 1px solid gray;}
	th {background: #D9E5FF; font-family: 'Jua', sans-serif; font-size: 1em; font-weight: lighter; color: gray;}
	table td, table input, table textarea {padding-left: 10px; font-family: 'Noto Sans KR', sans-serif;}
	#subject {height: 20px;}
	.c_text {padding: 10px;}
	
	/* 하단 */
	.btns {text-align: center; margin-top: 20px;}
	.btns input {width: 120px; height: 40px; border-radius: 25px; border: none; background: #6799FF; color: white; font-weight: bold;
				font-family: 'Jua', sans-serif; font-size: 1em; font-weight: lighter; cursor: pointer;}
</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		let form = document.updateForm;
		
		//글수정 버튼을 클릭
		let btn_update=document.getElementById("btn_update");
		btn_update.addEventListener("click", function() {
			if(!form.subject.value) {
				alert('제목을 입력하세요.');
				form.subject.focus();
				return;
			}
			if(!form.content.value) {
				alert('내용을 입력하세요.');
				form.content.focus();
				return;
			}
			form.submit();
		})
		
		//전체게시글 버튼을 클릭
		let pageNum=form.pageNum.value;
		let btn_boardList=document.getElementById("btn_boardList");
		btn_boardList.addEventListener("click", function() {
			location='boardList.jsp?pageNum=' + pageNum;
		})
	})
</script>
</head>
<body>
<%
String memberId= (String)session.getAttribute("memberId");

/* 세션으로 받은 아이디가 없을 때 */
if(memberId==null) {
	out.print("<script>location='../logon/memberLoginForm.jsp'</script>");
} 


/* 세션으로 받은 아이디가 있을 때 아래 실행 */
String pageNum=request.getParameter("pageNum");
int num=Integer.parseInt(request.getParameter("num"));

/* 글넘버에 따라 */
BoardDAO boardDAO = BoardDAO.getInstance();
BoardDTO board = boardDAO.getBoardUpdateForm(num);

%>
	<div id="container">
		<div class="m_title"><a href="boardList.jsp">EZEN MALL</a></div>
		<div class="s_title">글 수정</div>
		
		<form action="boardUpdatePro.jsp" method="post" name="updateForm">
			<input type="hidden" name="pageNum" value="<%=pageNum%>">
			<input type="hidden" name="num" value="<%=num%>">
			<table>
				<tr>
				<th width="15%">작성자</th>
				<td width="85%"><%=memberId%></td>
				</tr>
				<tr>
				<th>제목</th>
				<td><input type="text" name="subject" id="subject" size="54" value="<%=board.getSubject()%>"></td>
				</tr>
				<tr>
				<th>내용</th>
				<td class="c_text"><textarea rows="22" cols="56" name="content" id="content"><%=board.getContent()%></textarea></td>
				</tr>
			</table>
			<div class="btns">
				<input type="button" value="글 수정" id="btn_update">&emsp;&emsp;
				<input type="button" value="게시글 보기" id="btn_boardList">
			</div>
		</form>
	</div>
</body>
</html>
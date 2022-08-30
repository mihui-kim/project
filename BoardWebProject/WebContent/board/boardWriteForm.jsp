<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글등록 폼</title>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Fredoka+One&display=swap');
	@import url('https://fonts.googleapis.com/css2?family=Jua&display=swap');
	@import url('https://fonts.googleapis.com/css2?family=Sunflower:wght@300&display=swap');
	@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
	
	/* 상단 */ 
	#container {width: 500px; margin: 0 auto;}
	.m_title {font-family: 'Fredoka One', cursive; font-size: 3em; text-align: center;}
	.m_title a {text-decoration: none; color: #6799FF;}
	.s_title, .s_title_re {font-family: 'Jua', sans-serif; font-size: 2em; text-align: center; margin-bottom: 30px; color: gray;}
	
	/* 본문 */
	table {width: 100%; border: 1px solid #ccc; border-collapse: collapse;}
	table input, table textarea {font-family: 'Noto Sans KR', sans-serif;}
	tr {height: 50px;}
	th, td {border: 1px solid gray;}
	th {background: #D9E5FF; font-family: 'Jua', sans-serif; font-size: 1.0em; font-weight: lighter; color: gray;}
	td {padding-left: 10px;}
	.c_id {color: #6799FF;}
	#subject {height: 20px; width: 180px;}
	#writer {background: #ededed;}
	.c_text {padding: 10px;}
	
	/* 하단 */
	.btns {text-align: center; margin-top: 20px;}
	.btns input {width: 110px; height: 40px; border-radius: 20px; border: none; background: #6799FF; color: white; font-weight: bold;
				font-family: 'Jua', sans-serif; font-size: 1em; font-weight: lighter; cursor: pointer;}
</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		let form = document.writeForm;
		
		//글등록 버튼을 클릭
		let btn_write=document.getElementById("btn_write"); 
		btn_write.addEventListener("click", function() {
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
	/* ------------------------------------------------------------------------세션으로 받은 아이디가 없을 때 */
	if(memberId==null) {
		out.print("<script>location='../logon/memberLoginForm.jsp'</script>");
	} 
	
	/* ------------------------------------------------------------------------세션으로 받은 아이디가 있을 때 아래 실행 */
	
	String pageNum=request.getParameter("pageNum");
	if(pageNum == null) pageNum="1";
	
	//댓글 처리 변수선언
	int num=0, ref=1, re_step=0, re_level=0;
	String re=""; 
	
	/* 글번호(num)이 없다면 "원글" 글번호(num)이 있다면 "댓글"*/
	//A. 댓글이라면... (num, ref, re_step, re_level을 저장)
	
	//B. 원글이라면... (위에서 선언한 기본값을 가짐)
	
	if(request.getParameter("num") != null) {
		num=Integer.parseInt(request.getParameter("num"));
		ref=Integer.parseInt(request.getParameter("ref"));
		re_step=Integer.parseInt(request.getParameter("re_step"));
		re_level=Integer.parseInt(request.getParameter("re_level"));
		re="[re]"; //댓글이면 제목란에 찍힘
	}
	%>
		<div id="container">
			<div class="m_title"><a href="boardList.jsp">DEV TALK</a></div>
			<% if(request.getParameter("num") != null) { %>
			<div class="s_title_re">댓글 등록</div>
			<% } else { %>
			<div class="s_title">글 등록</div>
			<% } %>
			
			<form action="boardWritePro.jsp" method="post" name="writeForm">
				<input type="hidden" name="pageNum" value="<%=pageNum%>">
				<input type="hidden" name="num" value="<%=num%>">
				<input type="hidden" name="ref" value="<%=ref%>">
				<input type="hidden" name="re_step" value="<%=re_step%>">
				<input type="hidden" name="re_level" value="<%=re_level%>">
				<table>
					<tr>
					<th width="15%">작성자</th>
					<td width="85%"><span class="c_id">
					<input type="text" name="writer" id="writer" value="<%=memberId%>" size="20" readonly></span></td>
					</tr>
					<tr>
					<th>제목</th>
					<td><input type="text" name="subject" id="subject" value="<%=re%>" size="54"></td>
					</tr>
					<tr>
					<th>내용</th>
					<td class="c_text"><textarea rows="22" cols="56" name="content" id="content"></textarea></td>
					</tr>
				</table>
				<div class="btns">
					<% if(request.getParameter("num") != null) { %>
					<input type="button" value="댓글 등록" id="btn_write">&emsp;&emsp;
					<%} else { %>
					<input type="button" value="글 등록" id="btn_write">&emsp;&emsp;
					<%} %>
					<input type="button" value="게시글 보기" id="btn_boardList">
				</div>
			</form>
		</div>
</body>
</html>
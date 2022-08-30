<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 삭제 폼</title>
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
	.c_login {border: 1px solid gray; padding: 20px;}
	.c_login div {margin: 30px 0; text-align: center;}
	.c_login .c_writer input {background: #EAEAEA;}
	.c_login label {display: inline-block; width: 65px; text-align: right; margin-right: 30px; font-family: 'Jua', sans-serif; font-size: 1.2em; color: gray;}
	.c_login input {width: 190px; height: 30px; border: 1px solid gray;}
	
	/* 하단 */
	.btns {text-align: center; margin-top: 30px;}
	.btns input {width: 120px; height: 40px; border-radius: 25px; border: none; background: #6799FF; color: white; font-weight: bold;
				font-family: 'Jua', sans-serif; font-size: 1em; font-weight: lighter; cursor: pointer;}
</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		let form=document.deleteForm;
		let btn_delete=document.getElementById("btn_delete");
		
		btn_delete.addEventListener("click", function() {
			if(!form.pwd.value) {
				alert('비밀번호를 입력해주세요');
				form.pwd.focus();
				return;
			}
			
			let answer=confirm('글을 삭제하겠습니까?');
			if(answer) {
				form.submit();
			} else {
				return;
			}
		})
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
String memberId=(String)session.getAttribute("memberId");
if(memberId==null) {
	out.print("<script>location='../logon/memberLoginForm.jsp'</script>");
}
String pageNum=request.getParameter("pageNum");
int num=Integer.parseInt(request.getParameter("num"));
%>
	<div id="container">
		<div class="m_title"><a href="boardList.jsp">EZEN MALL</a></div>
		<div class="s_title">글 삭제</div>
		<form action="boardDeletePro.jsp" method="post" name="deleteForm">
			<input type="hidden" name="pageNum" value="<%=pageNum%>">
			<input type="hidden" name="num" value="<%=num%>">
			<div class="c_login">
				<div class="c_writer">
					<label>작성자</label><input type="text" name="writer" id="writer" value="<%=memberId%>" readonly>
				</div>
				<div class="c_pwd">
					<label>비밀번호</label><input type="password" name="pwd" id="pwd">
				</div>
			</div>
			<div class="btns">
				<input type="button" value="글 삭제" id="btn_delete">&emsp;&emsp;
				<input type="button" value="게시글 보기" id="btn_boardList">
			</div>
		</form>
	</div>
</body>
</html>
<%@page import="board.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 삭제 처리</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

String pageNum=request.getParameter("pageNum");
int num=Integer.parseInt(request.getParameter("num"));
String writer=request.getParameter("writer");
String pwd=request.getParameter("pwd");

BoardDAO boardDAO=BoardDAO.getInstance();
int cnt=boardDAO.deleteBoard(num, writer, pwd);

//cnt가 1일 때 성공
if(cnt==1) {
	out.print("<script>alert('글이 삭제 되었습니다.');</script>");
}
//cnt가 0일 때 실패
else {
	out.print("<script>alert(`글 삭제에 실패했습니다. \n패스워드를 다시 확인해주세요.`);</script>");
} %>
<script>
location='boardList.jsp?pageNum=<%=pageNum%>';
</script>
</body>
</html>
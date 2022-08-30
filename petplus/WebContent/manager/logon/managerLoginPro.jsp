<%@page import="manager.logon.ManagerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인 처리</title>
</head>
<body>
<%
String managerId = request.getParameter("managerId");
String managerPwd =  request.getParameter("managerPwd");

ManagerDAO managerDAO = ManagerDAO.getInstance();
int cnt = managerDAO.checkManager(managerId, managerPwd);


out.print("<script>");
if(cnt == 1)  {
	session.setAttribute("managerId", managerId); //세션값 아이디
	out.print("alert('환영합니다.');location='../managerMain.jsp';");
} else {
	out.print("alert('관리자 계정이 아닙니다.');history.back();");
}
out.print("</script>");
%>
</body>
</html>
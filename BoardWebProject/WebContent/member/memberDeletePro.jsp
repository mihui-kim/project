<%@page import="member.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴 처리</title>
</head>
<body>
	<%
	String id=request.getParameter("id");
	String pwd=request.getParameter("pwd");
	
	MemberDAO memberDAO=MemberDAO.getInstance();
	int cnt=memberDAO.deleteMember(id, pwd);
	%>
	
	<script>
	<% if(cnt>0) { %>
		alert('탈퇴 처리 되었습니다. 이용해주셔서 감사합니다.');
		location='../logon/memberLoginForm.jsp';
	<% } else { %>
		alert(`탈퇴 처리 중 오류가 발생했습니다. \n잠시후 다시 시도해주세요.`);
		history.back();
	<% }%>
	</script>
</body>
</html>
<%@page import="mall.member.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberIdCheck</title>
</head>
<body>
	<%
	//ID 중복체크 처리페이지
	String id=request.getParameter("id");
	
	MemberDAO memberDAO = MemberDAO.getInstance();
	int cnt = memberDAO.checkId(id);
	%>
	
	<script>
	/* 가입 가능한 아이디 */
	<% if(cnt>0) { %>
		alert('사용 가능한 아이디 입니다.');
		
	/* 가입 불가능한 아이디 */
	<% } else { %>
		alert(`이미 존재하는 아이디입니다. \n다른 아이디를 입력해주세요.`);
	<% } %>
	
	history.back();
	</script>
	
</body>
</html>
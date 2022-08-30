<%@page import="mall.member.*"%>
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
	
	out.print("<script>");
	if(cnt>0) {
		session.removeAttribute("memberId");
		out.print("alert('탈퇴 처리 되었습니다. 이용해주셔서 감사합니다.');");
		out.print("location='../shopping/shopAll.jsp';");
	} else {
		out.print("alert(`탈퇴 처리 중 오류가 발생했습니다. \n잠시후 다시 시도해주세요.`);");
		out.print("	history.back();");
	}	
	out.print("</script>");
	%>
</body>
</html>
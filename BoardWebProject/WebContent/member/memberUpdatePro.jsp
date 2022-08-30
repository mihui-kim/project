<%@page import="member.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정 처리페이지</title>
</head>
<body>
	<%request.setCharacterEncoding("utf-8");%>
	
	<!-- 1단계 수정정보를 액션태그로 받음 -->
	<jsp:useBean id="member" class="member.MemberDTO"/>
	<jsp:setProperty property="*" name="member"/>
	
	<%
	String address2 =request.getParameter("address2");
	String address =member.getAddress()+" "+address2;
	member.setAddress(address);
	
	/* 2단계 DB테이블에 처리 */
	MemberDAO memberDAO =MemberDAO.getInstance();
	int cnt =memberDAO.updateMember(member);
	%>
	
	
	<script>
	<% if(cnt>0) { %>
		alert('회원정보 수정이 완료되었습니다.');
	<% } else { %>
		alert(`회원정보 수정에 실패하였습니다. \n잠시후 다시 시도해주세요.`);
	<% } %>
	history.back();
	</script>
	
</body>
</html>
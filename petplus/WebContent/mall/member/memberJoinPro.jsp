<%@page import="mall.member.*"%>
<%@page import="util.JDBCUtil"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 처리</title>
</head>
<body>
	<%request.setCharacterEncoding("utf-8");%>
	<!-- 액션태그로 값 받아오기 -->
	<jsp:useBean id="member" class="mall.member.MemberDTO"/>
	<jsp:setProperty property="*" name="member"/>
	
	<%
	/* 주소 합치기 (주소2상세주소는 bean에 안만들어서 request로 받아옴) */
	String address2=request.getParameter("address2");
	String address=member.getAddress()+address2;
	
	
	MemberDAO memberDAO=MemberDAO.getInstance();
	int cnt=memberDAO.insertMember(member);
	%>
	
	
	<script>
	/* cnt=1 데이터 추가 성공 */
	<% if(cnt>0) { %>
		alert('회원가입이 완료됬습니다.');
		location='../shopping/shopAll.jsp';
		
	/* cnt=1 데이터 추가 실패 */
	<% } else { %>
		alert(`회원가입 처리 중 오류가 발생했습니다. \n잠시후 다시 시도해주세요.`);
		history.back();
	<% } %>
	</script>
	
</body>
</html>
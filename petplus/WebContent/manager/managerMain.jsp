<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰 관리자 페이지</title>
<style>
	@font-face {
	    font-family: 'font1';
	    src: url('../icons/SuncheonB.ttf') format('truetype');
	}
	
	* {
		margin: 0;
		padding: 0;
	}
	body {
		border: 30px solid  #396e15;
		border-left: none;
		border-right: none;
	}	
	#container {
		width: 100%;
		height: 100%;
	}
	#container a {
		text-decoration: none;
	}
	
	
	/* 테이블 메뉴 */
	.f1 {
		width: 330px;
		margin: 100px auto;
		text-align: center;
		font-family: 'font1';
		border: 1px solid  #396e15; 
		border-radius: 5px;
		background: white;
	}
	.f1 #d1, .f1 #d2 {
		border-bottom: 1px solid #396e15; 
	}
	.f1 img {
		position: relative;
		top: 8px;
		padding-right: 5px;
	}
	ul {
		padding: 20px;
	}
	li {
		height: 50px;
		list-style: none;
		line-height: 50px;
		background: none;
	}
	li a {
		font-size: 1.1em;
		text-align: center;
		text-decoration: none;
		color:  #474747;
	}
	
	
</style>
</head>
<body>
	<%
	String managerId = (String)session.getAttribute("managerId");
	if(managerId == null) {
		out.print("<script>location='logon/managerLoginForm.jsp';</scripct>");
	}
	%>

 
<div id="container">
	<div class="f1">
		<div id="d1">
			<ul>
				<li><a href="product/productRegisterForm.jsp"><img src="../icons/a_add.png" width="25"> 상품 등록</a></li>
				<li><a href="product/productList.jsp"><img src="../icons/a_list.png" width="26"> 상품 목록</a></li>
			</ul>
		</div>
	</div>
</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 쇼핑몰 상단 페이지 : 쇼핑몰의 모든 페이지 상단에 포함되는 페이지 -->
<style>
	@font-face {
	    font-family: 'font1';
	    src: url('../../icons/SuncheonB.ttf') format('truetype');
	}
	@font-face {
	    font-family: 'font2';
	    src: url('../../icons/SuncheonR.ttf') format('truetype');
	}
	

	
	/* 전체레이아웃 */
	.guide {
		width: 100%;
		text-align: right;
		margin: 0 auto; 
	}
	.guide a {
		text-decoration: none;
		line-height: 40px;
		color: white;
		font-family: 'font2';
		font-weight: bold;
		font-size: 0.9em;
		position: relative;
		top: -40px;
		z-index: 1;
	}
	.top {
		text-align: center;
		width: 1200px;
		height: 200px;
		margin: 0 auto;
		text-align: center;
		overflow: visible;
		background-color: rgba(255,255,255,0.8);
	}
	.top a {
		text-decoration: none;
	}
	.title, .t_box1, .t_box2 {
		display: inline-block; padding: 1%;
	}
	
	
	/* 로고 */ 
	.title {
		font-family: 'font1';
		font-size: 3em; 
		float: left;
		padding: 0;
		margin: 60px 5px 0 0;
	}
	.title a {
		font-weight: bold;
		text-decoration: none; 
	}
	.title a #one {
		color: #fda73f
	}
	.title a #two {
		color: #396e15;
	}
	
	
	/* 메뉴 */ 
	.t_box1 {
		width: 60%; 
		background: none; 
		float: center;
		position: relative;
		margin-top: 40px;
	}
	.t_box1 div {
		display: inline-block; 
		margin: 25px 9px 0 23px;
		border-radius: 4px; 
	}
	.t_box1 a {
		color: #396e15;
		font-family: 'font2'; 
		font-size: 1.1em;
		font-weight: bold;
		margin: 20px;
	}
	.m_menu .s_menu {
		opacity: 0;
		position: absolute; 
		background: white; 
		top: 35px; 
		width: 120px; 
		border: 2px solid #396e15;
		text-align: center; 
		z-index: 20;
		transition: all 1s;
	}
	#s1 {
		left: -5px;
	}
	#s2 {
		left: 105px;
	}
	#s3 {
		left: 260px;
	}
	#s4 {
		left: 433px;
	}
	#s5 {
		left: 576px;
	}
	.m_menu .s_menu a {
		font-size: medium;
		display: block; 
		padding: 1px; 
	}
	.m_menu a:hover {
		color:  #fda73f
	}
	.m_menu:hover .s_menu {
		opacity: 1;
	}
	.m_menu .s_menu a:hover {
		color:  #fda73f
	}
	

	/* 계정, 결제, 장바구니 */ 
	.t_box2 {
		display: inline-block; 
		float: right; 
		margin: 60px 0 0 15px;
	}
	
	
</style>
<body>

<%
String memberId = (String)session.getAttribute("memberId");
%>
<div class="guide">
	<%if(memberId == null) {%>
		<a href="../logon/memberLoginForm.jsp"><span>로그인</span></a>&emsp;
		<a href="../member/memberJoinForm.jsp"><span>회원가입</span></a>&emsp; 
	<%} else {%>
		<a href="../member/memberInfoForm.jsp"><%=memberId%>님</a>&emsp;<a href="../logon/memberLogout.jsp">로그아웃</a>&emsp;
	<%} %>
	<a href=""><span>고객센터</span></a>
</div>
 
<div class="top">
		<div class="title"><a href="../shopping/shopAll.jsp"><span id="one">Pet</span> <span id="two">Plus+</span></a></div>
		<!-- 메뉴 -->
		<div class="t_box1"> 
			<div class="m_menu"><a href="#">의류</a>			<!-- 100번대 main -->
				<div class="s_menu" id="s1">
					<a href="shopAll.jsp?product_kind=110#t_kind">나시</a>
					<a href="shopAll.jsp?product_kind=120#t_kind">탑</a>
					<a href="shopAll.jsp?product_kind=130#t_kind">후디</a>
					<a href="shopAll.jsp?product_kind=140#t_kind">아우터</a>
					<a href="shopAll.jsp?product_kind=150#t_kind">올인원</a>
				</div>
			</div>
			<div class="m_menu"><a href="#">식품</a>				<!-- 200번대 main -->
				<div class="s_menu" id="s2">
					<a href="shopAll.jsp?product_kind=210#t_kind">껌</a>		
					<a href="shopAll.jsp?product_kind=220#t_kind">캔/파우치</a>			
					<a href="shopAll.jsp?product_kind=230#t_kind">음료</a>
					<a href="shopAll.jsp?product_kind=240#t_kind">수제간식</a>
					<a href="shopAll.jsp?product_kind=250#t_kind">사료</a>
				</div>
			</div>
			<div class="m_menu"><a href="#">장난감/악세사리</a>		<!-- 300번대 main -->
				<div class="s_menu" id="s3">
					<a href="shopAll.jsp?product_kind=310#t_kind">봉제인형</a>
					<a href="shopAll.jsp?product_kind=320#t_kind">고무인형</a>
					<a href="shopAll.jsp?product_kind=330#t_kind">하네스/리드줄</a>
					<a href="shopAll.jsp?product_kind=340#t_kind">액세사리</a>
					<a href="shopAll.jsp?product_kind=350#t_kind">노즈워크</a>
				</div>
			</div>
			<div class="m_menu"><a href="#">위생용품</a>			<!-- 400번대 main -->
				<div class="s_menu" id="s4"> 
					<a href="shopAll.jsp?product_kind=410#t_kind">배변</a>
					<a href="shopAll.jsp?product_kind=420#t_kind">탈취</a>
					<a href="shopAll.jsp?product_kind=430#t_kind">치아</a>
					<a href="shopAll.jsp?product_kind=440#t_kind">눈/귀</a>
					<a href="shopAll.jsp?product_kind=450#t_kind">미용/목욕</a>
				</div>
			</div>
			<div class="m_menu"><a href="#">리빙용품</a>			<!-- 500번대 main -->
				<div class="s_menu" id="s5">
					<a href="shopAll.jsp?product_kind=510#t_kind">식기</a>
					<a href="shopAll.jsp?product_kind=520#t_kind">하우스</a>
					<a href="shopAll.jsp?product_kind=530#t_kind">이동가방</a>
					<a href="shopAll.jsp?product_kind=540#t_kind">방석/매트</a>
					<a href="shopAll.jsp?product_kind=550#t_kind">가전제품</a>
				</div>
			</div>
		</div>
		<!-- 계정, 결제, 장바구니 -->
		<div class="t_box2"> 
			<a href="../member/memberInfoForm.jsp"><img src="../../icons/t_user.png" width="32" title="회원정보">&emsp;&emsp;</a>
			<a href="../buy/buyForm.jsp"><img src="../../icons/t_buy.png" width="32" title="구매정보">&emsp;&emsp;</a>
			<a href="../cart/cartList.jsp"><img src="../../icons/t_cart.png" width="32" title="장바구니정보"></a>
			</div>
</div>
</body>
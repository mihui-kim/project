<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="mall.member.*, mall.cart.*, java.util.*, java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<style>
	@font-face {
	    font-family: 'font1';
	    src: url('../../icons/SuncheonB.ttf') format('truetype');
	}
	@font-face {
	    font-family: 'font2';
	    src: url('../../icons/SuncheonR.ttf') format('truetype');
	}
	@font-face {
	    font-family: 'font3';
	    src: url('../../icons/NanumSquareR.ttf') format('truetype');
	}
	@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
	

	/* 상단 d1 */
	* {
		margin: 0;
		padding: 0;
	}
	body {
		border: 40px solid #fda73f;
	}
	footer {
		width: 1200px;
		margin: 100px auto 50px;
	}
	#container {
		width: 1200px; 
		margin: 0 auto;
		color:  #444444; 
	}
	
	
	/* 상단 */
	.area1 {
		width: 100%; 
		margin: 50px auto 80px;
		float:left;
		font-family: 'font1'; 
		font-size: 1.4em;
	}


	/* 중단 - 테이블 */
	.area2 { 
		width: 100%; 
		margin: 0 auto; 
		text-align: center;
		border: hidden;
		border-collapse: collapse; 
		border-left: none; 
		border-right:none; 
		font-family: 'font1';
	}
	.area2 #zerobag {
		text-align: center;
	}
	.area2 tr {
		height: 60px;
	}
	.area2 th {
		font-weight: lighter;
	}
	.area2 td { 
		border: 1px solid #c7c7c6;
		border-left: hidden;
		border-right: hidden;
	}
	.area2 th:first-child {
		padding-left: 10px;
	}
	.area2 th:first-child, .area2 td:first-child, .area2 td:nth-child(2) {
		text-align: left;
	}
	.area2 td a {
		text-decoration: none;
		color: #444444; 
	}
	.area2 .order {
		width: 50px; 
		height: 30px;
		border: 1px solid #c7c7c6;
		border-radius: 5px;
		text-align: center;
	}
	.btn_delete, .btn_update {
		background: none;
		border: none;
		color: gray;
		font-size: 0.8em;
		font-family: 'font3';
		margin: 10px;
		cursor: pointer;
	}
	.area2 input[type="number"]::-webkit-inner-spin-button, .area2 input[type="number"]::-webkit-outer-spin-button {
		-webkit-appearance: "Always Show Up/Down Arrows"; 
		opacity:1;
	}
	.area2 input:focus {
		outline-color: green;
	}
	
	
	/* 하단 - 테이블 */
	.area3 {
		width: 40%;
		margin: 80px 60px;
		float: right;
		text-align: right;
		font-family: 'font1'; 
	}
	.area3 tr {
		height: 50px;
	}
	.area3 tr:nth-child(3) {
		height: 5px;
	}
	.area3 th {
		border-top: 1px solid #ccc;
		font-weight: lighter;
	}
	.area3 #info_address {
		text-align: right;
		font-size: 0.8em;
		font-family: 'font3';
	}
	.area3 #btn_buy {
		width: 150px;
		height: 50px;
		margin: 60px 0;
		background: #396e15; 
		border: none;
		border-radius: 5px;
		color: white;
		font-family: 'font1';
		font-size: 1em;
		cursor: pointer;
	}
	.area3 #btn_buy:focus {
		outline: none;
	}
</style>

<script>
	document.addEventListener("DOMContentLoaded", function() {
		
		// 카트 아이디 태그의 배열
		let form = document.cartForm;
		let cart_ids = document.getElementsByName("cart_id");	
		let cart_ids_list = [];	//카트 아이디를 저장하는 배열
		
		
		// 삭제 처리 (각각의 상품)
		let btn_delete = document.querySelectorAll(".btn_delete");	
		for(let i=0; i<btn_delete.length; i++) {
			btn_delete[i].addEventListener("click", function() {
				location = 'cartDeletePro.jsp?cart_id=' + cart_ids[i].value;
			})
		}
		
		// 주문 버튼 처리 
		let btn_buy = document.getElementById("btn_buy");
		let exist = document.getElementById("exist");
		btn_buy.addEventListener("click", function() {
			if(exist == null) {
				alert('장바구니에 상품이 없습니다.');
				return;
			} else {
				location = '../buy/buyForm.jsp'; 
			}
		})


	})
	
</script>
</head>
<body>
	<%
	
	// 세션 연결
	request.setCharacterEncoding("utf-8");
	
	String memberId = (String)session.getAttribute("memberId");
	if(memberId == null) {
		out.print("<script>alert('로그인을 해주세요');");
		out.print("location='../logon/memberLoginForm.jsp';</script>");
		return;
	}
	
	// 숫자 표기 지정
	DecimalFormat df = new DecimalFormat("#,###,###");
	
	
	// 회원 DB 연결 & 질의 (주소정보 활용)
	MemberDAO memberDAO = MemberDAO.getInstance();
	MemberDTO member = memberDAO.getMember(memberId);
	String address = member.getAddress();
	String local = address.substring(0, 2);

	
	// 장바구니 DB 연결, 질의
	CartDAO cartDAO = CartDAO.getInstance();
	List<CartDTO> cartList = cartDAO.getCartList(memberId);
	int cartListCount = cartDAO.getCartListCount(memberId);
	
	
	// 상품 계산
	int price = 0;			//판매가
	int order = 0;			//주문 수량
	int count = 0;			//상품 수량 
	int delivery = 0;		//배송비
	int sum = 0;			//판매가 합계 (각각의 상품)
	int total = 0; 			//판매가 합계 (모든 상품)
	%>

<div id="container">
	<div>
		<header><jsp:include page="../common/shopTop.jsp"></jsp:include></header>
	</div>
	<div class="area1">장바구니</div>

	<table class="area2">
		<tr>
			<th colspan="2">상품 정보</th>
			<th width="15%">수량</th>
			<th width="15%">가격</th>
		</tr>
		
		<%if(cartListCount == 0) {%>
		<tr><td colspan="5">장바구니에 상품이 없습니다.</td></tr>
		
		<%} else { %>
			<%for(CartDTO cart : cartList) {
				price = cart.getBuy_price();
				order = cart.getBuy_count();
				
				sum = price * order;
				total += sum;
				
				++count;
				
				//배송비 계산
				if(local.equals("제주")) {
					delivery = 3000;
				} else {
					delivery = 0;
				}
				%>
				
		<form action="cartUpdatePro.jsp" method="post" name="cartForm">
			<input type="hidden" name="cart_id" value="<%=cart.getCart_id() %>">
			<input type="hidden" name="product_id" value="<%=cart.getProduct_id() %>">
			<input type="hidden" name="sum" value="<%=sum %>">
			<tr>
				<td width="10%" id="exist">
					<a href="../shopping/shopContent.jsp?product_id=<%=cart.getProduct_id()%>"><img src=<%="/images_petplus/"+cart.getProduct_image()%> width="100" height="120"></a>

				</td>
				<td width="45%">	
					<span>「 <a href="../shopping/shopContent.jsp?product_id=<%=cart.getProduct_id()%>"><%=cart.getProduct_name() %></a> 」</span><br>
					<input type="button" name="btn_delete" class="btn_delete" value="삭제하기">
				</td>
				<td>
					<input type="number" name="order" value="<%=order%>" class="order" min="1" max="100"><br>
					<input type="submit" name="update" value="변경하기"  class="btn_update">
				</td>
				<td><%=df.format(sum) %>원</td>
			</tr>
		</form>
	<%} }%>
	</table>
	<table  class="area3">
		<tr>
			<td width="30%">상품 합계  (<%=count %>)</td>
			<td width="70%"><%=df.format(total) %>원</td>
		</tr>
		<tr>
			<td>배송비</td>
			<td><%=df.format(delivery) %>원</td>
		</tr>
		<tr>
			<td colspan="2" id="info_address">등록된 주소 : <%=address %>🔺</td>
		</tr>
		<tr>
			<th>결제 금액</th>
			<th><%=df.format(total+delivery) %>원</th>
		</tr>
		<tr>
			<td colspan="2"><input type="button" value="주문하기" id="btn_buy"></td>
		</tr>
	</table>
</div>
<footer><jsp:include page="../common/shopBottom.jsp"></jsp:include></footer>
</body>
</html>
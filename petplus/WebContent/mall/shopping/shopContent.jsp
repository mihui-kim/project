<%@page import="java.util.*"%>
<%@page import="mall.member.*"%>
<%@page import="java.text.*"%>
<%@page import="manager.product.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세보기</title>
<style>
	@font-face {
	    font-family: 'font2';
	    src: url('../../icons/SuncheonR.ttf') format('truetype');
	}
	@font-face {
	    font-family: 'font3';
	    src: url('../../icons/NanumSquareR.ttf') format('truetype');
	}
	* {
		margin: 0;
		padding: 0;
	}
	body {
		border: 40px solid #fda73f;
	}
	.container {
		width: 1200px; 
		margin: 0 auto; 
		font-family: 'font2';
	}
	header { 
		width: 100%;
	}
	.menu {
		font-family: 'font2';
		font-weight: bold;
		margin: 20px;
	}
	.menu a {
		text-decoration: none; 
		color: gray;
	}
	.menu:hover {
		font-weight: bold;
	}

		
	/* c_title -> 왼쪽 이미지 */
	.s1 {
		width: 55%; 
		float: left; 
		text-align: center;
		position: relative;
		top: 50px;
	}

	/* c_title -> 오른쪽 상품정보 */
	.s2 {
		font-family: 'font2';
		font-weight: bold;
		font-size: 0.8em;
		color :  #396e15;
		width: 45%; 
		float: left;
		margin-top: 30px;
	}
	.s2 div {
		margin: 20px;
	}
	.s2_d1 {
		font-size: 1.6em;
	}
	.s2_d2 {
		padding-left: 10px;
		font-size: 1.5em;
		color:  #f7a035; 
	}
	.s2_d2 #bf {
		text-decoration: line-through;
		color: gray;
	}
	.s2_d3, .s2_d4, .s2_d5, .s2_d6 {
		font-family: 'font3';
		font-weight: normal;
		font-size: 1.1em;
		padding-left: 10px;
		color: gray;
	}
	.s2_d3 p, .s2_d4 p {
		padding: 8px;
		padding-left: 70px;
	}
	.s2_d5 #buy_count {
		border: 2px solid #ccc;
		border-radius: 5px;
		width: 50px;
		height: 25px;
		color: gray;
		text-align: center;
	}
	.s2_d5 #buy_count:focus {
		outline: none;
	} 
	.s2_d6 input[type="radio"] {
		accent-color: green;
		position: relative;
		top: 3px;
	}
	.btns input[type='submit'] {
		width: 155px; 
		height: 50px;
		border: 0; 
		border-radius: 4px;
		font-size: 1em; 
		font-family: 'font2';
		font-weight: bold; 
		cursor: pointer;
	}
	.btns #btn_cart { 
		border: 2px solid  #396e15;
		background: white;
		color: #396e15;
		margin-right: 15px;
	}
	.btns #btn_buy { 
		border: 2px solid  #396e15;
		background: #396e15;
		color: white;
	}
	
	/* 하위메뉴 */
	hr {
		border: 1px solid #ccc;
	}
	.s3 {
		clear: both;
	}
	.c_title {
		height: 700px;
	}
	.c_detail {
        position:sticky;            
        top:0px;
		text-align: center; 
		line-height: 70px;
		margin-bottom: 30px;
		border-bottom: 3px solid #396e15;;
		color: #396e15;
		background: white;
		font-size: 1em; 
		font-family: 'font2';
		font-weight: bold; 
		cursor: pointer;
	}
	.c_detail span {
		margin: 50px;
	}
	.s3 span {
		padding: 50px;
	}
	.s3_c2 {
		text-align: center; 
		padding: 15px;
	}
	.s3_c3 .s3_review {
		line-height: 27px; 
		text-align: justify; 
		width: 100%; 
		height: 300px;
	}
	.s3_review .s3_r1 {
		width: 74%; 
		float: left; 
		padding: 20px;
	}
	.s3_r1 .s3_subject {
		font-size: 1.1em; 
		font-weight: bold; 
		margin-bottom: 8px;
	}
	.s3_r1 .s3_content {
		height: 150px;
	}
	.s3_r1 .s3_content_all, .s3_r1 .s3_content_part {
		font-size: 0.9em; 
		color:  #396e15;
		font-weight: bold; 
		cursor: pointer; 
	}
	.s3_r1 .s3_content_part {
		display: none;
	}
	.s3_review .s3_r2 {
		width: 16%; 
		height: 150px; 
		float: right; 
		border: none; 
		color: gray; 
		font-size: small; 
		position: relative; 
		top: 50px;
	}
	.s2_r2 {
		font-size: 0.9em; 
		color: gray; 
		height: 175px;
	}
	input[type=number]::-webkit-inner-spin-button, 
	input[type=number]::-webkit-outer-spin-button { 
		-webkit-appearance: "Always Show Up/Down Arrows"; 
		opacity: 1;
	}
	
	/* 페이징처리 */
	#paging {
		clear: both; 
		text-align: center; 
	}
	.pBox_c {
		background:  #a97727; 
		color: white; 
		border-radius: 7px;
	}
</style>
<script>
 	document.addEventListener("DOMContentLoaded", function() {
 		
		
		//상품 수량을 1이상 100 미만으로 제한하는 효과
		let buy_count = document.getElementById("buy_count");
		buy_count.addEventListener("keyup", function(event) {
			if(buy_count.value < 1) {
				buy_count.value = 1;
			}
			else if(buy_count.value > 100) {
				buy_count.value = 100;
			}
		}) 
		
		
 		//하단 - 상세설명, 상품리뷰 변환 효과
		let s3_c2 = document.querySelector(".s3_c2");
		let s3_c3 = document.querySelector(".s3_c3");
		let ss1 = document.querySelector(".ss1");
		let ss2 = document.querySelector(".ss2");
		s3_c3.style.display = "none";
		
		ss1.addEventListener("click", function() {
			s3_c2.style.display = "block";
			s3_c3.style.display = "none";
		}) 
		ss2.addEventListener("click", function() {
			s3_c2.style.display = "none";
			s3_c3.style.display = "block";
		}) 
		
			
		//내용 전체 보기 효과
/* 		let content = document.querySelectorAll(".s3_content");
		let content_all = document.querySelectorAll(".s3_content_all");
		let content_part = document.querySelectorAll(".s3_content_part");
		
		for(let i in content_all) {
			content_all[i].addEventListener("click", function() {
				content[i].style.overflow="visible";
				content[i].style.height="200px";
				content[i].style.display="block";
				content_part[i].style.display="block";
			})
		}    */
		

		

	}) 
</script>
<script>
	<%
	String memberId = (String)session.getAttribute("memberId");
	int product_id = Integer.parseInt(request.getParameter("product_id"));
	
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	DecimalFormat df = new DecimalFormat("#,###,###");
	
	
	//상품 DB연결, 질의 
	ProductDAO productDAO = ProductDAO.getInstance();
	ProductDTO product = productDAO.getProduct(product_id);
	
	//회원 DB연결, 질의 
	MemberDAO memberDAO = null;
	MemberDTO member = null;

	
	//배송 날짜 계산과 포맷 
	String name = null;
	String address = null;
	String local = null;
	String d_day = null;
	
	//조건 : 현재날짜, 12시이후이전, 주소, 요일 판단이 필요함
	int n = 0;
	Calendar c = Calendar.getInstance();
	int hour = c.get(Calendar.HOUR_OF_DAY); //(0~24시 표시함수 사용)
	int w = c.get(Calendar.DAY_OF_WEEK); //(1~7 일~토 표시함수 사용)

	
	if(memberId != null) {
		memberDAO = MemberDAO.getInstance();
		member = memberDAO.getMember(memberId);
		name = member.getName();
		address = member.getAddress();
		local = address.substring(0,2); //주소에서 지역 2글자마 추출 
		
		//규칙: 서울-다음날 배송, 경기-2일 안에 배송, 지방-3일 안에 배송, 제주도-10일 안에 배송 
		switch(local) {
		case "서울": 
			if(w>=2 && w<=5) ++n;
			else if(w==6 || w==7) n+=3;
			else if(w==1) n+=2;
			break;
		case "경기":
			if(w>=2 && w<=4) n+=2;
			else if(w>=5 && w<=7) n+=4;
			else if(w==1) n+=3;
			break;
		case "제주":
			n+=7;
			break;
		default:
			if(w==2 || w==3) n+=3;
			else if(w>=4 && w<=6) n+=5;
			else if(w==1) n+=4;
			break;
		}
	}	
	
	//추가된 일수를 더한 날짜
	c.add(Calendar.DATE, n);
	int month = c.get(Calendar.MONTH) +1; //0~11로 표현, 1일 더해서 보정
	int date = c.get(Calendar.DATE);
	int week = c.get(Calendar.DAY_OF_WEEK);
	String[] weekday = {"", "일", "월", "화", "수", "목", "금", "토"};
	
	//배송일 확인
	d_day = month +"월"+date+"일"+"("+weekday[week]+")";
	
	
 	//-----------------------------------------------------------------------------페이징 처리
	/* 변수 선언 */
	int pageSize=4; 									 //1페이지에 4건의 게시글을 보여줌
	String pageNum=request.getParameter("pageNum");
	
	if(pageNum==null) pageNum="1";
	
	int currentPage=Integer.parseInt(pageNum); 			 //현재 페이지
	int startRow = (currentPage -1) * pageSize+1; 		 //현재 페이지의 첫번째 행
	int endRow=currentPage * pageSize;					 //현재 페이지의 마지막 행
	//------------------------------------------------------------------------------ 
	


	
	//상품 분류별 상품명 설정 
	String product_kindName = ""; 
	String product_kind = product.getProduct_kind();
	switch(product_kind) {
	case "110" : product_kindName = "나시"; break;
	case "120" : product_kindName = "탑"; break;
	case "130" : product_kindName = "후디"; break;
	case "140" : product_kindName = "아우터"; break;
	case "150" : product_kindName = "올인원"; break;
	case "210" : product_kindName = "껌"; break;
	case "220" : product_kindName = "캔·파우치"; break;
	case "230" : product_kindName = "음료"; break;
	case "240" : product_kindName = "수제간식"; break;
	case "250" : product_kindName = "사료"; break;
	case "310" : product_kindName = "봉제인형"; break;
	case "320" : product_kindName = "고무인형"; break;
	case "330" : product_kindName = "하네스·리드줄"; break;
	case "340" : product_kindName = "악세사리"; break;
	case "350" : product_kindName = "노즈워크"; break;
	case "410" : product_kindName = "배변"; break;
	case "420" : product_kindName = "탈취"; break;
	case "430" : product_kindName = "치아"; break;
	case "440" : product_kindName = "눈·귀"; break;
	case "450" : product_kindName = "미용·목욕"; break;
	case "510" : product_kindName = "식기"; break;
	case "520" : product_kindName = "하우스"; break;
	case "530" : product_kindName = "이동가방"; break;
	case "540" : product_kindName = "방석·매트"; break;
	case "550" : product_kindName = "가전제품"; break;
	}
	
	
	//판매가 계산 
	int price = product.getProduct_price();
	int d_rate = product.getDiscount_rate();
	int sale_price = price - (price*d_rate/100);
	
	%>
</script>
</head>
<body>

<div class="container">
<header><jsp:include page="../common/shopTop.jsp"/></header>
	<div class="menu"><a href="shopAll.jsp#t_kind">홈></a>&ensp;<a href="shopAll.jsp?product_kind=<%=product_kind%>#t_kind"><%=product_kindName%></a></div>
	
	<div class="c_title">
		<!-- 구역1 : 왼쪽 상단, 상품이미지 -->
		<div class="s1">
			<img src=<%="/images_petplus/"+product.getProduct_image()%> width="400" height="450">
		</div>
		
		<!-- 구역2 : 오른쪽 상단, 상품 기본 정보, 버튼 -->
		<div class="s2">
			<form action="../cart/cartInsertPro.jsp" method="post" name="contentForm">
			<!-- 장바구니로 이동하는 필드 정보 -->
			<input type="hidden" name="buyer_id" value="<%=memberId%>">
			<input type="hidden" name="product_id" value="<%=product_id%>">
			<input type="hidden" name="product_name" value="<%=product.getProduct_name()%>">
			<input type="hidden" name="product_price" value="<%=product.getProduct_price()%>">
			<input type="hidden" name="discount_rate" value="<%=product.getDiscount_rate()%>">
			<input type="hidden" name="buy_price" value="<%=sale_price%>">
			<input type="hidden" name="product_image" value="<%=product.getProduct_image()%>">
			
			<div class="s2_d1">「 <%=product.getProduct_name()%> 」</div><br>
			<div class="s2_d2"><span><b><%=df.format(sale_price)%>원 (<%=product.getDiscount_rate()%>%)</b> <span id="bf"><%=df.format(price)%>원</span></span></div><br>
			<div class="s2_d3">배송기간&ensp;|&ensp;
				<%if(memberId != null) {%><span><%=name%>님의 등록된 주소로  <%=d_day%>까지 배송됩니다.</span><p>[주소 : <%=address%>]</p>
				<%} else {%><span>평균 1~3 영업일</span><%} %>
			</div>
			<div class="s2_d4">배송방법&ensp;|&ensp; 택배 <p>[기본 무료배송 / 제주도 3,000원 부과]</p></div>
			
			<div class="s2_d5">수량&emsp;&emsp;<input type="number" name="buy_count" id="buy_count" value="1" max="100" min="1"></div>
			<div class="s2_d6">
				<%if(product_id <= 150) {%>
				사이즈&emsp;
				<input type="radio" name="size" id="s_size" value="S" checked><label for="s_size"> S</label>&emsp;
				<input type="radio" name="size" id="m_size" value="M" ><label for="m_size"> M</label>&emsp;
				<input type="radio" name="size" id="l_size" value="L" ><label for="l_size"> L</label>
				<%} else {%>
				<input type="hidden">
				<%} %>
			</div><br>
			<hr>
			<div class="btns">
				<input type="submit" value="장바구니" id="btn_cart">
				<input type="submit" value="구매" id="btn_buy">
			</div>
			</form>
		</div>
	</div>
	
	<jsp:include page="../common/shopBottom.jsp"/>
</div>
</body>
</html>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.*"%>
<%@page import="manager.product.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
    
<!-- 쇼핑몰 메인 페이지 : 상품 나열되는 페이지 -->
<!-- 상품의 분류별 전체보기 -->
<style>
	@font-face {
	    font-family: 'font1';
	    src: url('../../icons/SuncheonB.ttf') format('truetype');
	}
	@font-face {
	    font-family: 'font2';
	    src: url('../../icons/SuncheonR.ttf') format('truetype');
	}
	
	input:-webkit-autofill {
		-webkit-box-shadow: 0 0 0 1000px white inset; 
		box-shadow: 0 0 0 1000px white inset;
	}
	
	/* 상품 분류 */
	.d_kind1 {
		text-align: right; 
		margin-bottom: 20px;
	}
	.d_kind1 .s_kind1 {	
		text-align: center;
		color: #4a8422; 
		width: 340px; 
		height: 20px; 
		margin: 0 auto; 
		padding: 10px; 
		font-family: 'font1'; 
		font-size: 1.3em;
	}
	#s1 {
		margin-top: 40px;
	}
	#s2 {
		margin-bottom: 40px;
	}
	.d_kind1 .s_kind2 select {
		text-align: center;
		font-size: 1em;
		font-family: 'font1'; 
		color: #396e15;
		border: 2px solid  #396e15; 
		border-radius: 5px;
		width: 110px; 
		height: 30px;
		outline: none;
	}
	.d_kind2 {
		clear: both; 
		font-family: 'font2';
		font-weight: bold;
		color:  #396e15; 
		padding: 10px 10px 4px 4px; 
		margin-left: 40px;
		float: left;
	}
	.d_kind2 .cnt {
		color: #f7a035;
	}
	.s_kind2 {
		margin-right: 40px;
	}
	
	
	/* 상품 분류별 노출 */
	.d_kind3 {
		margin-bottom: 0; 
		position:relative; 
		float: left; 
		text-align: center; 
		font-family: 'font2';
		font-size: 1em; 
	}
	.d_kind3 a {
		text-decoration: none; 
		color: gray;
	}
	.c_product {
		font-weight: bold;
		display: inline-block; 
		width: 240px; 
		heigth: 335px; 
		padding: 4px; 
		margin: 25px;
	}
	.c_product .c_p1 {
		border: 1px solid #e2e2e2; 
		border-radius: 10px; 
		height: 246px;  
		overflow: hidden;
	}
	.c_product .c_p2, .c_product .c_p4 {
		color: #5f5f5d;
	}
	.c_product .c_p3 {
		color:  #f7a035; 
	}
	.c_product .c_p2, .c_product .c_p3 {
		padding: 8px;
		white-space: nowrap; 
		overflow: hidden; 
		text-overflow: ellipsis;
	}
	.c_product .basicPrice {
		text-decoration: line-through; color: #5f5f5d;
	}
	
	
	/* 상품 hover 효과 */
	.d_kind3 .c_product2 .c_p4 {
		display: none;
	}
	.d_kind3 .c_product2 {
		position: absolute; 
		top: 8px; 
		left: 9px; 
		text-align: center;  
		border: 1px solid #ccc;
		border-radius: 10px;
		display: inline-block; 
		width: 230px; 
		height: 239px; 
		padding: 4px; 
		margin: 20px;
		transition: all 1s;
	}
	.d_kind3:hover .c_product2 {
		display: inline-block;
		background: rgb(57,110,21,0.3);
	}
	.d_kind3:hover .c_p4 {
		display: inline-block; 
		width: 72px; 
		height: 66px;
		background: rgb(255,255,255, 0.8); 
		border: 2px solid  #396e15;  
		border-radius: 50%; 
		margin: 90px 4px 0 4px;
		line-height: 64px; 
		font-size: 0.9em; 
		font-family: 'font2';
		font-weight: bold;
		transition: all 1s;
	}
	.d_kind3:hover .c_p4 a {
	 	color: #396e15; 
	}
	
												 
	/* 하단  : 페이징 처리 */
	#paging {
		font-family: 'font2';
		font-weight: bold;
		text-align: center; 
		color: gray; 
		clear: both; 
		padding: 20px 0;
	}
	#paging a {
		color: #396e15;
	}
	.pBox_c {
		background: white; 
		color: #396e15; 
		border-radius: 5px; 
		border: 2px solid #396e15;
	}
	#pBox {
		display: inline-block; 
		width: 20px; 
		height: 20px; 
		padding: 4px; 
		margin: 4px; 
		font-family: 'font2';
		font-size: 1em;
	}
	.main_end {
		margin: 20px 0;
	}
	
	hr {
		clear: both; 
		margin: 20px 0; 
		background: #e2e2e2; 
		border: none; 
		height: 1px;
	}

</style>
<script>
document.addEventListener("DOMContentLoaded", function() {
	let product_kind = document.getElementById("product_kind");
	
	//상품 분류 선택에 대한 change 이벤트 처리
	product_kind.addEventListener("change", function() {
		//product_kind를 가지고 shopAll.jsp로 이동
		location = 'shopAll.jsp?product_kind=' + product_kind.value + "#t_kind";
	})
	
})

</script>

<%
request.setCharacterEncoding("utf-8");
String product_kind = request.getParameter("product_kind");
if(product_kind == null) product_kind = "110";

//상품 분류별 상품명 설정
String product_kindName = ""; 
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

//-----------------------------------------------------------------------------페이징(paging)처리
/* 변수 선언 */
int pageSize=16; 									 //1페이지에 14건의 게시글을 보여줌
String pageNum=request.getParameter("pageNum");

if(pageNum==null) pageNum="1";

int currentPage=Integer.parseInt(pageNum); 			 //현재 페이지
int startRow = (currentPage -1) * pageSize+1; 		 //현재 페이지의 첫번째 행
int endRow=currentPage * pageSize;					 //현재 페이지의 마지막 행
//------------------------------------------------------------------------------

DecimalFormat df = new DecimalFormat("#,###,###");

ProductDAO productDAO = ProductDAO.getInstance();

//분류별 상품에 대한 페이징 처리
List<ProductDTO> productList = productDAO.getProductList(startRow, pageSize, product_kind);
int cnt = productDAO.getProductCount(product_kind);

/*  for(ProductDTO product : productList) {
	System.out.println(product);
}  */
%>
<!-- 분류별 상품을 4개씩 3단으로 처리 -->
<div class="t_kind" id="t_kind">
	<hr>
	<div class="d_kind1">
		<div class="s_kind1" id="s1"><b>CATEGORY</b></div>
		<div class="s_kind1" id="s2">「 <%=product_kindName%> 」</div>
		<div class="d_kind2">상품 수량 : 총  <b class="cnt"><%=cnt%></b>건</div>
		<span class="s_kind2">
			<select id="product_kind">
				<option value="110" <%if(product_kind.equals("110")) {%> selected <%} %>>나시</option>
				<option value="120" <%if(product_kind.equals("120")) {%> selected <%} %>>탑</option>
				<option value="130" <%if(product_kind.equals("130")) {%> selected <%} %>>후디</option>
				<option value="140" <%if(product_kind.equals("140")) {%> selected <%} %>>아우터</option>
				<option value="150" <%if(product_kind.equals("150")) {%> selected <%} %>>올인원</option>
				<option value="210" <%if(product_kind.equals("210")) {%> selected <%} %>>껌</option>
				<option value="220" <%if(product_kind.equals("220")) {%> selected <%} %>>캔·파우치</option>
				<option value="230" <%if(product_kind.equals("230")) {%> selected <%} %>>음료</option>
				<option value="240" <%if(product_kind.equals("240")) {%> selected <%} %>>수제간식</option>
				<option value="250" <%if(product_kind.equals("250")) {%> selected <%} %>>사료</option>
				<option value="310" <%if(product_kind.equals("310")) {%> selected <%} %>>봉제인형</option>
				<option value="320" <%if(product_kind.equals("320")) {%> selected <%} %>>고무인형</option>
				<option value="330" <%if(product_kind.equals("330")) {%> selected <%} %>>하네스·리드줄</option>
				<option value="340" <%if(product_kind.equals("340")) {%> selected <%} %>>악세사리</option>
				<option value="350" <%if(product_kind.equals("350")) {%> selected <%} %>>노즈워크</option>
				<option value="410" <%if(product_kind.equals("410")) {%> selected <%} %>>배변</option>
				<option value="420" <%if(product_kind.equals("420")) {%> selected <%} %>>탈취</option>
				<option value="430" <%if(product_kind.equals("430")) {%> selected <%} %>>치아</option>
				<option value="440" <%if(product_kind.equals("440")) {%> selected <%} %>>눈·귀</option>
				<option value="450" <%if(product_kind.equals("450")) {%> selected <%} %>>미용·목욕</option>
				<option value="510" <%if(product_kind.equals("510")) {%> selected <%} %>>배변</option>
				<option value="520" <%if(product_kind.equals("520")) {%> selected <%} %>>탈취</option>
				<option value="530" <%if(product_kind.equals("530")) {%> selected <%} %>>치아</option>
				<option value="540" <%if(product_kind.equals("540")) {%> selected <%} %>>눈·귀</option>
				<option value="550" <%if(product_kind.equals("550")) {%> selected <%} %>>미용·목욕</option>
			</select>
		</span>
	</div>
</div>	
	<%for(ProductDTO product : productList) {%>
	<div class="d_kind3">
		<div class="c_product">
			<div class="c_p1"><img src=<%="/images_petplus/"+product.getProduct_image()%> width="240" height="255"></div><br>
			<div class="c_p2"><span title="<%=product.getProduct_name()%>"><%=product.getProduct_name()%></span></div>
			<div class="c_p3"><span><%=df.format(product.getProduct_price()*0.9)%>원</span> <span class="basicPrice"><%=product.getProduct_price()%>원</span></div>
		</div>	
		<div class="c_product2">
			<div class="c_p4"><a href="shopContent.jsp?product_id=<%=product.getProduct_id()%>">상세보기</a></div>
		</div>
	</div>
	<%}%>
	
	<div id="paging">
		<%
		/* 하단 : 페이징 처리 */
		if(cnt>0) {
			int pageCount=(cnt/pageSize) + (cnt%pageSize==0? 0:1);	//전체 페이지 수, 뒷자리 1~10이면 한페이지를 어차피 추가해야 하므로 나머지가 0이 아닐 때는 1을 더해준다
			int startPage=1;										//시작 페이지 번호
			int pageBlock=4;										//페이징의 개수, 화면에서 보이는 페이지 목록 범위
			
			/* 시작 페이지 설정 */
			if(currentPage%4 != 0) startPage=(currentPage/4)*4+1;
			else startPage=(currentPage/4-1) * 4 + 1;
			
			/* 끝 페이지 설정 */
			int endPage = startPage + pageBlock - 1;
			if(endPage > pageCount) endPage = pageCount;			//마지막 페이지보다 큰 페이지는 없기 때문에, endPage자리에 마지막 페이지수라고 저장한 것
		
			/* 맨 처음 페이지 이동처리*/
			if(startPage > 4)
				out.print("<a href='shopAll.jsp?pageNum=1&product_kind="+product_kind+"'><div id='pBox' title='첫 페이지'>"+"<<"+"</div></a>");
			
			/* 이전 페이지 이동처리 */
			if(startPage > 4) {
				out.print("<a href='shopAll.jsp?pageNum="+(currentPage-3)+"&product_kind="+product_kind+"' title='이전 4페이지'><div id='pBox'>"+"<"+"</div></a>");
			}
			
			/* 페이징 블럭 처리 */
			for(int i=startPage; i<=endPage; i++) {
				if(currentPage == i) { //선택된 페이지 표현
					out.print("<div id='pBox' class='pBox_c'>"+i+"</div>");
				} else {
					out.print("<a href='shopAll.jsp?pageNum="+i+"&product_kind="+product_kind+"'><div id='pBox'>"+i+"</div></a>");	//i숫자를 이용해 페이지를 바꿈
				}
			}
			
			/* 다음 페이지 이동처리 */
			if(endPage < pageCount) {
				int movePage=currentPage + 4;
				if(movePage>pageCount) movePage=pageCount;
				out.print("<a href='shopAll.jsp?pageNum="+movePage+"&product_kind="+product_kind+"' title='다음 4페이지'><div id='pBox'>"+">"+"</div></a>");
			}
			
			/* 맨 끝 페이지 이동처리 */
			if(endPage < pageCount) {
				out.print("<a href='shopAll.jsp?pageNum="+pageCount+"&product_kind="+product_kind+"' title='마지막 페이지'><div id='pBox'>"+">>"+"</div></a>");
			}
		} 
		%>
	</div>
<div class="main_end"></div>

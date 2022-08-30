<%@page import="java.text.*"%>
<%@page import="java.util.List"%>
<%@page import="manager.product.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록</title>
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
	
	/* 상단 */ 
	* {
		margin: 0;
		padding: 0;
	}
	body {
		border: 30px solid #396e15;
		border-left: none;
		border-right: none;
	}
	.guide {
		text-align: right;
		width: 1200px;
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
		top: -35px;
	}
	#container {
		width: 1200px;
		height: 100%;
		margin: 0 auto;
	}
	.m_title {
		float: left;
		font-family: 'font1';
		font-size: 3em; 
		margin: 0 auto;
	}
	.m_title a {
		padding-left: 8px;
		font-weight: bold;
		text-decoration: none; 
	}
	.m_title a #one {
		color: #fda73f;
	}
	.m_title a #two {
		color: #396e15;
	}

	

	/* 상단 : 검색 */
	input:-webkit-autofill {
		-webkit-box-shadow: 0 0 0 1000px white inset; 
		box-shadow: 0 0 0 1000px white inset;
	}
	input:focus {
		outline: none;
	}
	#c1 {
		width: 100%;
		height: 100px;
		margin: 10px auto;
	}
	.top_info a {
		text-decoration: none;
		color: #fda73f;  
		padding-right: 10px;
	}
	.top_info {
		float: right;
		font-family:  'font2';
		font-weight: bold;
	}
	.c_cnt {
		float: right;
		color: #396e15;
		margin: 10px auto;
		font-family: 'font2';
		font-weight: bold;
		padding-right: 10px;
	}
	.c_register img, .c_list img, .c_logout img {
		position: relative;
		top: 9px;
	}
	.c_list a, .c_logout a {
		color:  #396e15;
	}
	.top_search {
		float: right;
		margin: 0;
		clear: both;
	}
	.c_select {
		width: 70px; 
		height: 25px; 
		color: #ccc;
		border: none;
		text-align: center;
		font-family: 'font1';
		font-size: 0.9em;
		position: relative;
		right: -120px;
		z-index: 1;
	}
	.c_select:focus {
		outline: none;
	}
	.c_input {
		width: 270px; 
		height: 40px; 
		border: 1px solid #ccc;  
		border-radius: 5px;
		padding-left: 90px;
		position: relative;
		left: 40px;
	}
	.c_submit {
		width: 40px;
		height: 32px; 
		position: relative;
		left: 30px;
		border: none;
		background: none;
	}


	/* 중단 : 상품테이블  */
	table {
		width: 100%; 
		margin: 0 auto;
		text-align: center; 
		border: 1px solid #396e15;
		border-top: hidden;
		border-left: hidden;
		border-right: hidden;
		border-collapse: collapse; 
	}
	mark {
		color: #396e15;
		padding: 6px 12px;
		border: 1.5px solid #396e15;
		border-radius: 8px;
		background-color: white;
	}
	#longword {
		padding: 7px 120px;
	}
	th {
		font-family:  'font2';
		font-size: 0.9em;
		color: #396e15;
	}
	tr:first-child {
		border-bottom: hidden;
	}
	tr {
		height: 60px; 
		border: 1px solid #396e15;
		font-family:  'font3';
		font-size: 1em; 
	}
	td {
		border-collapse: collapse; 
		color: #5f5f5d;
		font-size: 0.9em;
	}
	td a {
		text-decoration: none; 
		color: #5f5f5d;
	}
	#choice:hover a {
		color: #fda73f;
	}
	
	/* 하단  */
	#paging {
		text-align: center; 
		margin: 60px auto;
		height: 30px;
	}
	#paging a {
		text-decoration: none; 
		color: gray;
	}
	.pBox_c {
		color: #396e15;
		border: 2px solid #396e15;
		border-radius: 4px;
		font-weight: bold;
	}
	#pBox {
		display: inline-block; 
		width: 20px; 
		height: 20px; 
		padding: 5px; 
		margin: 0 3px; 
		font-family:  'font1';
		font-size: 1em;
	}
</style>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	
	//세션처리
	String managerId = (String)session.getAttribute("managerId");
	if(managerId == null) {
		out.print("<script>location='../logon/managerLoginForm.jsp';</script>");
	}
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	DecimalFormat df = new DecimalFormat("#,###");
	
	String product_kindName = "";
	
	//-----------------------------------------------------------------------------페이징(paging)처리
	/* 변수 선언 */
	int pageSize=10; 									 //1페이지에 10건의 게시글을 보여줌
	String pageNum=request.getParameter("pageNum");
	
	if(pageNum==null) pageNum="1";
	
	int currentPage=Integer.parseInt(pageNum); 			 //현재 페이지
	int startRow = (currentPage -1) * pageSize+1; 		 //현재 페이지의 첫번째 행
	int endRow=currentPage * pageSize;					 //현재 페이지의 마지막 행
	//------------------------------------------------------------------------------
	
	//검색 처리 : 검색일 때는 search가 1이고, 검색이 아닐 때는 search가 0
	
	String search = request.getParameter("search");
	String s_search = "";
	String i_search = "";
	if(search == null) {
		search = "0";
	} else { //search가 "1"일 때 
		s_search = request.getParameter("s_search");
		i_search = request.getParameter("i_search");
	}
	
	//DB연결, 질의 처리
	ProductDAO productDAO = ProductDAO.getInstance();
	
	//전체 수량 조회
	int cnt = 0;
	
	//전체 상품 조회 -> 페이징 처리됨, 검색 처리됨 (search=1 검색임, search=0 검색아님)
	List<ProductDTO> productList = null;
	if(search.equals("1")) {
		productList = productDAO.getProductList(startRow, pageSize, s_search, i_search);
		cnt = productDAO.getProductCount(s_search, i_search);
	} else if(search.equals("0")) {
		productList = productDAO.getProductList(startRow, pageSize);
		cnt = productDAO.getProductCount();
	}
	
	//매 페이지마다 전체상품 수에 대한 역순번호
	int number=cnt-((currentPage-1)*pageSize); 	
	%>
	
	<div class="guide">
		<a href="../managerMain.jsp"><%=managerId%>님 [관리자]</a>
	</div>

	<div id="container">
	<div id="c1">
		<!-- 상단 : 타이틀 -->
		<div class="m_title"><a href="productList.jsp"><span id="one">Pet</span> <span id="two">Plus+</span></a></div>
		
		<!-- 상단 : 아이디, 로그아웃, 상품등록 -->
		<div class="top_info">
			<span class="c_register"><a href="productRegisterForm.jsp"><img src="../../icons/p_add.png" width="25"> 상품 등록</a></span>&emsp;
			<span class="c_list"><a href="../managerMain.jsp"><img src="../../icons/p_list.png" width="25"> 관리자 목록</a></span>&emsp;
			<span class="c_logout"><a href="../logon/managerLogout.jsp"><img src="../../icons/p_logout.png" width="24"> 로그아웃</a></span>
		</div>
		
		<!-- 상단 : 검색 -->
		<div class="top_search">
			<form action="productList.jsp" method="post" name="searchForm">
				<input type="hidden" name="search" value="1">
				<select name="s_search" class="c_select">
					<option>상품명</option>
					<option selected >제조사</option>
				</select>	
				<input type="text" name="i_search" class="c_input">
				<input type="submit" value=" " class="c_submit">
			</form>
		</div>
		
	</div>
	
	<div id="c2">	
		<!-- 중단 : 상품 테이블 -->
		<table>
			<tr>
				<th width="5%"><mark> NO </mark></th>
				<th width="8%"><mark>분류</mark></th>
				<th width="7%"><mark>제조사</mark></th>
				<th width="10%"><mark>이미지</mark></th>
				<th width="28%"><mark id="longword">상품명</mark></th>
				<th width="10%"><mark>금액</mark></th>
				<th width="7%"><mark>재고량</mark></th>
				<th width="7%"><mark>할인율</mark></th>
				<th width="9%"><mark>등록일</mark></th>
				<th width="9%"><mark>수정 · 삭제</mark></th>
			</tr>
			<%if(cnt == 0){%> 	<!-- 등록된 상품이 없을 때 -->
				<tr><td colspan="13">등록된 상품이 없습니다.</td></tr>
				
			<%} else {			 /* 등록된 상품이 있을 때 */
				for(ProductDTO product : productList) {
					switch(product.getProduct_kind()) {
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
			%>		
			<tr>
				<td><%=number-- %></td>
				<td><%=product_kindName%></td>
				<td><%=product.getProduct_company()%></td>
				<td><img src=<%="/images_petplus/" +product.getProduct_image()%> width="45px" height="55px"></td>
				<td id="choice"><a href="productContent.jsp?product_id=<%=product.getProduct_id()%>&pageNum=<%=pageNum%>"><%=product.getProduct_name()%></a></td>
				<td><%=df.format(product.getProduct_price())%>원</td>
				<td><%=df.format(product.getProduct_count())%>개</td>
				<td><%=product.getDiscount_rate()%>%</td>
				<td><%=sdf.format(product.getReg_date())%></td>
				<td>
					<a href="productContent.jsp?product_id=<%=product.getProduct_id()%>&pageNum=<%=pageNum%>" title="상품 수정"><img src="../../icons/p_update.png" width="25" class="img_update"></a>&emsp;&ensp;
					<a href="productDeletePro.jsp?product_id=<%=product.getProduct_id()%>&pageNum=<%=pageNum%>" title="상품 삭제"><img src="../../icons/p_delete.png" width="25" class="img_delete"></a>
				</td>
			</tr>
			<%}}%>
		</table>
		<span class="c_cnt">(전체 수량 : <%=cnt%>개)</span>
	</div>	
	
	<div id="paging">
	<%
	/* 하단 : 페이징 처리 */
	if(cnt>0) {
		int pageCount=(cnt/pageSize) + (cnt%pageSize==0? 0:1);	//전체 페이지 수, 뒷자리 1~10이면 한페이지를 어차피 추가해야 하므로 나머지가 0이 아닐 때는 1을 더해준다
		int startPage=1;										//시작 페이지 번호
		int pageBlock=10;										//페이징의 개수, 화면에서 보이는 페이지 목록 범위
		
		/* 시작 페이지 설정 */
		if(currentPage%10 != 0) startPage=(currentPage/10)*10+1;
		else startPage=(currentPage/10-1) * 10 + 1;
		
		/* 끝 페이지 설정 */
		int endPage = startPage + pageBlock - 1;
		if(endPage > pageCount) endPage = pageCount;			//마지막 페이지보다 큰 페이지는 없기 때문에, endPage자리에 마지막 페이지수라고 저장한 것
	
		/* 맨 처음 페이지 이동처리*/
		if(startPage > 10)
			out.print("<a href='productList.jsp?pageNum=1&search="+search+"&s_search="+s_search+"&i_search="+i_search+"'><div id='pBox' title='첫 페이지'>"+"<<"+"</div></a>");
		
		/* 이전 페이지 이동처리 */
		if(startPage > 10) {
			out.print("<a href='productList.jsp?pageNum="+(currentPage-10)+"&search="+search+"&s_search="+s_search+"&i_search="+i_search+"' title='이전 10페이지'><div id='pBox'>"+"<" + "</div></a>");
		}
		
		/* 페이징 블럭 처리 */
		for(int i=startPage; i<=endPage; i++) {
			if(currentPage == i) { //선택된 페이지 표현
				out.print("<div id='pBox' class='pBox_c'>"+i+"</div>");
			} else {
				out.print("<a href='productList.jsp?pageNum="+i+"&search="+search+"&s_search="+s_search+"&i_search="+i_search+"'><div id='pBox'>"+i+"</div></a>");	//i숫자를 이용해 페이지를 바꿈
			}
		}
		
		/* 다음 페이지 이동처리 */
		if(endPage < pageCount) {
			int movePage=currentPage+10;
			if(movePage>pageCount) movePage=pageCount;
			out.print("<a href='productList.jsp?pageNum="+movePage+"&search="+search+"&s_search="+s_search+"&i_search="+i_search+"' title='다음 10페이지'><div id='pBox'>"+">"+"</div></a>");
		}
		
		/* 맨 끝 페이지 이동처리 */
		if(endPage < pageCount) {
			out.print("<a href='productList.jsp?pageNum="+pageCount+"&search="+search+"&s_search="+s_search+"&i_search="+i_search+"' title='마지막 페이지'><div id='pBox'>"+">>"+"</div></a>");
		}
	} 
	%>
	</div>
	</div>
</body>
</html>
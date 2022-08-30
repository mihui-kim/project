<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
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
	    font-family: 'font1';
	    src: url('../../icons/SuncheonB.ttf') format('truetype');
	}
	@font-face {
	    font-family: 'font2';
	    src: url('../../icons/SuncheonR.ttf') format('truetype');
	}
	
	/* 상단 */ 

	#container {
		width: 550px;
		height: 88vh;
		margin: 0 auto;
	}
	.m_title {
		font-family: 'font1';
		font-size: 3em; 
		font-weight: bold;
		text-align: center; 
		margin: 60px 0px;
	}
	.m_title #one {
		color: #fda73f;
	}
	.m_title #two {
		color: #396e15;
	}
	
	
	/* 중단 : 상품 등록 테이블 */
	table {
		width: 100%; 
		border: 30px solid  #396e15; 
		border-collapse: collapse; 
		border-left: hidden; 
		border-right: hidden;
	}
	th, td {
		font-family: 'font2';
		color: #575555; 
		font-size: 1em; 
	}
	td {
		padding-left: 5px; 
		padding: 12px 0;
	}
	#up td {
		padding-top: 25px;
	}
	#up th {
		padding-top: 15px;
	}
	#down td {
		padding-bottom: 25px;
	}
	#down th {
		padding-bottom: 15px;
	}
	
	/* 중단 : 테이블 안 입력상자 */
	.c_p_id, .s_p_id {
		background : #e5e5e5;
	}
	.s_p_img {
		color: #e58004;
		font-size: 0.7em;
	}
	.s_p_img input {
		color: gray;
	}
	input[type="text"], select {
		height: 30px; 
		border-radius: 3px; 
		border: 1px solid #ccc;
		padding-left: 5px;
	}
	input[type="number"] {
		width: 100px; 
		height: 30px; 
		border-radius: 3px; 
		border: 1px solid #ccc;
		padding-left: 5px;
	}
	input:focus {
		outline: none;
	}
	input:-webkit-autofill {
		-webkit-box-shadow: 0 0 0 1000px white inset; 
		box-shadow: 0 0 0 1000px white inset;
	}
	
	
	/* 하단 */
	input::file-selector-button {
		width:100px; 
		height:30px;
		margin-bottom: 5px;
		background: white; 
		color: #9e9e9e;
		cursor:pointer;
		font-size: 1em; 
		font-family: 'font2';
		border:1px solid #9e9e9e; 
		border-radius: 8px;
	}
	.btns {
		text-align: center;
		margin: 30px;
	}
	.btns input {
		cursor: pointer; 
		font-family: 'font2';
		font-size: 1em;
		font-weight: bold; 
		margin: 20px; 
		color: #396e15;
		border: 2px solid  #396e15;
		border-radius: 5px; 
		width: 110px; 
		height: 40px; 
		text-align: center;
	}
	.btns input:hover {
		color: #fda73f;
		background: white;
		border: 2px solid #fda73f;
	}
</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		let form = document.updateForm;
		
		//상품 분류가 선택되도록 설정
		let product_kind = form.product_kind; 	//select
		let p_kind = form.p_kind;				
		for(let i=0; i<product_kind.length; i++) {
			if(p_kind.value == product_kind[i].value) {
				product_kind[i].selected = true;
				break;
			}
		}
		
		
		//상품 수정 처리페이지로 이동
		let btn_update = document.getElementById("btn_update");
		btn_update.addEventListener("click" , function() {
			if(!form.product_name.value) {
				alert('상품 제목을 입력하세요.');
				return;
			}
			if(!form.product_name.value) {
				alert('상품명을 입력하세요.');
				return;
			}
			if(!form.product_price.value) {
				alert('금액을 입력하세요.');
				return;
			}
			if(!form.product_count.value) {
				alert('수량을 입력하세요.');
				return;
			}
			if(!form.product_content.value) {
				alert('내용을 입력하세요.');
				return;
			}
			if(!form.product_company.value) {
				alert('제조사를 입력하세요.');
				return;
			}
			if(!form.discount_rate.value) {
				alert('할인율을 입력하세요.');
				return;
			}
			form.submit();
		})

		
			//상품 삭제 버튼 
			let product_id = form.product_id.value;
			let pageNum = form.pageNum.value;
			
			let btn_delete = document.getElementById("btn_delete");
			btn_delete.addEventListener("click", function() {
				location = 'productDeletePro.jsp?product_id=' + product_id + "&pageNum=" + pageNum;
			})
		
			//상품 목록 페이지 버튼 
			let btn_list = document.getElementById("btn_list");
			btn_list.addEventListener("click", function() {
				location = 'productList.jsp?pageNum=' + pageNum;
			})
			
	})
</script>
</head>
<body>
<%
//세션처리
String managerId = (String)session.getAttribute("managerId");
if(managerId == null) {
	out.print("<script>location='../logon/managerLoginForm.jsp';</script>>");
}

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
String pageNum = request.getParameter("pageNum");
int product_id = Integer.parseInt(request.getParameter("product_id"));



//DB연결, 질의처리
ProductDAO productDAO = ProductDAO.getInstance();
ProductDTO product = productDAO.getProduct(product_id);

%>
	<div id="container">
		<div class="m_title"><span id="one">Pet</span> <span id="two">Plus+</span></div>
		
		<form action="productUpdatePro.jsp" method="post" name="updateForm" enctype="multipart/form-data">
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
			<table>
				<tr id="up">
				<th>상품번호</th>
				<td id="info"><input type="text" name="product_id" value="<%=product.getProduct_id()%>" size="11" readonly class="c_p_id"></td>
				</tr>
				<tr>
					<th width="20%">분류</th>
					<td width="80%">
						<input type="hidden" name="p_kind" value="<%=product.getProduct_kind()%>">
						<select name="product_kind">
							<option value="110">나시</option>
							<option value="120">탑</option>
							<option value="130">후디</option>
							<option value="140">아우터</option>
							<option value="150">올인원</option>
							<option value="210">껌</option>
							<option value="220">캔/파우치</option>
							<option value="230">음료</option>
							<option value="240">수제간식</option>
							<option value="250">사료</option>
							<option value="310">봉제인형</option>
							<option value="320">고무인형</option>
							<option value="330">하네스·리드줄</option>
							<option value="340">악세사리</option>
							<option value="350">노즈워크</option>
							<option value="410">배변</option>
							<option value="420">탈취</option>
							<option value="430">치아</option>
							<option value="440">눈·귀</option>
							<option value="450">미용·목욕</option>
							<option value="510">식기</option>
							<option value="520">하우스</option>
							<option value="530">이동가방</option>
							<option value="540">방석·매트</option>
							<option value="550">가전제품</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>상품명</th>
					<td><input type="text" name="product_name" size="58" value="<%=product.getProduct_name()%>"></td>
				</tr>
				<tr>
					<th>금액</th>
					<td><input type="number" name="product_price" min="1000" max="1000000" value="<%=product.getProduct_price()%>"> 원</td>
				</tr>
				<tr>
					<th>수량</th>
					<td><input type="number" name="product_count" min="0" max="100000" value="<%=product.getProduct_count()%>"> 개</td>
				</tr>
				<tr>
					<th>이미지</th>
					<td class="s_p_img"><input type="file" name="product_image">
					<br>이미지를 다시 선택해주세요 !</td>
				</tr>
				<tr>
					<th>내용</th>
					<td class="s_p_img"><input type="file" name="product_content">
					<br>이미지를 다시 선택해주세요 !</td>
				</tr>
				<tr>
					<th>제조사</th>
					<td><input type="text" name="product_company" size="58" value="<%=product.getProduct_company()%>"></td>
				</tr>
				<tr>
					<th>할인율</th>
					<td><input type="number" name="discount_rate" min="0" max="90" value="<%=product.getDiscount_rate()%>"> %</td>
				</tr>
				<tr id="down">
					<th >등록일</th>
					<td id="info"><input type="text" name="reg_date" value="<%=sdf.format(product.getReg_date())%>" size="10" readonly class="s_p_id"></td>
				</tr>
			</table>
			<div class="btns">
				<input id="btn_update" value="수정">
				<input id="btn_delete" value="삭제">
				<input id="btn_list" value="상품 목록">
			</div>
		</form>
	</div>
</body>
</html>
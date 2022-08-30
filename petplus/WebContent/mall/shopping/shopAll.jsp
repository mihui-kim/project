<%@page import="java.util.List"%>
<%@page import="manager.product.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰 전체(상단, 메인, 하단)</title>
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
	* {
		margin: 0;
		padding: 0;
	}
	body {
		border: 40px solid #fda73f;
	}
	#container {
		width: 1200px; 
		margin: 0 auto;
	}
	#header { 
		width: 100%;
		position: fixed;
		z-index: 1;
	}
	#branktop {
		height: 250px;
	}
	
	
	/* 추천 상품 */
	.img1:hover {
		transform: scale(1.1);
	} 
	.s_title {
		text-align: center;
		color: #4a8522; 
		width: 350px;
		margin: 0 auto; 
		padding: 10px; 
		font-family: 'font1';  
	}
	#s1 {
		top: 20px;
	}
	#g1 {
		margin-top: 40px;
		font-size: 1.5em; 
	}
	#g2 {
		margin-bottom: 40px;
		font-size: 1.2em; 
	}
	
	hr {
		clear: both; 
		margin: 20px 0; 
		background: #e2e2e2; 
		border: none; 
		height: 1px;
	}
			  
</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>  
<script>
//슬라이더(slider), 캐러셀(carousel)
$(document).ready(function(){
  $('.slider').bxSlider({
	  pager:false, 
      auto:true,                //기본값:false      	-> 자동 슬라이드 전환
      autoHover:true,           //기본값:false      	-> 마우스를 올렸을 때 슬라이드 정지
      controls:false,			//기본값:true       	-> 이전 다음 버튼의 유무
      speed:2000,               //화면 전환 속도    		-> 밀리초 기준으로 임의 지정
      pause:2000,               //전환 지연 시간			
      slideWidth:300,           //이미지의 너비
      slideHeight:300,          //이미지의 높이
      minSlides:5,              //이미지 최소 노출 개수
      maxSlides:5,              //이미지 최대 노출 개수
      moveSlides:3,             //슬라이드 이동 개수
      touchEnabled:false,		//웹화면의 touch 이벤트 제거 -> 이미지 클릭 시 해당 페이지로 이동이 가능하게 만듬
      adaptiveHeight:true
  });
});
</script>
</head>
<body>
<%
ProductDAO productDAO = ProductDAO.getInstance();


// bx-slider 
// 여름 옷 추천
String[] wear = {"120","130","140","150"};
List<ProductDTO> list1 = productDAO.getProductList(wear, 1);

// 장난감 추천
String[] toy = {"310","320"};
List<ProductDTO> list3 = productDAO.getProductList(toy, 1);

// 간식 추천
String[] snack = {"210","220","230","240"};
List<ProductDTO> list2 = productDAO.getProductList(snack, 1);

// 쿠션 추천
String[] cushion = {"520","540"};
List<ProductDTO> list4 = productDAO.getProductList(cushion, 1);

%>


<div id="container">
<div>
	<header><jsp:include page="../common/shopTop.jsp"/></header>
</div>
	<hr>
	<div>
		<main>
			<article class="items1"> 
				<div class="s_title" id="g1"><b>귀엽고 편한 추천 상품</b></div>
				<div class="s_title" id="g2">가을 준비하기 🍂</div>
				<div class="slider">
				<%for(ProductDTO product1 : list1) {%>
					<a href="shopContent.jsp?product_id=<%=product1.getProduct_id()%>">
					<img src=<%="/images_petplus/"+product1.getProduct_image()%> class="img1"></a>	
				<%}%>
				</div>
			</article>
			
			<article class="items2"> 
				<div class="s_title" id="g1"><b>귀여운 것 다~ 모아</b></div>
				<div class="s_title" id="g2">놀이대장 댕댕이들 모여라 🐾</div>
				<div class="slider">
				<%for(ProductDTO product3 : list3) {%>
					<a href="shopContent.jsp?product_id=<%=product3.getProduct_id()%>">
					<img src=<%="/images_petplus/"+product3.getProduct_image()%> class="img1"></a>	
				<%}%>
				</div>
			</article>
			
			<article class="items3"> 
				<div class="s_title" id="g1"><b>영향도 맛도 최고</b></div>
				<div class="s_title" id="g2">맛있는 간식 🥰</div>
				<div class="slider">
				<%for(ProductDTO product2 : list2) {%>
					<a href="shopContent.jsp?product_id=<%=product2.getProduct_id()%>">
					<img src=<%="/images_petplus/"+product2.getProduct_image()%> class="img1"></a>	
				<%}%>
				</div>
			</article>
			
			<article class="items4"> 
				<div class="s_title" id="g1"><b>편한하게 휴식하자!</b></div>
				<div class="s_title" id="g2">소중한 우리 강아지 💛</div>
				<div class="slider">
				<%for(ProductDTO product4 : list4) {%>
					<a href="shopContent.jsp?product_id=<%=product4.getProduct_id()%>">
					<img src=<%="/images_petplus/"+product4.getProduct_image()%> class="img1"></a>	
				<%}%>
				</div>
			</article>
			
			<article class="kind_items"> 
				<jsp:include page="shopMain.jsp"/>
			</article>
		</main>
	</div>
	<div>
		<footer><jsp:include page="../common/shopBottom.jsp"/></footer>
	</div>
</div>
</body>
</html>
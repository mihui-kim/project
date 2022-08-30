<%@page import="manager.product.ProductDTO"%>
<%@page import="manager.product.ProductDAO"%>
<%@page import="mall.cart.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수량 변경 처리</title>
</head>
<body>
<%
String memberId = (String)session.getAttribute("memberId");

if(memberId == null) {
	out.print("<script>alert('로그인을 해주세요.');");
	out.print("location='../logon/memberLoginForm.jsp';</script>");
	return;
}
int cart_id = Integer.parseInt(request.getParameter("cart_id"));
int order = Integer.parseInt(request.getParameter("order"));
int product_id = Integer.parseInt(request.getParameter("product_id"));

//Product DB연동 -> 재고수량 파악
ProductDAO productDAO = ProductDAO.getInstance();
ProductDTO product = productDAO.getProduct(product_id);
int product_count = product.getProduct_count();

//Cart DB연동
out.print("<script>");
if(order > product_count) { //구매수량 > 재고수량
	out.print("alert('상품의 재고수량을 초과했습니다. (현재 재고수량: "+product_count+"개)\\n구매수량을 다시 입력해 주세요.');");
} else { //구매수량 < 재고수량
	CartDAO cartDAO = CartDAO.getInstance();
	cartDAO.updateCart(cart_id, order);
}

out.print("location='cartList.jsp';");
out.print("</script>");
%>
</body>
</html>
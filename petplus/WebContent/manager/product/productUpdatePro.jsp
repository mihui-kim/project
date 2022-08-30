<%@ page import="manager.product.*" %>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정 처리</title>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	
	//폼의 입력(일반폼이 아닌 파일 업로드 폼)정보 획득하기 -> 5가지가 필요함 (request, 업로드 폴더, 파일최대크기, encType, 파일명중복정책)
	String realFolder = "c:/Users/mihui/Desktop/개발공부/data/JSP/images_petplus";
	int maxSize = 1024 * 1024 * 5;
	String encType = "utf-8";
	String fileName1 = "";
	String fileName2 = "";
	MultipartRequest multi = null;
	
	try {
		multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
		
		Enumeration<?> files = multi.getFileNames();
		while(files.hasMoreElements()) {
			String name1 = (String)files.nextElement();
			String name2 = (String)files.nextElement();
			fileName1 = multi.getFilesystemName(name1);
			fileName2 = multi.getFilesystemName(name2);
		}
		
	} catch(Exception e) {
		System.out.println("productUpdatePro.jsp 파일: " + e.getMessage());
		e.printStackTrace();
	} 
	
	//pageNum을 획득 (request가 아닌 multi를 이용)
	String pageNum = multi.getParameter("pageNum");
	
	//폼에서 넘어오는 필드 값을 획득 (제외: 등록일 reg_date)
	int product_id = Integer.parseInt(multi.getParameter("product_id"));
	String product_kind = multi.getParameter("product_kind");
	String product_name = multi.getParameter("product_name");
	int product_price = Integer.parseInt(multi.getParameter("product_price"));
	int product_count = Integer.parseInt(multi.getParameter("product_count"));
	String product_image = multi.getParameter("product_image");
	String product_content = multi.getParameter("product_content");
	String product_company = multi.getParameter("product_company");
	int discount_rate = Integer.parseInt(multi.getParameter("discount_rate"));
	
	//ProductDTO 객체 생성 -> setter 메소드 사용 -> 값을 설정할 수 있게함
	ProductDTO product = new ProductDTO();
	product.setProduct_id(product_id);
	product.setProduct_kind(product_kind);
	product.setProduct_name(product_name);
	product.setProduct_price(product_price);
	product.setProduct_count(product_count);
	product.setProduct_image(fileName1);
	product.setProduct_content(fileName2);
	product.setProduct_company(product_company);
	product.setDiscount_rate(discount_rate);
	
	//System.out.println("product 객체: "+ product.toString());
	
	//DB연결, product 테이블에 상품 추가처리
	ProductDAO productDAO = ProductDAO.getInstance();
	productDAO.updateProduct(product);
	response.sendRedirect("productList.jsp?pageNum=" + pageNum);
	%>
</body>
</html>
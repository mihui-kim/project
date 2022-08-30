<%@page import="board.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정 처리</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

int num=Integer.parseInt(request.getParameter("num"));
String subject=request.getParameter("subject");
String content=request.getParameter("content");
%>

<jsp:useBean id="board" class="board.BoardDTO"/>
<jsp:setProperty property="*" name="board"/>
<%
String pageNum=request.getParameter("pageNum");
BoardDAO boardDAO=BoardDAO.getInstance();
boardDAO.updateboard(board);
response.sendRedirect("boardList.jsp?pageNum=" + pageNum);
%>
</body>
</html>
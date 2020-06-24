<%@page import="model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>글 쓰기 처리</title>
</head>
<body>
<% 
	request.setCharacterEncoding("euc-kr");
%>

<jsp:useBean id = "boardbean" class = "model.BoardBean">
	<jsp:setProperty name = "boardbean" property = "*"/>
</jsp:useBean>

<%
	//데이터 베이스 쪽으로 빈 클래스를 넘겨줌.
	BoardDAO bdao = new BoardDAO();
	//데이터 저장 메소드를 호출
	bdao.insertBoard(boardbean);
	
	//게시글 저장 후 전체 게시글 보기 
	response.sendRedirect("BoardList.jsp");
%>

	

</body>
</html>
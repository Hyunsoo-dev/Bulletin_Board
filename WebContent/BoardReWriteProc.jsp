<%@page import="model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>답변 글 쓰기 - 2</title>
</head>
<body>

<%
	request.setCharacterEncoding("euc-kr");
%>
<!--  데이터를 한번에 받아오는 빈클래스를 사용하도록 -->
<!--  ref,re_step, re_level 까지 다 넘어옴 -->
<jsp:useBean id = "boardbean" class = "model.BoardBean">
	<jsp:setProperty name = "boardbean" property = "*"/>
</jsp:useBean>

<%
	//데이터 베이스 객체 생성 
	BoardDAO bdao = new BoardDAO();
	bdao.reWriteBoard(boardbean);
	
	//데이터 베이스 저장 후 전체 게시글 보기를 설정
	response.sendRedirect("BoardList.jsp");
%>


</body>
</html>
<%@page import="model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�亯 �� ���� - 2</title>
</head>
<body>

<%
	request.setCharacterEncoding("euc-kr");
%>
<!--  �����͸� �ѹ��� �޾ƿ��� ��Ŭ������ ����ϵ��� -->
<!--  ref,re_step, re_level ���� �� �Ѿ�� -->
<jsp:useBean id = "boardbean" class = "model.BoardBean">
	<jsp:setProperty name = "boardbean" property = "*"/>
</jsp:useBean>

<%
	//������ ���̽� ��ü ���� 
	BoardDAO bdao = new BoardDAO();
	bdao.reWriteBoard(boardbean);
	
	//������ ���̽� ���� �� ��ü �Խñ� ���⸦ ����
	response.sendRedirect("BoardList.jsp");
%>


</body>
</html>
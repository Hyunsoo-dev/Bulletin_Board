<%@page import="model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ������</title>
</head>
<body>

<%
	request.setCharacterEncoding("euc-kr");

	
%>
	<!-- ����� �����͸� �о�帮�� ��Ŭ���� ���� -->
<jsp:useBean id = "boardbean" class = "model.BoardBean">
	<jsp:setProperty name = "boardbean" property = "*" />
</jsp:useBean>

<%
	BoardDAO bdao = new BoardDAO();
	String pass = bdao.getPass(boardbean.getNum());
	
	//���� password ���� update �� �ۼ��ߴ� password ���� ������ ��
	if(pass.equals(boardbean.getPassword())){
		
		//������ �����ϴ� �޼ҵ� ȣ��
		bdao.updateBoard(boardbean);
		//������ �Ϸ�Ǹ� ��ü �Խñ� ����
		response.sendRedirect("BoardList.jsp");
		
	//�н����� ���� ��ġ���� �ʴ´ٸ�. 	
	}else{
%>
	<script>
		alert("�н����尡 ��ġ���� �ʽ��ϴ�. �ٽ� Ȯ�� �� �������ּ���");
		history.go(-1);
	</script>
		
<%		
		
	}
%>
</body>
</html>
<%@page import="model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ������ - 2</title>
</head>
<body>

<%
	//������ ���� �� �Է��� �н�����
	String pass = request.getParameter("password");
	int num  = Integer.parseInt(request.getParameter("num"));
	
	BoardDAO bdao = new BoardDAO();
	
	//���� �н����� �� �о�� 
	String password = bdao.getPass(num);
	
	//���� �н������ ���� �� �Է��� �н����� �� 
	if(pass.equals(password)){
		
		bdao.deleteBoard(num); 
		
		response.sendRedirect("BoardList.jsp");
		
	//���� �н������ �Է��� �н����尡 ��ġ���� �ʴ´ٸ�
	}else{
		
%>
	<script>
		alert("�Է��� ��й�ȣ�� Ʋ�Ƚ��ϴ�. Ȯ�� �� �ٽ� �Է����ּ���.");
		history.go(-1);
	</script>		
<%		
	}
%>

</body>
</html>
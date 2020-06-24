<%@page import="model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>삭제 페이지 - 2</title>
</head>
<body>

<%
	//데이터 삭제 시 입력한 패스워드
	String pass = request.getParameter("password");
	int num  = Integer.parseInt(request.getParameter("num"));
	
	BoardDAO bdao = new BoardDAO();
	
	//기존 패스워드 값 읽어옴 
	String password = bdao.getPass(num);
	
	//기존 패스워드와 삭제 시 입력한 패스워드 비교 
	if(pass.equals(password)){
		
		bdao.deleteBoard(num); 
		
		response.sendRedirect("BoardList.jsp");
		
	//기존 패스워드와 입력한 패스워드가 일치하지 않는다면
	}else{
		
%>
	<script>
		alert("입력한 비밀번호가 틀렸습니다. 확인 후 다시 입력해주세요.");
		history.go(-1);
	</script>		
<%		
	}
%>

</body>
</html>
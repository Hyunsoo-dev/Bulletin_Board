<%@page import="model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>수정 페이지</title>
</head>
<body>

<%
	request.setCharacterEncoding("euc-kr");

	
%>
	<!-- 사용자 데이터를 읽어드리는 빈클래스 설정 -->
<jsp:useBean id = "boardbean" class = "model.BoardBean">
	<jsp:setProperty name = "boardbean" property = "*" />
</jsp:useBean>

<%
	BoardDAO bdao = new BoardDAO();
	String pass = bdao.getPass(boardbean.getNum());
	
	//기존 password 값과 update 시 작성했던 password 값이 같은지 비교
	if(pass.equals(boardbean.getPassword())){
		
		//데이터 수정하는 메소드 호출
		bdao.updateBoard(boardbean);
		//수정이 완료되면 전체 게시글 보기
		response.sendRedirect("BoardList.jsp");
		
	//패스워드 값이 일치하지 않는다면. 	
	}else{
%>
	<script>
		alert("패스워드가 일치하지 않습니다. 다시 확인 후 수정해주세요");
		history.go(-1);
	</script>
		
<%		
		
	}
%>
</body>
</html>
<%@page import="model.BoardBean"%>
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

	<h2> 게시글 수정 </h2>
	<%
		//해당 게시글 번호를 통하여 게시글 수정 
		int num = Integer.parseInt(request.getParameter("num").trim());
	
		//하나의 게시물의 대한 정보를 리턴
		BoardDAO bdao = new BoardDAO();
		
		BoardBean bean = bdao.getOneUpdateBoard(num);
		
		
	%>
	
	<form action="BoardUpdateProc.jsp" method = "post">
		<table width = "600" border = "1">
			<tr height = "40">
				<td width = "120"> 작성자 </td>
				<td width = "180"> <%= bean.getWriter() %> </td>
				<td width = "120"> 작성일 </td>
				<td width = "180"> <%= bean.getReg_date() %> </td>
			</tr>
			<tr height = "40">
				<td width = "120"> 제목 </td>
				<td width = "480" colspan = "3"> <input type = "text" name = "subject" value = "<%= bean.getSubject() %>" size = "60"></td>
			</tr>
			<tr height = "40">
				<td width = "120"> 패스워드 </td>
				<td width = "480" colspan = "3"> <input type = "password" name = "password" size = "60"></td>
			</tr>
			<tr height = "40">
				<td width = "120"> 글 내용 </td>
				<td width = "480" colspan = "3"> <textarea rows="10" cols="60" name = "content" value = "<%= bean.getContent()%>"> </textarea> </td>
			</tr>
			<tr height = "40">
				<td colspan = "4">
					<input type = "hidden" name = "num" value = "<%= bean.getNum() %>">
					<input type = "submit" value = "글 수정">&nbsp;&nbsp;
					<input type = "button" value = "글 목록 보기" onclick = "location.href = 'BoardList.jsp'">
				</td>
			</tr>
			
		</table>
	</form>
	
	
</body>
</html>
<%@page import="model.BoardDAO"%>
<%@page import="model.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>한 개의 게시물 보기</title>
</head>
<body>
	<%
		int num = Integer.parseInt(request.getParameter("num").trim());
	
		//데이터 베이스 접근 
		BoardDAO bdao = new BoardDAO();
		
		//BoardBean 타입으로 하나의 게시글 리턴
		BoardBean bean = bdao.getOneBoard(num);
	%>
	
	
	<h2>게시글 보기</h2>
	<table width = "600" border = "1">
		<tr height = "40">
			<td width = "120"> 글 번호 </td>
			<td width = "180"> <%= bean.getNum() %> </td>
			<td width = "120"> 조회수 </td>
			<td width = "180"> <%= bean.getReadcount() %> </td>
		</tr>
		<tr height = "40">
			<td width = "120"> 작성자 </td>
			<td width = "180"> <%= bean.getWriter() %> </td>
			<td width = "120"> 작성일 </td>
			<td width = "180"> <%= bean.getReg_date() %> </td>
		</tr>
		<tr height = "40">
			<td width = "120"> 이메일 </td>
			<td colspan = "3"> <%= bean.getEmail() %> </td>
		</tr>
		<tr height = "40">
			<td width = "120"> 제목 </td>
			<td colspan = "3"> <%= bean.getSubject() %> </td>	
		</tr>
		<tr height = "80">
			<td width = "120"> 글 내용 </td>
			<td colspan = "3"> <%= bean.getContent() %> </td>
		</tr>
		<tr height = "40">
			<td colspan = "4"> 
				<input type  = "button" value = "답글쓰기" onclick = "location.href='BoardReWriteForm.jsp?num=<%= bean.getNum() %>&ref=<%= bean.getRef() %>&re_step=<%= bean.getRe_step() %>&re_level=<%= bean.getRe_level() %>'">
				<input type = "button" value = "수정하기" onclick = "location.href='BoardUpdateForm.jsp?num=<%= bean.getNum() %>'">
				<input type = "button" value = "삭제하기" onclick = "location.href='BoardDeleteForm.jsp?num=<%= bean.getNum() %>'">
				<input type = "button" value = "목록보기" onclick = "location.href='BoardList.jsp'">
 			</td>
		</tr>
	</table>
	
</body>
</html>
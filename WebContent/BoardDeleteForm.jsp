<%@page import="model.BoardBean"%>
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
		int num  = Integer.parseInt(request.getParameter("num"));	
	
		BoardDAO bdao = new BoardDAO();
		BoardBean bean = bdao.getOneUpdateBoard(num);
			
	%>
		<form action="BoardDeleteProc.jsp" method = "post">
			<table width = "600" border = "1">
				<tr height = "40">
					<td width = "120">�ۼ���</td>
					<td width = "180"> <%= bean.getWriter() %></td>
					<td width = "120">�ۼ���</td>
					<td width = "180"><%= bean.getReg_date() %></td>
				</tr>
				<tr height = "40">
					<td width = "120">����</td>
					<td colspan = "3"> <%= bean.getSubject() %></td>
				</tr>
				<tr height = "40">
					<td width = "120">��й�ȣ</td>
					<td colspan = "3"> <input type = "password" name = "password"> </td>
				</tr>
				<tr height = "40">
					<td colspan = "4">
						<input type = "hidden" name = "num" value = "<%= bean.getNum() %>">
						<input type = "submit" value = "�� ����">
						<input type = "button" value = "�� ��ü ����" onclick = "location.href = 'BoardList.jsp'">
					</td>
				</tr>
			</table>
		</form>
	
</body>
</html>
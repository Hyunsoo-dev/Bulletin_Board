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

	<h2> �Խñ� ���� </h2>
	<%
		//�ش� �Խñ� ��ȣ�� ���Ͽ� �Խñ� ���� 
		int num = Integer.parseInt(request.getParameter("num").trim());
	
		//�ϳ��� �Խù��� ���� ������ ����
		BoardDAO bdao = new BoardDAO();
		
		BoardBean bean = bdao.getOneUpdateBoard(num);
		
		
	%>
	
	<form action="BoardUpdateProc.jsp" method = "post">
		<table width = "600" border = "1">
			<tr height = "40">
				<td width = "120"> �ۼ��� </td>
				<td width = "180"> <%= bean.getWriter() %> </td>
				<td width = "120"> �ۼ��� </td>
				<td width = "180"> <%= bean.getReg_date() %> </td>
			</tr>
			<tr height = "40">
				<td width = "120"> ���� </td>
				<td width = "480" colspan = "3"> <input type = "text" name = "subject" value = "<%= bean.getSubject() %>" size = "60"></td>
			</tr>
			<tr height = "40">
				<td width = "120"> �н����� </td>
				<td width = "480" colspan = "3"> <input type = "password" name = "password" size = "60"></td>
			</tr>
			<tr height = "40">
				<td width = "120"> �� ���� </td>
				<td width = "480" colspan = "3"> <textarea rows="10" cols="60" name = "content" value = "<%= bean.getContent()%>"> </textarea> </td>
			</tr>
			<tr height = "40">
				<td colspan = "4">
					<input type = "hidden" name = "num" value = "<%= bean.getNum() %>">
					<input type = "submit" value = "�� ����">&nbsp;&nbsp;
					<input type = "button" value = "�� ��� ����" onclick = "location.href = 'BoardList.jsp'">
				</td>
			</tr>
			
		</table>
	</form>
	
	
</body>
</html>
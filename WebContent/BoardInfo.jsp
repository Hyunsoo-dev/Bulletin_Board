<%@page import="model.BoardDAO"%>
<%@page import="model.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�� ���� �Խù� ����</title>
</head>
<body>
	<%
		int num = Integer.parseInt(request.getParameter("num").trim());
	
		//������ ���̽� ���� 
		BoardDAO bdao = new BoardDAO();
		
		//BoardBean Ÿ������ �ϳ��� �Խñ� ����
		BoardBean bean = bdao.getOneBoard(num);
	%>
	
	
	<h2>�Խñ� ����</h2>
	<table width = "600" border = "1">
		<tr height = "40">
			<td width = "120"> �� ��ȣ </td>
			<td width = "180"> <%= bean.getNum() %> </td>
			<td width = "120"> ��ȸ�� </td>
			<td width = "180"> <%= bean.getReadcount() %> </td>
		</tr>
		<tr height = "40">
			<td width = "120"> �ۼ��� </td>
			<td width = "180"> <%= bean.getWriter() %> </td>
			<td width = "120"> �ۼ��� </td>
			<td width = "180"> <%= bean.getReg_date() %> </td>
		</tr>
		<tr height = "40">
			<td width = "120"> �̸��� </td>
			<td colspan = "3"> <%= bean.getEmail() %> </td>
		</tr>
		<tr height = "40">
			<td width = "120"> ���� </td>
			<td colspan = "3"> <%= bean.getSubject() %> </td>	
		</tr>
		<tr height = "80">
			<td width = "120"> �� ���� </td>
			<td colspan = "3"> <%= bean.getContent() %> </td>
		</tr>
		<tr height = "40">
			<td colspan = "4"> 
				<input type  = "button" value = "��۾���" onclick = "location.href='BoardReWriteForm.jsp?num=<%= bean.getNum() %>&ref=<%= bean.getRef() %>&re_step=<%= bean.getRe_step() %>&re_level=<%= bean.getRe_level() %>'">
				<input type = "button" value = "�����ϱ�" onclick = "location.href='BoardUpdateForm.jsp?num=<%= bean.getNum() %>'">
				<input type = "button" value = "�����ϱ�" onclick = "location.href='BoardDeleteForm.jsp?num=<%= bean.getNum() %>'">
				<input type = "button" value = "��Ϻ���" onclick = "location.href='BoardList.jsp'">
 			</td>
		</tr>
	</table>
	
</body>
</html>
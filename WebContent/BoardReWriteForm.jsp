<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�亯 �ۼ�</title>
</head>
<body>

	<h2>�亯 �� ����</h2>
	<%//�Խñ� �б⿡�� �亯 �� ���⸦ Ŭ���ϸ� �Ѱ��ִ� �����͸� �޾���.
		int num = Integer.parseInt(request.getParameter("num"));
		int ref = Integer.parseInt(request.getParameter("ref"));
		int re_step = Integer.parseInt(request.getParameter("re_step"));
		int re_level = Integer.parseInt(request.getParameter("re_level"));
	%>
	
	
	<form action = "BoardReWriteProc.jsp" method = "post">
		<table width = "600" border = "1">
			<tr height = "40">
				<td width = "150"> �ۼ��� </td>
				<td width = "450"> <input type = "text" name = "writer" size = "60"></td>
			</tr>
			<tr height = "40">
				<td width = "150"> ���� </td>
				<td width = "450"> <input type = "text" name = "subject" size = "60" value = "[���]"></td>
			</tr>
			<tr height = "40">
				<td width = "150"> �̸��� </td>
				<td width = "450"> <input type = "email" name = "email" size = "60"></td>
			</tr>
			<tr height = "40">
				<td width = "150"> ��й�ȣ </td>
				<td width = "450"> <input type = "password" name = "password" size = "60"></td>
			</tr>
			<tr height = "40">
				<td width = "150"> �۳��� </td>
				<td width = "450"> <textarea rows="10" cols="60" name = "content"></textarea>
			</tr>
			<!-- form ���� ����ڿ��� �Է¹��� �ʰ� �����͸� �ѱ� -->
			<tr height = "40">
				<td colspan = "2">
					<input type = "hidden" name = "ref" value = "<%= ref %>">
					<input type = "hidden" name = "re_step" value = "<%= re_step %>">
					<input type = "hidden" name = "re_level" value = "<%= re_level %>">
					<input type = "submit" value = "��۾��� �Ϸ�">&nbsp;&nbsp;
					<input type = "reset" value = "���">&nbsp;&nbsp;
					<input type = "button" onclick = "location.href = 'BoardList.jsp'" value = "��ü �� ����">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>

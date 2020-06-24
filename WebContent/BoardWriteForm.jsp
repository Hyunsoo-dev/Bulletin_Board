<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel = "stylesheet" href = "css.css">
<title>게시판 </title>
</head>
<body>
	
<form  action = "BoardWriteProc.jsp" method ="post">
	<table class = "WriterForm" width = "600" border = "1" bordercolor = "gray">
		<tr height = "40">
			<td align = "center" width = "150"> 작성자 </td>
			<td width = "450"><input type = "text" name = "writer" size = "60"></td>
		</tr>
		<tr height = "40">
			<td align = "center" width = "150"> 이메일 </td>
			<td width = "450"><input type = "email" name = "email" size = "60"></td>
		</tr>
		<tr height = "40">
			<td align = "center" width = "150"> 제목 </td>
			<td width = "450"><input type = "text" name = "subject" size = "60"></td>
		</tr>
		<tr height = "40">
			<td align = "center" width = "150"> 비밀번호 </td>
			<td width = "450"><input type = "password" name = "password" size = "60"></td>
		</tr>
		<tr height = "40">
			<td align = "center" width = "150"> 글내용 </td>
			<td width = "450"><textarea rows="10" cols="60" name = "content"></textarea></td>
		</tr>
		<tr height = "40">
			<td align = "center" colspan = "2">
				<input type = "submit" value = "글쓰기"> &nbsp;&nbsp;
				<input type = "reset" value = "다시 작성"> &nbsp;&nbsp;
				<button onclick = "location.href = 'BoardList.jsp'">전체 게시글 보기</button>
			</td>
		</tr>	
	</table>	
</form>
</body>
</html>
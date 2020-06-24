<%@page import="model.BoardBean"%>
<%@page import="java.util.Vector"%>
<%@page import="model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��ü �Խñ� ����</title>
</head>
<body>
	<!-- �Խñ� ���⿡ ī���͸��� �����ϱ� ���� �������� ���� -->	
	<%
		//ȭ�鿡 ������ �Խñ��� ������ ����
		int pageSize = 10;
	
		//���� ī���͸� Ŭ���� ��ȣ���� �о��
		String pageNum = request.getParameter("pageNum");
		//���� ó�� BoardList.jsp �� Ŭ���ϰų� ���� ���� �� �ٸ� �Խñۿ��� �� �������� �Ѿ���� pageNum ���� ���⿡ null ó���� ����
		if(pageNum == null){
			pageNum = "1";
		}
		
		int count = 0; //��ü ���� ������ �����ϴ� ���� 
		int number = 0; //������ �ѹ��� ����
		
		//���� ������ �ϴ� ������ ���ڸ� ����
		int currentPage = Integer.parseInt(pageNum);
		

		//��ü �Խñ��� ������ jsp ������ �����;���.
		BoardDAO bdao = new BoardDAO();
		
		//��ü �Խñ��� ������ �о�帰 �޼ҵ� ȣ��
		count = bdao.getAllCount(); 
		
		//���� �������� ������ ���� ��ȣ�� ���� == ������ ���̽����� �ҷ��� ���۹�ȣ
		int startRow = (currentPage - 1)*pageSize+1;
		int endRow = currentPage * pageSize;
		
		//�ֽ� �� 10���� �������� �Խñ��� ���Ϲ޾��ִ� �޼ҵ� 
		Vector<BoardBean> vec = bdao.getAllBoard(startRow , endRow);
		
		//���̺� ǥ���� ��ȣ�� ����
		number = count - (currentPage - 1) * pageSize;
		
	
	
	
	
	

	%>
	
	<table width = "700" border = "1">
		<tr height = "40">
			<td colspan = "5" align = "right">
				<input type ="button" value = "�۾���" onclick = "location.href = 'BoardWriteForm.jsp'">
			</td>
		</tr>
		<tr height = "40">
			<td width = "50"> ��ȣ </td>
			<td width = "320"> ���� </td>
			<td width = "100"> �ۼ��� </td>
			<td width = "150"> �ۼ��� </td>
			<td width = "80"> ��ȸ�� </td>
		</tr>
		
	<% 
		for(int i = 0; i< vec.size(); i++){
		 	BoardBean bean = vec.get(i);
		
	%>
		<tr>	
			<td width = "50"> <%= number-- %> </td>
			<td width = "320" align = "left"><a href="BoardInfo.jsp?num=<%= bean.getNum() %>" style = "text-decoration : none">
			
			<%
				for(int j = 0; j < (bean.getRe_step()-1)*5; j++){
			%>	
				&nbsp;
			<% 
				}
			%>
			<%= bean.getSubject() %></a></td>
			<td width = "100"> <%= bean.getWriter() %> </td>
			<td width = "150"> <%= bean.getReg_date() %> </td>
			<td width = "80"> <%= bean.getReadcount() %> </td>
		</tr>	
	<%
		}
	%>
		
		
	</table>
	<p>
	<!-- ������ ī���͸� �ҽ��� �ۼ� -->
	<% 
		if(count > 0){
			
			int pageCount = count / pageSize + (count%pageSize == 0 ? 0 : 1);//ī���͸� ���ڸ� �󸶱��� �����ٰ��� ���� 
			
			//���� ������ ���ڸ� ����
			int startPage = 1;
			
			if(currentPage % 10 != 0){
				startPage = (int)(currentPage/10)*10+1;
			}else{
				startPage = ((int)(currentPage/10 - 1))*10+1;
			}
			
			int pageBlock = 10; //ī���͸� ó�� ���� 
			int endPage = startPage + pageBlock - 1;//ȭ�鿡 ������ �������� ������ ����
			
			if(endPage > pageCount) endPage = pageCount;
			
			//���� �̶�� ��ũ�� ������� �ľ� 
			if(startPage > 10){
	%>
			<a href = "BoardList.jsp?pageNum=<%= startPage - 10 %>"> [����] </a>
			
			
	<%
			}
			
			for(int i = startPage ; i <= endPage; i++){
	%>
	
			<a href = "BoardList.jsp?pageNum=<%= i %>"> [<%= i %>] </a>
	<%			
		
			}
			//���� �̶�� ��ũ�� ������� �ľ�
			if(endPage < pageCount){
				
	%>
			<a href = "BoardList.jsp?pageNum=<%= startPage + 10 %>"> [����] </a>
	<%			
			}
			
		}	
	%>
	
</body>
</html>
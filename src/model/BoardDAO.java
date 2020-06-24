package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {

	
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	
	
	public void getCon() {
		
		//Ŀ�ؼ� Ǯ�� �̿��Ͽ� ������ ���̽��� ���� 
		try {
			//�ܺο��� �����͸� �о����� �ϱ⿡ 
			Context initctx = new InitialContext();
			//��Ĺ ������ ������ ��Ƴ��� ������ �̵� 
			Context envctx = (Context)initctx.lookup("java:comp/env");
			
			//������ �ҽ� ��ü�� ���� 
			DataSource ds = (DataSource)envctx.lookup("jdbc/pool");
			con = ds.getConnection();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		/*try {
			
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String id = "system";
			String pw = "1234";
			String driver = "oracle.jdbc.driver.OracleDriver";
		
			Class.forName(driver);
			con = DriverManager.getConnection(url, id, pw);
					
		} catch (Exception e) {
			e.printStackTrace();
		}*/
	}
	
	
	
	//�ϳ��� �Խù��� �Ѿ�ͼ� ����Ǵ� �޼ҵ�
	public void insertBoard(BoardBean bean) {
		
		getCon();
		
		//�� Ŭ������ �Ѿ���� ���� ������ �ʱ�ȭ ����.
		int ref = 0;//�� �׷��� �ǹ� = ������ ������Ѽ� ���� ū ref ���� ������ �� +1 �� �����ָ��.
		int re_step = 1;
		int re_level = 1;
		
		
		try {
			//���� ū ref ���� �о���� ���� �غ�  
			//���� ������ 0�� ���ϵ�.
			String refsql = "select max(ref) from board";
			//���� ���� ��ü 
			pstmt = con.prepareStatement(refsql);
			//���� ���� �� ����� ����
			rs = pstmt.executeQuery();
			
			if(rs.next()) {//��� ���� �ִٸ� 
				
				ref = rs.getInt(1) + 1;//�ִ밪�� +1�� ���ؼ� �۱׷��� ����
				
			}
			
			
			
			//������ �Խñ� ��ü ���� ���̺� ����
			String sql = "insert into board values (board_seq.nextval ,?,?,?,?,sysdate,?,?,?,0,?)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getWriter());
			pstmt.setString(2, bean.getEmail());
			pstmt.setString(3, bean.getSubject());
			pstmt.setString(4, bean.getPassword());
			pstmt.setInt(5, ref);
			pstmt.setInt(6, re_step);
			pstmt.setInt(7, re_level);
			pstmt.setString(8, bean.getContent());
			
			//������ ���� 
			pstmt.executeUpdate();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	//��� �Խñ��� �������ִ� �޼ҵ� �ۼ�
	public Vector<BoardBean> getAllBoard(int start , int end){
		
		//���� �� ��ü ����
		Vector<BoardBean> v = new Vector<BoardBean>();
		
		getCon();
		
		try {
			
			String sql = "select * from (select A.* , Rownum Rnum from (select * from board order by ref desc, re_step asc)A) where Rnum >= ? and Rnum <= ?";
			//������ ���� �� ��ü ���� 
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			//���� ���� �� ��� ���� 
			rs = pstmt.executeQuery();
			//������ ������ ����� �𸣱⿡ �ݺ����� �̿��Ͽ� ������ ����.
			
			while(rs.next()) {
				//�����͸� ��Ű¡ ����(���� = BoardBean)
				BoardBean bean = new BoardBean();
				bean.setNum(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getDate(6).toString());
				bean.setRef(rs.getInt(7));
				bean.setRe_step(rs.getInt(8));
				bean.setRe_level(rs.getInt(9));
				bean.setReadcount(rs.getInt(10));
				bean.setContent(rs.getString(11));
				
				v.add(bean);
				
				
			}
				con.close();	
			
		} catch (Exception e) {
			e.printStackTrace();
		}
			return v;
	}
	
	
	//boardInfo �� �ϳ��� �Խñ��� �����ϴ� �޼ҵ� �ۼ� 
	public BoardBean getOneBoard(int num) {
		
		
		//���� Ÿ�� ����
		BoardBean bean = new BoardBean();
		getCon();
		
		try {
			//��ȸ �� ���� ����
			String readsql = "update board set readcount = readcount + 1 where num = ?";
			pstmt = con.prepareStatement(readsql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			
			//���� �غ�
			String sql = "select * from board where num = ?";
			//���� ���� ��ü
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,num);
			//�������� ����
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bean.setNum(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getDate(6).toString());
				bean.setRef(rs.getInt(7));
				bean.setRe_step(rs.getInt(8));
				bean.setRe_level(rs.getInt(9));
				bean.setReadcount(rs.getInt(10));
				bean.setContent(rs.getString(11));
			}
			
			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bean;
	}
	
	//boardUpdate , boardDelete �� �ϳ��� �Խù��� ���� 
	public BoardBean getOneUpdateBoard(int num) {
		
		
		//���� Ÿ�� ����
		BoardBean bean = new BoardBean();
		getCon();
		
		try {
			
			
			//���� �غ�
			String sql = "select * from board where num = ?";
			//���� ���� ��ü
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,num);
			//�������� ����
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bean.setNum(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getDate(6).toString());
				bean.setRef(rs.getInt(7));
				bean.setRe_step(rs.getInt(8));
				bean.setRe_level(rs.getInt(9));
				bean.setReadcount(rs.getInt(10));
				bean.setContent(rs.getString(11));
			}
			
			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bean;
	}
	
	
	//�亯 �� �����ϴ� �޼ҵ� ���� 
	public void reWriteBoard(BoardBean bean) {
		
		//�θ� �� �׷�� �� ����, �� ������ �о�帲.
		int ref = bean.getRef();
		int re_step = bean.getRe_step();
		int re_level = bean.getRe_level();
		
		getCon();
		try {
			
			String levelsql = "update board set re_level = re_level + 1 where ref = ? and re_level > ?";
			//���� ���� ��ü ���� 
			pstmt = con.prepareStatement(levelsql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, re_level);
			
			//���� ����
			pstmt.executeUpdate();
			
			
			String sql = "insert into board values(board_seq.nextval,?,?,?,?,sysdate,?,?,?,0,?)";
			pstmt = con.prepareStatement(sql);
			
			//?�� ���� ����.
			pstmt.setString(1, bean.getWriter());
			pstmt.setString(2, bean.getEmail());
			pstmt.setString(3, bean.getSubject());
			pstmt.setString(4, bean.getPassword());
			pstmt.setInt(5,ref); //�θ� ref �־���
			pstmt.setInt(6,re_step + 1);//����̹Ƿ� �θ� re_step �� 1 ������.
			pstmt.setInt(7,re_level + 1);//������ �ִ� ����� re_level �� 1�� ���������Ƿ� ���⼱ �θ� ���� re_level + 1 �� ����.
			pstmt.setString(8, bean.getContent());
			pstmt.executeUpdate();
			
			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	//update �� delete �� �ʿ��� �н����� ���� �������ִ� �޼ҵ�
	public String getPass(int num) {
		//���� �� ���� ��ü ����
		String pass = "";
		getCon();
		
		try {
			//���� �غ�
			String sql = "select password from board where num = ? ";
			//������ ���� �� ��ü ����
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				pass = rs.getString(1);
			}
			
			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		 return pass;
	}
	
	//�ϳ��� �Խñ��� �����ϴ� �޼ҵ� 
	public void updateBoard(BoardBean bean) {
		
		getCon();
		
		try {
			//���� �غ� 
			String sql = "update board set subject = ? , content = ? where num = ?";
			//���� ���� �� ��ü ���� 
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getSubject());
			pstmt.setString(2, bean.getContent());
			pstmt.setInt(3, bean.getNum());
			
			pstmt.executeUpdate();
			
			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	//�Խñ��� �����ϴ� �޼ҵ�
	public void deleteBoard(int num) {
		
		getCon();
		
		try {
			
			//���� ���� 
			String sql = "delete from board where num = ?";
			//���� ���� �� ��ü ����
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	//��ü ���� ������ �����ϴ� �޼ҵ� 
	public int getAllCount() {
		
		getCon();
		
		//�Խñ� ��ü ���� �����ϴ� ���� ���� 
		int count = 0;
		
		try {
			//���� �غ�
			String sql = "select count(*) from board ";
			
			//���� ���� �� ��ü ����
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
}
 
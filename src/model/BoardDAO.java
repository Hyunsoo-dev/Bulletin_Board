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
		
		//커넥션 풀을 이용하여 데이터 베이스에 접근 
		try {
			//외부에서 데이터를 읽어드려야 하기에 
			Context initctx = new InitialContext();
			//톰캣 서버에 정보를 담아놓은 곳으로 이동 
			Context envctx = (Context)initctx.lookup("java:comp/env");
			
			//데이터 소스 객체를 선언 
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
	
	
	
	//하나의 게시물이 넘어와서 저장되는 메소드
	public void insertBoard(BoardBean bean) {
		
		getCon();
		
		//빈 클래스에 넘어오지 않은 값들을 초기화 해줌.
		int ref = 0;//글 그룹을 의미 = 쿼리를 실행시켜서 가장 큰 ref 값을 가져온 후 +1 을 더해주면됨.
		int re_step = 1;
		int re_level = 1;
		
		
		try {
			//가장 큰 ref 값을 읽어오는 쿼리 준비  
			//값이 없으면 0이 리턴됨.
			String refsql = "select max(ref) from board";
			//쿼리 실행 객체 
			pstmt = con.prepareStatement(refsql);
			//쿼리 실행 후 결과를 리턴
			rs = pstmt.executeQuery();
			
			if(rs.next()) {//결과 값이 있다면 
				
				ref = rs.getInt(1) + 1;//최대값에 +1을 더해서 글그룹을 설정
				
			}
			
			
			
			//실제로 게시글 전체 값을 테이블에 저장
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
			
			//쿼리를 실행 
			pstmt.executeUpdate();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	//모든 게시글을 리턴해주는 메소드 작성
	public Vector<BoardBean> getAllBoard(int start , int end){
		
		//리턴 할 객체 선언
		Vector<BoardBean> v = new Vector<BoardBean>();
		
		getCon();
		
		try {
			
			String sql = "select * from (select A.* , Rownum Rnum from (select * from board order by ref desc, re_step asc)A) where Rnum >= ? and Rnum <= ?";
			//쿼리를 실행 할 객체 선언 
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			//쿼리 실행 후 결과 저장 
			rs = pstmt.executeQuery();
			//데이터 개수가 몇개인지 모르기에 반복문을 이용하여 데이터 추출.
			
			while(rs.next()) {
				//데이터를 패키징 해줌(가방 = BoardBean)
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
	
	
	//boardInfo 용 하나의 게시글을 리턴하는 메소드 작성 
	public BoardBean getOneBoard(int num) {
		
		
		//리턴 타입 선언
		BoardBean bean = new BoardBean();
		getCon();
		
		try {
			//조회 수 증가 쿼리
			String readsql = "update board set readcount = readcount + 1 where num = ?";
			pstmt = con.prepareStatement(readsql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			
			//쿼리 준비
			String sql = "select * from board where num = ?";
			//쿼리 실행 객체
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,num);
			//실행결과를 리턴
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
	
	//boardUpdate , boardDelete 용 하나의 게시물을 리턴 
	public BoardBean getOneUpdateBoard(int num) {
		
		
		//리턴 타입 선언
		BoardBean bean = new BoardBean();
		getCon();
		
		try {
			
			
			//쿼리 준비
			String sql = "select * from board where num = ?";
			//쿼리 실행 객체
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,num);
			//실행결과를 리턴
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
	
	
	//답변 글 저장하는 메소드 설정 
	public void reWriteBoard(BoardBean bean) {
		
		//부모 글 그룹과 글 스텝, 글 레벨을 읽어드림.
		int ref = bean.getRef();
		int re_step = bean.getRe_step();
		int re_level = bean.getRe_level();
		
		getCon();
		try {
			
			String levelsql = "update board set re_level = re_level + 1 where ref = ? and re_level > ?";
			//쿼리 실행 객체 선언 
			pstmt = con.prepareStatement(levelsql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, re_level);
			
			//쿼리 실행
			pstmt.executeUpdate();
			
			
			String sql = "insert into board values(board_seq.nextval,?,?,?,?,sysdate,?,?,?,0,?)";
			pstmt = con.prepareStatement(sql);
			
			//?에 값을 대입.
			pstmt.setString(1, bean.getWriter());
			pstmt.setString(2, bean.getEmail());
			pstmt.setString(3, bean.getSubject());
			pstmt.setString(4, bean.getPassword());
			pstmt.setInt(5,ref); //부모 ref 넣어줌
			pstmt.setInt(6,re_step + 1);//답글이므로 부모 re_step 에 1 더해줌.
			pstmt.setInt(7,re_level + 1);//기존에 있던 답글의 re_level 은 1씩 더해졌으므로 여기선 부모 글의 re_level + 1 만 해줌.
			pstmt.setString(8, bean.getContent());
			pstmt.executeUpdate();
			
			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	//update 와 delete 시 필요한 패스워드 값을 리턴해주는 메소드
	public String getPass(int num) {
		//리턴 할 변수 객체 선언
		String pass = "";
		getCon();
		
		try {
			//쿼리 준비
			String sql = "select password from board where num = ? ";
			//쿼리문 실행 할 객체 선언
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
	
	//하나의 게시글을 수정하는 메소드 
	public void updateBoard(BoardBean bean) {
		
		getCon();
		
		try {
			//쿼리 준비 
			String sql = "update board set subject = ? , content = ? where num = ?";
			//쿼리 실행 할 객체 생성 
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
	
	//게시글을 삭제하는 메소드
	public void deleteBoard(int num) {
		
		getCon();
		
		try {
			
			//쿼리 생성 
			String sql = "delete from board where num = ?";
			//쿼리 실행 할 객체 생성
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	//전체 글의 갯수를 리턴하는 메소드 
	public int getAllCount() {
		
		getCon();
		
		//게시글 전체 수를 저장하는 변수 설정 
		int count = 0;
		
		try {
			//쿼리 준비
			String sql = "select count(*) from board ";
			
			//쿼리 실행 할 객체 선언
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
 
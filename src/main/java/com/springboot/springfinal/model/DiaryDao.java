package com.springboot.springfinal.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.springframework.stereotype.Repository;

@Repository("diaryDao")
public class DiaryDao {
	
	String id= "root";
	String password= "111111";
	String url = "jdbc:mysql://localhost:3306/springfinal?characterEncoding=utf-8";
	
	//jdbc에 필요한 객체를 위한 변수 전역변수 설정하여 사용함 
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public Connection getConn() {
		try {
			//1.드라이버 로딩	
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("드라이버 로딩 완료... ");
			
			//2. 디비 서버에 연결(url, id, password)
			return DriverManager.getConnection(url, id, password);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		//디비연결 에러시에 null 리턴...
		return null;
	}
	
	public void closeConn(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			finally {
				pstmt = null;
			}
		}
		if(rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			finally {
				rs = null;
			}
		}
		if(conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			finally {
				conn = null;
			}
		}
		
		
		
		
	}
		
	//DiaryDo에 저장된 데이터를 디비에 저장하는 메소드
	public void insertDiary(DiaryDo bdo) {
		System.out.println("insertDiary() 처리 시작 ");		
		//1. 디비 연결
		conn = getConn();	
		
		try {
			//2. sql문 완성 (pstmt 객체)
			String sql = "insert into Diary values(null,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			//? 채우기
			pstmt.setString(1, bdo.getTitle());
			pstmt.setString(2, bdo.getUserId());
			pstmt.setString(3, bdo.getContent());
			
			//3. sql문 실행 : 디비 테이블의 변화가 있기때문에, executeUpdate() 이용
			pstmt.executeUpdate(); 
			
			//4. 디비연결해제
			closeConn(conn, pstmt, rs);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}	


	//4. getDiaryList() : 디비로 부터 전체 데이터를 가져오는 메소드 
	public ArrayList<DiaryDo> getDiaryList(){
		System.out.println("getDiaryList() 처리 시작 !! ");
		//리턴 변수 설정...
		ArrayList<DiaryDo> bList = new ArrayList<>();
		
		//1. jdbc: 디비 연결하기 
		conn = getConn();
				
		try {
			//2. jdbc: sql문 완성하기 
			String sql = "select * from Diary";
			pstmt  = conn.prepareStatement(sql);
			
			//3. jdbc: sql 문 실행 
			//디비 테이블에 변화가 없기때문에, executeQuery() 이용
			rs = pstmt.executeQuery(); 
			
			//4. jdbc: ** sql문 실행결과 처리 **
			while(rs.next()) { //테이블 데이터가 있다면, 
				DiaryDo bdo = new DiaryDo(); //DO 객체 생성하여, 멤버변수에 테이블 데이터 저장 
				bdo.setSeq( rs.getInt(1));   
				bdo.setTitle(rs.getString(2));
				bdo.setUserId(rs.getString(3));
				bdo.setContent(rs.getString(4));
				
				bList.add(bdo); //배열에 DO 저장...
			}
			closeConn(conn, pstmt, rs);
			System.out.println("getDiaryList() 처리 완료 !!");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		

	
	
		return bList;
	}

	//5. updateDiary() : 디비의 특정(seq) 데이터를 수정하는 메소드
	public void updateDiary(DiaryDo bdo) {
		System.out.println("updateDiary() 처리 시작 !! ");
		
		//1. jdbc : 디비 연결 
		conn = getConn();	
		
		try {
			//2. jdbc : sql문 완성 
			String sql = "update Diary set title=?, content=? where seq=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bdo.getTitle()); // 첫번째 ?에 값 설정
			pstmt.setString(2, bdo.getContent()); // 두번째 ?에 값 설정
			pstmt.setInt(3, bdo.getSeq()); // 세번째 ?에 값 설정
			
			
			//3. jdbc : sql문 실행
			pstmt.executeUpdate();//테이블의 변화가 있기 때문에, executeUpdate() 이용
			
			//4. jdbc : 연결종료
			closeConn(conn, pstmt, rs);
			
			System.out.println("updateDiary() 처리 완료 !!");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
	}

	//6. deleteDiary() : 디비의 특정(seq) 데이터를 삭제하는 메소드
	public void deleteDiary(int seq) {
		System.out.println("deleteDiary() 처리 시작 !!");
		
		//1. jdbc : 디비 연결 
		conn = getConn();	
		
		try {
			//2. jdbc : sql문 완성 
			String sql = "delete from Diary where seq=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, seq); // 첫번째 ?에 값 설정
			
			//3. jdbc : sql문 실행
			pstmt.executeUpdate();//테이블의 변화가 있기 때문에, executeUpdate() 이용
			
			//4. jdbc : 연결종료
			closeConn(conn, pstmt, rs);
			
			System.out.println("deleteDiary() 처리 완료 !!");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
	}

	//7. getOneDiary() : 디비로 부터 특정(seq) 데이터를 가져오는 메소드 
	public DiaryDo getOneDiary(int seq) {
		System.out.println("getOneDiary() 처리 시작 !!");
		//하나의 데이터를 가져와서 리턴할 DiaryDo 객체 생성.. 
		DiaryDo bdo = new DiaryDo();
		
		//1. jdbc: 디비 연결하기 
		conn = getConn();
				
		try {
			//2. jdbc: sql문 완성하기 
			String sql = "select * from  Diary where seq=?";			
			pstmt  = conn.prepareStatement(sql);
			pstmt.setInt(1, seq);
						
			//3. jdbc: sql 문 실행 
			//디비 테이블에 변화가 없기때문에, executeQuery() 이용
			rs = pstmt.executeQuery(); 
			
			//4. jdbc: ** sql문 실행결과 처리 **
			while(rs.next()) { //테이블 데이터가 있다면,				 
				bdo.setSeq( rs.getInt(1));   
				bdo.setTitle(rs.getString(2));
				bdo.setUserId(rs.getString(3));
				bdo.setContent(rs.getString(4));
			}
			closeConn(conn, pstmt, rs);
			System.out.println("getOneDiary() 처리 완료 !!");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return bdo;
	}
	
	//8. searchDiaryList() : 디비로 부터 전체 데이터를 가져오는 메소드 
	public ArrayList<DiaryDo> searchDiaryList(String searchCon, String searchKey){
		System.out.println("searchDiaryList() 처리 시작 !! ");
		
		//리턴 변수 설정...
		ArrayList<DiaryDo> bList = new ArrayList<>();
		
		//1. jdbc: 디비 연결하기 
		conn = getConn();
				
		try {
			//2. jdbc: sql문 완성하기 
			//String sql = "select * from Diary";
			String sql = "";
			
			if (searchCon.equals("title")) {
				sql="select * from Diary where title=? order by seq desc";
			} else if (searchCon.equals("content")) {
				sql="select * from Diary where content=? order by seq desc";
			} else if (searchCon.equals("writer")) {
				sql="select * from Diary where writer=? order by seq desc";
			} else {
				return null;
			}
			
			pstmt  = conn.prepareStatement(sql);
			pstmt.setString(1, searchKey);
			
			//3. jdbc: sql 문 실행 
			//디비 테이블에 변화가 없기때문에, executeQuery() 이용
			rs = pstmt.executeQuery(); 
			
			//4. jdbc: ** sql문 실행결과 처리 **
			while(rs.next()) { //테이블 데이터가 있다면, 
				DiaryDo bdo = new DiaryDo(); //DO 객체 생성하여, 멤버변수에 테이블 데이터 저장 
				bdo.setSeq( rs.getInt(1));   
				bdo.setTitle(rs.getString(2));
				bdo.setUserId(rs.getString(3));
				bdo.setContent(rs.getString(4));
				
				bList.add(bdo); //배열에 DO 저장...
			}
			closeConn(conn, pstmt, rs);
			System.out.println("getDiaryList() 처리 완료 !!");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return bList;
	}

}

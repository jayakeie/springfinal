package com.springboot.springfinal.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository("DiaryDaoSpring")
public class DiaryDaoSpring {
	
	String id= "root";
	String password= "111111";
	String url = "jdbc:mysql://localhost:3306/springfinal?characterEncoding=utf-8";
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public Connection getConn() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("드라이버 로딩 완료... ");

			return DriverManager.getConnection(url, id, password);
			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return null;
	}
	
	public void closeConn(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
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
				e.printStackTrace();
			}
			finally {
				conn = null;
			}
		}
	}
			
	//DiaryDo에 저장된 데이터를 디비에 저장하는 메소드
	public void insertDiary(DiaryDo ddo) {
	    System.out.println("insertDiary() 처리 시작");
	    String sql = "INSERT INTO Diary (userId, title, content, category, date) VALUES (?,?,?,?,?)";
	    
	    LocalDateTime dateTime = LocalDateTime.parse(ddo.getDate() + "T00:00:00");
	    jdbcTemplate.update(sql, 
	        ddo.getUserId(), 
	        ddo.getTitle(), 
	        ddo.getContent(), 
	        ddo.getCategory(), 
	        dateTime
	    );
	    System.out.println("insertDiary() 처리 완료!");
	}


	//4. getDiaryList() : 디비로 부터 전체 데이터를 가져오는 메소드 
	public ArrayList<DiaryDo> getDiaryList(){
		System.out.println("getDiaryList() 처리 시작 !! ");
		String sql = "select * from Diary";
		
		return (ArrayList<DiaryDo>)jdbcTemplate.query(sql, new DiaryRowMapper());
	}

	//5. updateDiary() : 디비의 특정(seq) 데이터를 수정하는 메소드
	public void updateDiary(DiaryDo ddo) {
		System.out.println("(Spring JDBC) updateDiary() 처리 시작 !! ");
		
		//jdbc: sql문 완성
		String sql = "update Diary set title=?, content=? where seq=?";
		jdbcTemplate.update(sql, ddo.getTitle(), ddo.getContent(), ddo.getSeq());
	}

	//6. deleteDiary() : 디비의 특정(seq) 데이터를 삭제하는 메소드
	public void deleteDiary(int seq) {
		System.out.println("(Spring JDBC) deleteDiary() 처리 시작 !!");
		
		//2. jdbc : sql문 완성 
		String sql = "delete from Diary where seq=?";
		Object[] args = {seq}; //?를 채우기 위함
		jdbcTemplate.update(sql, args);
	}

	//7. getOneDiary() : 디비로 부터 특정(seq) 데이터를 가져오는 메소드
	//
	public DiaryDo getOneDiary(int seq) {
		System.out.println("(Spring JDBC) getOneDiary() 처리 시작 !!");
		//JDBC로 SQL문 완성하기
		String sql = "select * from  Diary where seq=?";
		Object[] args = {seq};
		
		return jdbcTemplate.queryForObject(sql, args, new DiaryRowMapper());
	}
	
	//8. searchDiaryList() : 디비로 부터 전체 데이터를 가져오는 메소드 
	public ArrayList<DiaryDo> searchDiaryList(String searchCon, String searchKey){
		System.out.println("(Spring JDBC) searchDiaryList() 처리 시작 !! ");
		
		//리턴 변수 설정...
		ArrayList<DiaryDo> dList = new ArrayList<>();

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
		Object[] args = {searchKey};
		return (ArrayList<DiaryDo>)jdbcTemplate.query(sql, args, new DiaryRowMapper());
	}

}


class DiaryRowMapper implements RowMapper<DiaryDo> {

	@Override
	public DiaryDo mapRow(ResultSet rs, int rowNum) throws SQLException {
		System.out.println("mapRow() 처리 중");
		DiaryDo ddo = new DiaryDo();
		ddo.setSeq(rs.getInt(1));
		ddo.setTitle(rs.getString(2));
		ddo.setUserId(rs.getString(3));
		ddo.setContent(rs.getString(4));
		
		return ddo;
	}
}
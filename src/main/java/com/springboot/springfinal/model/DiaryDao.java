package com.springboot.springfinal.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

@Repository
public class DiaryDao {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;

    //insert (생성된 PK 반환)
    public int insertDiary(DiaryDo ddo) {
        String sql = "INSERT INTO diary (user_id, name, title, content, category, diary_date) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";
        
        KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.update(new PreparedStatementCreator() {
            @Override
            public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
                PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                pstmt.setString(1, ddo.getUserId());
                pstmt.setString(2, ddo.getName());
                pstmt.setString(3, ddo.getTitle());
                pstmt.setString(4, ddo.getContent());
                pstmt.setString(5, ddo.getCategory());
                pstmt.setString(6, ddo.getDate());
                return pstmt;
            }
        }, keyHolder);

        return keyHolder.getKey().intValue(); 
    }

    //insert image
    public void insertDiaryImage(ImageDo imageDo) {
        String sql = "INSERT INTO images (diary_id, original_name, stored_name) VALUES (?, ?, ?)";
        
        jdbcTemplate.update(sql, 
                imageDo.getDiaryId(), 
                imageDo.getOriginalName(), 
                imageDo.getStoredName());
    }

    //select all (이미지 여러 장을 콤마로 연결해서 가져옴)
    public List<DiaryDo> getDiaryList(String userId){
        String sql = "SELECT d.*, " 
                   + "       (SELECT GROUP_CONCAT(stored_name SEPARATOR ',') FROM images WHERE diary_id = d.diary_id) as images " 
                   + "FROM diary d "
                   + "WHERE user_id = ? "
                   + "ORDER BY diary_date DESC, diary_id DESC";
        
        return jdbcTemplate.query(sql, new Object[]{userId}, new DiaryRowMapper());
    }

    //modify
    public void updateDiary(DiaryDo ddo) {
        String sql = "UPDATE diary SET title=?, content=?, category=?, name=? WHERE diary_id=?";
        
        jdbcTemplate.update(sql, 
                ddo.getTitle(), 
                ddo.getContent(), 
                ddo.getCategory(), 
                ddo.getName(), 
                ddo.getDiaryId());
    }

    //일기별 이미지 목록 (수정 화면용)
    public List<ImageDo> getDiaryImages(int diaryId) {
        String sql = "SELECT * FROM images WHERE diary_id = ?";
        
        return jdbcTemplate.query(sql, new Object[]{diaryId}, new RowMapper<ImageDo>() {
            @Override
            public ImageDo mapRow(ResultSet rs, int rowNum) throws SQLException {
                return new ImageDo(
                    rs.getInt("diary_id"),
                    rs.getString("original_name"),
                    rs.getString("stored_name")
                );
            }
        });
    }

    //저장된 이름으로 이미지 삭제
    public void deleteDiaryImageByStoredName(String storedName) {
        String sql = "DELETE FROM images WHERE stored_name = ?";
        jdbcTemplate.update(sql, storedName);
    }

    //삭제
    public void deleteDiary(int diaryId) {
        String sql = "DELETE FROM diary WHERE diary_id=?";
        jdbcTemplate.update(sql, diaryId);
    }

    //select one (상세 보기용)
    public DiaryDo getOneDiary(int diaryId) {
        String sql = "SELECT d.*, " 
                   + "       (SELECT GROUP_CONCAT(stored_name SEPARATOR ',') FROM images WHERE diary_id = d.diary_id) as images " 
                   + "FROM diary d "
                   + "WHERE diary_id=?";
        try {
            return jdbcTemplate.queryForObject(sql, new Object[]{diaryId}, new DiaryRowMapper());
        } catch (Exception e) { 
            return null; 
        }
    }
    
    //검색
    public List<DiaryDo> searchDiaryList(String userId, String searchCon, String searchKey){
        String sqlBase = "SELECT d.*, "
                       + "       (SELECT GROUP_CONCAT(stored_name SEPARATOR ',') FROM images WHERE diary_id = d.diary_id) as images "
                       + "FROM diary d "
                       + "WHERE user_id = ? ";
        
        String likeKey = "%" + searchKey + "%";

        if (searchCon.equals("title")) {
            String sql = sqlBase + "AND title LIKE ? ORDER BY diary_date DESC";
            return jdbcTemplate.query(sql, new Object[]{userId, likeKey}, new DiaryRowMapper());
            
        } else if (searchCon.equals("content")) {
            String sql = sqlBase + "AND content LIKE ? ORDER BY diary_date DESC";
            return jdbcTemplate.query(sql, new Object[]{userId, likeKey}, new DiaryRowMapper());
            
        } else if (searchCon.equals("name")) {
            String sql = sqlBase + "AND name LIKE ? ORDER BY diary_date DESC";
            return jdbcTemplate.query(sql, new Object[]{userId, likeKey}, new DiaryRowMapper());
        }
        
        //조건이 맞지 않을 경우 전체 목록
        return jdbcTemplate.query(sqlBase + "ORDER BY diary_date DESC", new Object[]{userId}, new DiaryRowMapper());
    }
}

class DiaryRowMapper implements RowMapper<DiaryDo> {
    
    @Override
    public DiaryDo mapRow(ResultSet rs, int rowNum) throws SQLException {
        DiaryDo ddo = new DiaryDo();
        
        ddo.setDiaryId(rs.getInt("diary_id"));
        ddo.setUserId(rs.getString("user_id"));
        ddo.setName(rs.getString("name"));
        ddo.setTitle(rs.getString("title"));
        ddo.setContent(rs.getString("content"));
        ddo.setCategory(rs.getString("category"));
        
        java.sql.Date date = rs.getDate("diary_date");
        if (date != null) {
            ddo.setDate(date.toString());
        }
        
        try {
            // images 컬럼 매핑 (GROUP_CONCAT 결과)
            ddo.setImages(rs.getString("images"));
        } catch (SQLException e) {
            // images 컬럼이 없는 경우 무시
        }
        
        return ddo;
    }
}
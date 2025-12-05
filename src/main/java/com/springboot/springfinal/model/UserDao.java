package com.springboot.springfinal.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository
public class UserDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    //회원가입
    public void insertUser(UserDo user) {
        String sql = "INSERT INTO users (user_id, password, nickname) VALUES (?, ?, ?)";
        
        jdbcTemplate.update(sql, 
                user.getUserId(), 
                user.getPassword(), 
                user.getNickname());
    }

    //로그인 처리
    public UserDo login(String userId, String password) {
        String sql = "SELECT * FROM users WHERE user_id = ? AND password = ?";
        
        try {
            return jdbcTemplate.queryForObject(sql, new Object[]{userId, password}, new UserRowMapper());
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }
    
    //아이디 중복 체크
    public boolean checkId(String userId) {
        String sql = "SELECT count(*) FROM users WHERE user_id = ?";
        
        int count = jdbcTemplate.queryForObject(sql, new Object[]{userId}, Integer.class);
        
        return count > 0;
    }

    //회원 정보 조회 (마이페이지)
    public UserDo getUser(String userId) {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        
        try {
            return jdbcTemplate.queryForObject(sql, new Object[]{userId}, new UserRowMapper());
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    //회원 정보 수정 (닉네임, 비밀번호 변경)
    public void updateUser(UserDo user) {
        String sql = "UPDATE users SET nickname = ? WHERE user_id = ?";
        
        jdbcTemplate.update(sql, 
                user.getNickname(), 
                user.getUserId());
    }
}

class UserRowMapper implements RowMapper<UserDo> {
    
    @Override
    public UserDo mapRow(ResultSet rs, int rowNum) throws SQLException {
        UserDo user = new UserDo();
        
        user.setUserId(rs.getString("user_id"));
        user.setPassword(rs.getString("password"));
        user.setNickname(rs.getString("nickname"));
        user.setJoinedDate(rs.getString("joined_date"));
        
        return user;
    }
}
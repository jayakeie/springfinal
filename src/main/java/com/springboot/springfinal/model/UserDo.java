package com.springboot.springfinal.model;

public class UserDo {
    
    private String userId;
    private String password;
    private String nickname;
    private String joinedDate;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getJoinedDate() {
        return joinedDate;
    }

    public void setJoinedDate(String joinedDate) {
        this.joinedDate = joinedDate;
    }

    @Override
    public String toString() {
        return "UserDo [userId=" + userId + ", nickname=" + nickname + "]";
    }
}
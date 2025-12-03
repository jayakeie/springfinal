package com.springboot.springfinal.model;

import java.time.LocalDateTime;

public class DiaryDo {
	private int seq; //primary key
	private String title;
	private String userId;
	private String content;
	private String category;
	private String date;
	
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	
	public String toString() {
		return "DiaryDo [seq=" + seq + ", title=" + title + ", Id=" + userId + ", content=" + content + ", category=" + category + ", date=" + date + "]";
	}
}

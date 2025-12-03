package com.springboot.springfinal.service;

import java.util.ArrayList;

import com.springboot.springfinal.model.DiaryDo;

public interface DiaryService {
	//새로운 글 등록 메소드
	void insertDiary(DiaryDo ddo);
	
	//전체 글 가져오는 메소드
	ArrayList<DiaryDo> getDiaryList();
	
	//글 조회
	DiaryDo getOneDiary(int seq);
	
	//글 수정
	void updateDiary(DiaryDo ddo);
	
	//글 삭제
	void deleteDiary(int seq);
}

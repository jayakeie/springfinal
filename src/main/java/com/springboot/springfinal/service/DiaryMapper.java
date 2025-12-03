package com.springboot.springfinal.service;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.springfinal.model.DiaryDo;

@Mapper
public interface DiaryMapper {
	//새로운 글 등록 메소드
	void insertDiary(DiaryDo bdo);
	
	//전체 글 가져오는 메소드
	ArrayList<DiaryDo> getDiaryList();
	
	//글 조회
	DiaryDo getOneDiary(int seq);
	
	//글 수정
	void updateDiary(DiaryDo bdo);
	
	//글 삭제
	void deleteDiary(int seq);
	
	//글 검색
	ArrayList<DiaryDo> searchDiaryList(String searchCon, String searchKey);
}

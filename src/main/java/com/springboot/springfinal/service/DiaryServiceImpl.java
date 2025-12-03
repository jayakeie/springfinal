package com.springboot.springfinal.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.springfinal.model.DiaryDo;

@Service("DiaryService")
public class DiaryServiceImpl {
	@Autowired
	private DiaryMapper dMapper;
	
	public void insertDiary(DiaryDo ddo) {
		dMapper.insertDiary(ddo);
	}
	
}
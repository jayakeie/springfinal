package com.springboot.springfinal.service;

import java.util.List;
import com.springboot.springfinal.model.DiaryDo;
import com.springboot.springfinal.model.ImageDo;

public interface DiaryService {
    //일기 작성 (PK 반환)
    int insertDiary(DiaryDo ddo);
    
    //이미지 저장
    void insertDiaryImage(ImageDo imageDo);
    
    //일기 목록 조회
    List<DiaryDo> getDiaryList(String userId);
    
    //일기 상세 조회
    DiaryDo getOneDiary(int diaryId);
    
    //이미지 확인
    List<ImageDo> getDiaryImages(int diaryId);
    
    //일기 수정
    void updateDiary(DiaryDo ddo);
    
    //이미지 삭제
    void deleteDiaryImage(String storedName);
    
    //일기 삭제
    void deleteDiary(int diaryId);
    
    //검색
    List<DiaryDo> searchDiaryList(String userId, String searchCon, String searchKey);
}
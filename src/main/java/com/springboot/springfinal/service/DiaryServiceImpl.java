package com.springboot.springfinal.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.springboot.springfinal.model.DiaryDao;
import com.springboot.springfinal.model.DiaryDo;
import com.springboot.springfinal.model.ImageDo;

@Service("DiaryService")
public class DiaryServiceImpl implements DiaryService {

    @Autowired
    private DiaryDao diaryDao;

    @Override
    public int insertDiary(DiaryDo ddo) {
        return diaryDao.insertDiary(ddo);
    }

    @Override
    public void insertDiaryImage(ImageDo imageDo) {
        diaryDao.insertDiaryImage(imageDo);
    }

    @Override
    public List<DiaryDo> getDiaryList(String userId) {
        return diaryDao.getDiaryList(userId);
    }

    @Override
    public DiaryDo getOneDiary(int diaryId) {
        return diaryDao.getOneDiary(diaryId);
    }
    
    @Override
    public List<ImageDo> getDiaryImages(int diaryId) {
        return diaryDao.getDiaryImages(diaryId);
    }

    @Override
    public void updateDiary(DiaryDo ddo) {
        diaryDao.updateDiary(ddo);
    }
    
    @Override
    public void deleteDiaryImage(String storedName) {
        diaryDao.deleteDiaryImageByStoredName(storedName);
    }

    @Override
    public void deleteDiary(int diaryId) {
        diaryDao.deleteDiary(diaryId);
    }

    @Override
    public List<DiaryDo> searchDiaryList(String userId, String searchCon, String searchKey) {
        return diaryDao.searchDiaryList(userId, searchCon, searchKey);
    }
}
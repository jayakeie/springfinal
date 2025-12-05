package com.springboot.springfinal.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.springboot.springfinal.model.DiaryDao;
import com.springboot.springfinal.model.DiaryDo;
import com.springboot.springfinal.model.ImageDo;

@Controller
public class DiaryController {
    
    @Autowired
    private DiaryDao diaryDao;
    
    //업로드한 이미지 파일 저장 경로
    private static final String UPLOAD_DIR = System.getProperty("user.home") + "/diary_uploads/";

    //세션 체크 메소드 (로그인)
    private boolean isLogin(HttpSession session) {
        return session.getAttribute("userId") != null;
    }

    //목록 조회
    @RequestMapping(value = "/getDiaryList.do")
    public String getDiaryList(Model model, HttpSession session) {
        String userId = (String) session.getAttribute("userId");
        
        if (userId != null) {
            List<DiaryDo> dlist = diaryDao.getDiaryList(userId);
            model.addAttribute("dList", dlist);
        } else {
            model.addAttribute("dList", new ArrayList<DiaryDo>());
        }
        
        return "getDiaryListView";
    }

    //작성 페이지
    @RequestMapping(value = "/insertDiary.do", method = RequestMethod.GET)
    public String insertDiary(HttpSession session) {
        if (!isLogin(session)) {
            return "redirect:login.do";
        }
        return "insertDiaryView";
    }
    
    //작성 처리 (파일 저장)
    @RequestMapping(value = "/insertDiaryProc.do", method = RequestMethod.POST)
    public String insertDiaryProc(DiaryDo ddo, 
                                  @RequestParam("uploadFiles") List<MultipartFile> files,
                                  HttpSession session) {
        
        if (!isLogin(session)) {
            return "redirect:login.do";
        }
        
        String userId = (String) session.getAttribute("userId");
        ddo.setUserId(userId);
        
        //일기 저장 후 ID 반환
        int diaryId = diaryDao.insertDiary(ddo);
        
        //이미지 파일 저장
        saveFiles(files, diaryId);
        
        return "redirect:getDiaryList.do";
    }
    
    //상세 정보 (AJAX로 비동기통신)
    @RequestMapping(value = "/getDiaryDetail.do", method = RequestMethod.POST)
    @ResponseBody 
    public DiaryDo getDiaryDetail(@RequestParam("diaryId") int diaryId) {
        return diaryDao.getOneDiary(diaryId);
    }

    //수정 페이지
    @RequestMapping(value = "/modifyDiary.do")
    public String modifyDiary(@RequestParam("diaryId") int diaryId, Model model, HttpSession session) {
        if (!isLogin(session)) {
            return "redirect:login.do";
        }
        
        DiaryDo diary = diaryDao.getOneDiary(diaryId);
        List<ImageDo> imageList = diaryDao.getDiaryImages(diaryId);
        
        model.addAttribute("Diary", diary);
        model.addAttribute("imageList", imageList);
        
        return "modifyDiaryView";
    }

    //수정 처리 (파일 추가/삭제)
    @RequestMapping(value = "/modifyDiaryProc.do", method = RequestMethod.POST)
    public String modifyDiaryProc(DiaryDo ddo, 
                                  @RequestParam(value = "uploadFiles", required = false) List<MultipartFile> files,
                                  @RequestParam(value = "deleteImages", required = false) List<String> deleteImages,
                                  HttpSession session) {
        
        if (!isLogin(session)) {
            return "redirect:login.do";
        }
        
        diaryDao.updateDiary(ddo);
        
        //이미지 삭제 (DB + 실제 파일)
        if (deleteImages != null && !deleteImages.isEmpty()) {
            for (String storedName : deleteImages) {
                //DB 삭제
                diaryDao.deleteDiaryImageByStoredName(storedName); 
                
                //실제 파일 삭제
                File file = new File(UPLOAD_DIR + storedName);
                if (file.exists()) {
                    file.delete(); 
                }
            }
        }
        
        //추가된 이미지 저장
        saveFiles(files, ddo.getDiaryId());
        
        return "redirect:getDiaryList.do";
    }

    //삭제 처리 (로컬 파일 삭제)
    @RequestMapping(value = "/deleteDiary.do")
    public String deleteDiary(@RequestParam("diaryId") int diaryId, HttpSession session) {
        if (!isLogin(session)) {
            return "redirect:login.do";
        }
        
        //삭제하기 전 일기의 이미지 목록 조회
        List<ImageDo> imagesToDelete = diaryDao.getDiaryImages(diaryId);
        
        //실제 파일 삭제
        if (imagesToDelete != null) {
            for (ImageDo img : imagesToDelete) {
                File file = new File(UPLOAD_DIR + img.getStoredName());
                
                if (file.exists()) {
                    if (file.delete()) {
                        System.out.println("파일 삭제 성공: " + img.getStoredName());
                    }
                }
            }
        }
        
        //일기 삭제
        diaryDao.deleteDiary(diaryId);
        
        return "redirect:getDiaryList.do";
    }

    //검색
    @RequestMapping(value = "/searchDiaryList.do")
    public String searchDiaryList(@RequestParam(value = "searchCon") String searchCon,
                                  @RequestParam(value = "searchKey") String searchKey,
                                  Model model, 
                                  HttpSession session) {
        
        if (!isLogin(session)) {
            return "redirect:login.do";
        }
        
        String userId = (String) session.getAttribute("userId");
        List<DiaryDo> dList = diaryDao.searchDiaryList(userId, searchCon, searchKey);
        
        model.addAttribute("dList", dList);
        model.addAttribute("searchCon", searchCon);
        model.addAttribute("searchKey", searchKey);
        
        return "getDiaryListView";
    }

    //파일 저장
    private void saveFiles(List<MultipartFile> files, int diaryId) {
        if (files != null && !files.isEmpty()) {
            
            File uploadDir = new File(UPLOAD_DIR);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            for (MultipartFile file : files) {
                if (file.isEmpty()) continue;
                
                try {
                    String originalName = file.getOriginalFilename();
                    String storedName = UUID.randomUUID().toString() + "_" + originalName;
                    
                    //파일 이동
                    file.transferTo(new File(UPLOAD_DIR + storedName));
                    
                    //DB 저장
                    ImageDo imageDo = new ImageDo(diaryId, originalName, storedName);
                    diaryDao.insertDiaryImage(imageDo);
                    
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
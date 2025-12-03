package com.springboot.springfinal.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.springboot.springfinal.model.DiaryDao;
import com.springboot.springfinal.model.DiaryDaoSpring;
import com.springboot.springfinal.model.DiaryDo;
import com.springboot.springfinal.service.DiaryServiceImpl;

@Controller
public class DiaryController {
	@Autowired
	DiaryServiceImpl dService; //mybatis
	
	@Autowired
	private DiaryDaoSpring ddaoSpring; //spring jdbc
	
	@RequestMapping(value="/insertDiary.do", method=RequestMethod.GET)
	public String insertDiary() {
		System.out.println("Diary 작성");
		
		return "insertDiaryView";
	}
	
	@RequestMapping(value="/insertDiaryProc.do")
	public String insertDiaryProc(DiaryDo ddo, DiaryDao ddao) {
		System.out.println("insertDiaryProc 실행");
		System.out.println("title: "+ddo.getTitle());
		System.out.println("Id: "+ddo.getUserId());
		System.out.println("content: "+ddo.getContent());
		
		//디비에 입력된 데이터 저장
		dService.insertDiary(ddo);
		
		return "redirect:getDiaryList.do";
	}
	
	@RequestMapping(value="/getDiaryList.do")
	public String getDiaryList(DiaryDo ddo, DiaryDao ddao, Model model) {
		System.out.println("Diary 목록 가져오기");
		
		ArrayList<DiaryDo> dlist = ddaoSpring.getDiaryList();
		model.addAttribute("dList", dlist);
		
		return "getDiaryListView";
	}
	
	@RequestMapping(value="/modifyDiary.do")
	public String modifyDiary(DiaryDo ddo, DiaryDao ddao, Model model) {
		System.out.println("Diary 수정");
		System.out.println("seq: "+ddo.getSeq());
		
//		DiaryDo Diary = ddao.getOneDiary(ddo.getSeq());
		DiaryDo Diary = ddaoSpring.getOneDiary(ddo.getSeq());
		
		//mav.addObject("Diary", Diary);
		//mav.setViewName("modifyDiaryView");
		model.addAttribute("Diary", Diary);
		
		return "modifyDiaryView";
	}
	
	@RequestMapping(value="/modifyDiaryProc.do")
	//public ModelAndView modifyDiaryProc(DiaryDo ddo, DiaryDao ddao, ModelAndView mav) {
	public String modifyDiaryProc(DiaryDo ddo, DiaryDao ddao, Model model) {
		System.out.println("(Spring JDBC)modifyDiaryProc() 처리 시작!");
		System.out.println("seq: "+ddo.getSeq()
		+ ", title: "+ddo.getTitle()
		+ ", Id: "+ddo.getUserId()
		+", content: "+ddo.getContent());
		
//		ddao.updateDiary(ddo);
		ddaoSpring.updateDiary(ddo);
		//수정된 데이터를 반영하여 전체 데이터를 읽어와 보여 주기 위해, getDiaryList.do 요청함
		//mav.setViewName("redirect:getDiaryList.do");
		
		return "redirect:getDiaryList.do";
	}
	
	@RequestMapping(value="/deleteDiary.do")
	public String deleteDiary(DiaryDo ddo, DiaryDao ddao) {
		System.out.println("(Spring JDBC) deleteDiary() 처리 시작!");
//		ddao.deleteDiary(ddo.getSeq());
		ddaoSpring.deleteDiary(ddo.getSeq());
		
		return "redirect:getDiaryList.do";
	}
	
	@RequestMapping(value="/searchDiaryList.do")
	public String searchDiaryList(@RequestParam(value="searchCon") String searchCon,
								@RequestParam(value="searchKey") String searchKey,
								DiaryDao ddao, Model model) {
		System.out.println("(Spring JDBC) searchDiaryList() 처리 시작!");
		System.out.println("searchCon: "+searchCon + ", searchKey: "+searchKey);
		
		//Dao 이용하여 DB에서 해당 데이터 검색해 결과를 가져오기
		ArrayList<DiaryDo> dList = ddaoSpring.searchDiaryList(searchCon, searchKey);
		
		model.addAttribute("dList", dList);
		
		return "getDiaryListView";
	}
}
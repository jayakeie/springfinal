package com.springboot.springfinal.controller;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.PrintWriter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.springboot.springfinal.model.UserDao;
import com.springboot.springfinal.model.UserDo;

@Controller
public class UserController {

    @Autowired
    private UserDao userDao;

    //로그인 페이지
    @RequestMapping(value = "/login.do")
    public String login() {
        return "loginView";
    }

    //로그인 처리
    @RequestMapping(value = "/loginProc.do", method = RequestMethod.POST)
    public String loginProc(UserDo user, HttpSession session, HttpServletResponse response) throws Exception {
        
        UserDo loginUser = userDao.login(user.getUserId(), user.getPassword());

        if (loginUser != null) {
            //로그인 성공 시
            session.setAttribute("userId", loginUser.getUserId());
            session.setAttribute("userNick", loginUser.getNickname());
            
            return "redirect:getDiaryList.do";
        } else {
            //로그인 실패 시
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            
            out.println("<script>alert('아이디 또는 비밀번호가 일치하지 않습니다.'); history.back();</script>");
            out.flush();
            
            return null;
        }
    }

    //로그아웃 처리
    @RequestMapping(value = "/logout.do")
    public String logout(HttpSession session) {
        session.invalidate(); 
        return "redirect:getDiaryList.do";
    }

    //회원가입 페이지
    @RequestMapping(value = "/join.do")
    public String join() {
        return "joinView";
    }

    //회원가입 처리
    @RequestMapping(value = "/joinProc.do", method = RequestMethod.POST)
    public String joinProc(UserDo user, HttpServletResponse response) throws Exception {
        
        //아이디 중복 체크 (users 테이블 기본키)
        if (userDao.checkId(user.getUserId())) {
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            
            out.println("<script>alert('이미 존재하는 아이디입니다.'); history.back();</script>");
            out.flush();
            
            return null;
        }
        
        userDao.insertUser(user);
        
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<script>alert('회원가입이 완료되었습니다! 로그인해주세요.'); location.href='login.do';</script>");
        out.flush();
        
        return null;
    }

    //마이페이지 이동
    @RequestMapping(value = "/myPage.do")
    public String myPage(HttpSession session, Model model) {
        
        String userId = (String) session.getAttribute("userId");
        
        //비로그인 접근 제한
        if (userId == null) {
            return "redirect:login.do";
        }

        UserDo user = userDao.getUser(userId);
        model.addAttribute("user", user);
        
        return "myPageView";
    }

    //회원 정보 수정 처리 (비밀번호 검증 포함)
    @RequestMapping(value="/updateUserProc.do", method=RequestMethod.POST)
    public String updateUserProc(UserDo user, HttpSession session, HttpServletResponse response) throws Exception {
        String userId = (String) session.getAttribute("userId");
        if (userId == null) return "redirect:login.do";
        
        //DB에서 현 사용자의 정보(비밀번호 포함)를 가져옴
        UserDo dbUser = userDao.getUser(userId);
        
        //비밀번호 검증
        if (!dbUser.getPassword().equals(user.getPassword())) {
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('비밀번호가 일치하지 않습니다. 다시 확인해주세요.'); history.back();</script>");
            out.flush();
            return null; //비밀번호 틀리면 업데이트 안 함
        }
        
        //비밀번호 일치하면 업데이트
        user.setUserId(userId);
        userDao.updateUser(user);
        
        //세션의 닉네임도 갱신
        session.setAttribute("userNick", user.getNickname());

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<script>alert('정보가 성공적으로 수정되었습니다.'); location.href='myPage.do';</script>");
        out.flush();
        return null;
    }
}
package com.shoppingmall.controller;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.shoppingmall.VO.AuthInfo;
import com.shoppingmall.VO.LoginCommand;
import com.shoppingmall.exception.IdPasswordNotMatchingException;
import com.shoppingmall.service.UserService;


//작성자 : 박성호

// 로그인 컨트롤러




@Controller
public class LoginController {
	
	// 아이디기억 시 활성화되는 부분
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public ModelAndView loginForm(LoginCommand loginCommand, 
									@CookieValue(value="REMEMBER", required=false) 
									Cookie rememberCookie,
									Model model
								  ) throws Exception {
		if(rememberCookie!=null) {
			loginCommand.setId(rememberCookie.getValue());
			loginCommand.setRememberId(true);
		}
		
		ModelAndView mv = new ModelAndView("home/home");
		
		String center = "member/login.jsp";
		mv.addObject("center", center);
		
		return mv;
	}
	
	@Resource(name="userService")
	private UserService userSer;
	
	// 로그인 부분
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public ModelAndView loginSuccess(@Valid LoginCommand loginCommand, BindingResult bindingResult, HttpSession session,
									HttpServletResponse response) throws Exception{
		
		//에러났을경우
		if(bindingResult.hasErrors()) {
			
			ModelAndView mv = new ModelAndView("home/home");
			
			String center = "member/login.jsp";
			mv.addObject("center", center);
			
			
			return mv;
		}
		
		
		try {
			AuthInfo authInfo = userSer.loginAuth(loginCommand);
			session.setAttribute("authInfo", authInfo);
			
			Cookie rememberCookie = new Cookie("REMEMBER", loginCommand.getId());
			rememberCookie.setPath("/");
			if(loginCommand.isRememberId()) {
				rememberCookie.setMaxAge(60*60*24*7);
			}
			else {
				rememberCookie.setMaxAge(0);
			}
			response.addCookie(rememberCookie);
		}
		catch (IdPasswordNotMatchingException e) {
			bindingResult.rejectValue("pw", "notMatch", "아이디와 비밀번호가 맞지않습니다.");
			ModelAndView mv = new ModelAndView("home/home");
			
			String center = "member/login.jsp";
			mv.addObject("center", center);
			
			return mv;
		}
		
		
		
		//로그인 성공시?
		ModelAndView mv = new ModelAndView("home/home");
		return mv;
	}
	
	// 로그아웃 부분
	@RequestMapping("/logout")
	public ModelAndView logout(HttpSession session) {
		session.invalidate();
		ModelAndView mv = new ModelAndView("home/home");
		return mv;
	}
}

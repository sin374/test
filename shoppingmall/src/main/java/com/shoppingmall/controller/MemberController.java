package com.shoppingmall.controller;

import java.security.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shoppingmall.VO.AuthInfo;
import com.shoppingmall.VO.MemberVO;
import com.shoppingmall.service.MemberService;

/*
 * 작성자: 이신희
 * 
 * 멤버에 대한 컨트롤러 클래스.
 * 
 * 
 */




@Controller
public class MemberController {
	
	//서비스 역할을 하는 객체 얻기
	@Autowired
	private MemberService service;
	
	@Autowired
	private JavaMailSender mailSender;
	
	//회원가입 폼을 요청
	@GetMapping("/list")
	public String list(Model model) {
		
		String center = "member/Join.jsp";
		model.addAttribute("center",center);
		
		return "home/home";
	}
	
	//아이디 중복 확인
	@RequestMapping(value="/idck", method=RequestMethod.POST, produces = "application/json; charset=utf-8")
	public @ResponseBody int idCK(MemberVO vo) throws Exception{
		
		int count = service.idck(vo.getId());
		
		 return count;
	}

	//회원가입폼에서 요청, POST로 들어옴.
	//DB insert실행후, 다시 회원가입폼으로 넘김
	@PostMapping("/regist")
	public String register(MemberVO vo, HttpServletRequest request) throws Exception{
		service.insert(vo);
		
		//회원가입 인증 메일 보내기
		service.mailSendWithUserKey(vo.getEmail(),vo.getId(), request);
		return "home/home";
	}
	
	@RequestMapping(value="/OldPWck", method=RequestMethod.POST, produces = "application/json; charset=utf-8")
	public @ResponseBody int OldPWck(MemberVO vo) throws Exception{
		int count = service.Oldpwck(vo);
		return count;
		
	}
	
	
	//회원가입 폼에서 입력한 이메일에서 링크를 클릭시 들어오는 요청
	@GetMapping("/email_alter")
	public String registerConfirm(@RequestParam("id") String id) throws Exception {
		//이메일 인증이 완료되면 emailState 상태가 1로 변경
		service.emailStateUpdate(id);
		return "home/home";
	}
	
	//회원정보 수정 페이지 요청
	@GetMapping("/modify")
	public String mypage(Model model, MemberVO vo, HttpSession session) throws Exception {
		String center ="member/modify.jsp";
		model.addAttribute("center", center);
		
		AuthInfo authInfo = (AuthInfo) session.getAttribute("authInfo");
		 vo = service.read(authInfo.getId());
		
		 model.addAttribute("member", vo);

		return "home/home";
	}

	//회원정보 수정시 이메일 인증을 위해 이메일 보내기
	@RequestMapping(value="/modifyEmail", method=RequestMethod.POST, produces = "application/json; charset=utf-8")
	public @ResponseBody int modifyEamil(MemberVO vo, HttpServletRequest request)throws Exception{
		int count = service.CkEmail(vo); // 회원정보에서 이메일 수정시 해당 id와 입력한 email에 해당하는 정보가 db에 있는지 검색
		if(count==0) {//db에 해당이메일이 없을 경우
			service.mailSendForModify(vo.getEmail(), vo.getId(), request); //회원정보 수정을위해 이메일 보내기
			service.emailUpdate(vo);//이메일 update
		}
		return count;
	}
	
	//수정한 이메일로 온 링크를 클릭했을 시 emailStateUpdate상태 변경
	@GetMapping("/email_modify")
	public String emailModifyConfirm(@RequestParam("id") String id) throws Exception{
		service.emailStateUpdate(id);//수정한 이메일로 온 링크를 클릭했을 시 emailStateUpdate상태 변경
		return "member/emailUpdate";
	}
	
	//회원정보 수정 전emailState값 확인
	@RequestMapping(value="/emailState_Ck", method=RequestMethod.POST, produces = "application/json; charset=utf-8")
	public @ResponseBody int emailState_Ck(MemberVO vo) throws Exception{
		System.out.println("emailState_ck 들어옴");
		int count = service.emailState_Ck(vo.getId());
		return count;
	}
	
	//회원정보 수정 
	@PostMapping("/memUpdate")
	public String memUpdate(MemberVO vo, HttpServletRequest request) throws Exception{
		service.modify(vo);
		return "home/home";
	}
		
		
	//회원 탈퇴 페이지 요청
	@GetMapping("/delete")
	public String delPage(Model model, MemberVO vo, HttpSession session) throws Exception {
		String center ="member/delete.jsp";
		model.addAttribute("center", center);
		
		AuthInfo authInfo = (AuthInfo) session.getAttribute("authInfo");
		 vo = service.read(authInfo.getId());
		
		 model.addAttribute("member", vo);

		return "home/home";
	}
	
	
	//회원탈퇴
	@RequestMapping(value="/pwCK", method=RequestMethod.POST, produces = "application/json; charset=utf-8")
	public @ResponseBody int delCK(MemberVO vo, HttpSession session) throws Exception{
		
		
		
		int count = service.pwCK(vo);//아이디와 비밀번호가 일치하는지 확인
		
		if(count==1) {
			service.remove(vo.getId()); //회원정보 제거
			
			session.invalidate();
		}
		return(count);
		
	}
		
		
		
	
}

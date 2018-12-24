/*
 * 작성자:이신희 
 * 
 * 멤버 서비스인터페이스를 구현한 클래스
 * 
 * 
 * 
 */



package com.shoppingmall.service;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.shoppingmall.DAO.MemberDAO;
import com.shoppingmall.VO.AuthInfo;
import com.shoppingmall.VO.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	
	
	
	@Autowired
	private MemberDAO dao;
	
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	@Autowired
	private JavaMailSender mailSender;
	
	
	//아이디 중복확인
	@Override
	public int idck(String id) throws Exception { return dao.idcheck(id);}
	
	 //회원가입 회원정보 insert
	@Override
	public void insert(MemberVO vo) throws Exception {dao.insertMember(vo);}
	
	// 회원가입 발송 이메일
	@Override
	public void mailSendWithUserKey(String email, String id , HttpServletRequest request) {
		MimeMessage mail = mailSender.createMimeMessage();
		String htmlStr = "<h2>회원가입 인증</h2><br><br>" 
				+ "<h3>" + id + "님</h3>" + "<p>인증하기 버튼을 누르시면 회원가입이 완료됩니다. : " 
				+ "<a href='http://localhost:8090" + request.getContextPath() + "/email_alter?id="+id+"'>회원가입 완료</a></p>";
		try {
			mail.setSubject("[회원가입 인증]", "utf-8");
			mail.setText(htmlStr, "utf-8", "html");
			mail.addRecipient(RecipientType.TO, new InternetAddress(email));
			mailSender.send(mail);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
	
	//이메일 인증이 완료되면 emailState 상태가 1로 변경
	@Override
	public void emailStateUpdate(String id) throws Exception {dao.emailStateUpdate(id);}
	
		
	//로그인 되어있는 회원의 회원정보 가져오기
	@Override
	public MemberVO read(String id) throws Exception {return dao.readMember(id);}
	
	// 회원정보에서 이메일 수정시 해당 id와 입력한 email에 해당하는 정보가 db에 있는지 검색
	@Override
	public int CkEmail(MemberVO vo) throws Exception {return dao.CheckEmail(vo);}	
		
	
	//회원정보 수정을위해 이메일 보내기
	@Override
	public void mailSendForModify(String email, String id , HttpServletRequest request) {
		MimeMessage mail = mailSender.createMimeMessage();
		String htmlStr = "<h2>메일 인증</h2><br><br>" 
				+ "<h3>" + id + "님</h3>" + "<p>인증하기 버튼을 누르시면 메일인증 이 완료됩니다. : " 
				+ "<a href='http://localhost:8090" + request.getContextPath() + "/email_modify?id="+id+"'>이메일 인증 완료</a></p>";
				
		try {
			mail.setSubject("[이메일 인증]", "utf-8");
			mail.setText(htmlStr, "utf-8", "html");
			mail.addRecipient(RecipientType.TO, new InternetAddress(email));
			mailSender.send(mail);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
	//이메일 update
	@Override
	public void emailUpdate(MemberVO vo) throws Exception{dao.emailUpdate(vo);}
	
	//회원정보 수정 전emailState값 확인
	@Override
	public int emailState_Ck(String id) throws Exception {
		return dao.emailStateCheck(id);
	}
//회원정보수정	
	@Override
	public void modify(MemberVO vo) throws Exception {dao.updateMember(vo);}
		
	//아이디와 비밀번호가 일치하는지 확인
	@Override
	public int pwCK(MemberVO vo) {return dao.pwCK(vo);}
	
	//회원정보 제거
	@Override
	public void remove(String id) throws Exception {dao.deleteMember(id);}

	@Override
	public int Oldpwck(MemberVO vo) throws Exception {
		return dao.OldpwCheck(vo);
	}

	
	

	

	

	

	
}

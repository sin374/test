package com.shoppingmall.DAO;

import org.springframework.web.bind.annotation.ResponseBody;

import com.shoppingmall.VO.AuthInfo;
import com.shoppingmall.VO.MemberVO;


/*
 * 작성자: 이신희
 * 
 * 
 * 멤버 DAO인터페이스 클래스
 * 
 */

public interface MemberDAO {
	public int OldpwCheck(MemberVO vo) throws Exception;//회원정보 수정시 기존 비밀번호 일치 확인
	public int idcheck(String id) throws Exception;//아이디 중복확인
	public void insertMember(MemberVO vo) throws Exception;//회원가입 회원정보 insert	
	public void emailStateUpdate(String id) throws Exception;//이메일 인증이 완료되면 emailState 상태가 1로 변경
	public MemberVO readMember(String id) throws Exception;//로그인 되어있는 회원의 회원정보 가져오기
	public int CheckEmail(MemberVO vo) throws Exception;// 회원정보에서 이메일 수정시 해당 id와 입력한 email에 해당하는 정보가 db에 있는지 검색
	public void emailUpdate(MemberVO vo) throws Exception;//이메일 update
	public int emailStateCheck(String id) throws Exception; //회원정보 수정 전emailState값 확인
	public void updateMember(MemberVO vo) throws Exception;//회원정보수정
	public int pwCK(MemberVO vo);//아이디와 비밀번호가 일치하는지 확인
	public void deleteMember(String id) throws Exception;//회원정보 제거
	
	
}

/*
 * 작성자:이신희
 * 
 * member서비스 인터페이스
 * 
 */


package com.shoppingmall.service;

import javax.servlet.http.HttpServletRequest;

import com.shoppingmall.VO.AuthInfo;
import com.shoppingmall.VO.MemberVO;

public interface MemberService {
	public int idck(String id) throws Exception; //아이디 중복 확인
	public void insert(MemberVO vo) throws Exception; //회원가입 회원정보 insert
	public void mailSendWithUserKey(String email, String id , HttpServletRequest request) throws Exception; //회원가입시 입력한 이메일 인증을 위한 이메일 보내기
	public void emailStateUpdate(String id) throws Exception; // 이메일 인증이 완료되면 emailState 상태가 1로 변경
	public MemberVO read(String id) throws Exception;//로그인 되어있는 회원의 회원정보 가져오기
	public int CkEmail(MemberVO vo) throws Exception;// 회원정보에서 이메일 수정시 해당 id와 입력한 email에 해당하는 정보가 db에 있는지 검색
	public void mailSendForModify(String email, String id , HttpServletRequest request)throws Exception;//회원정보 수정을위해 이메일 보내기
	public void emailUpdate(MemberVO vo) throws Exception;//이메일 update
	public int emailState_Ck(String id) throws Exception; //회원정보 수정 전emailState값 확인
	public void modify(MemberVO vo) throws Exception;//회원정보 수정
	public int pwCK(MemberVO vo)throws Exception;//아이디와 비밀번호가 일치하는지 확인
	public void remove(String id) throws Exception;//회원정보 제거
	public int Oldpwck(MemberVO vo) throws Exception; //회원정보 수정시 기존 비밀번호 일치 확인
	
}

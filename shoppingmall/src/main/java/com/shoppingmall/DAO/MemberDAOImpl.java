


package com.shoppingmall.DAO;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.shoppingmall.VO.AuthInfo;
import com.shoppingmall.VO.MemberVO;

/*
 * 작성자:이신희
 * 
 * 멤버DAO인터페이스를 구현한 클래스
 * 
 */


@Repository
public class MemberDAOImpl implements MemberDAO{
	

	@Inject
	private SqlSession session;
	
	private static String namespace="com.shoppingmall.mapper.MemberMapper";
	
	@Override
	public int idcheck(String id) throws Exception {
		System.out.println(id);
		System.out.println((int)session.selectOne(namespace+".idcheck", id));
		System.out.println("dao들어옴");
		return session.selectOne(namespace+".idcheck", id);
	}
	@Override
	public int pwCK(MemberVO vo) {
		System.out.println(vo.getId());
		System.out.println(vo.getPw());
		return session.selectOne(namespace+".pwCK", vo);
	}
	
	@Override
	public int CheckEmail(MemberVO vo) throws Exception {
		return session.selectOne(namespace+".CheckEmail",vo);
				
	}
	
	@Override
	public void insertMember(MemberVO vo) throws Exception {
		System.out.println("insertMember들어옴");
		session.insert(namespace+".insertMember",vo);
		}
	
	//이메일 인증 링크 클릭 시 emailState 값 0에서 1로 변경
	@Override
	public void emailStateUpdate(String id) throws Exception {
		System.out.println("emailStateUpdate 들어옴");
		session.update(namespace+".emailStateUpdate", id);
		
	}
	@Override
	public void emailUpdate(MemberVO vo) throws Exception {
		session.update(namespace+".emailUpdate",vo);
		
	}
	
	@Override
	public MemberVO readMember(String id) throws Exception {
		return session.selectOne(namespace+".readMember", id);
	}
	@Override
	public void updateMember(MemberVO vo) throws Exception {
		System.out.println("updateMember들어옴");
		session.update(namespace+".updateMember",vo);
		
	}
	@Override
	public void deleteMember(String id) throws Exception {
		System.out.println("deleteMember들어옴");
		session.delete(namespace+".deleteMember",id);
		
	}
	@Override
	public int emailStateCheck(String id) throws Exception {
		return session.selectOne(namespace+".emailStateCheck", id);
	}
	@Override
	public int OldpwCheck(MemberVO vo) throws Exception {
		return session.selectOne(namespace+".OldpwCheck",vo);
	}



	

	

	
	
}

package com.shoppingmall.DAO;

import org.springframework.stereotype.Repository;

import com.shoppingmall.VO.UserVO;


//작성자: 박성호
//하하?

@Repository("userDAO")
public class UserDAO extends AbstractDAO {
	public UserVO selectById(String id) {
		return (UserVO)selectOne("com.selectById", id);
	}
}

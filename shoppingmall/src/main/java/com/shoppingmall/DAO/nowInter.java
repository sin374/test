

package com.shoppingmall.DAO;

import java.sql.Timestamp;

import com.shoppingmall.VO.nowVO;


/*
 * 작성자:최황혁
 * DB테스트(mybatis)를 위해 만든 인터페이스
 * 
 * 
 */


public interface nowInter {
	
	//현재 시간을 보여줄 now함수를 구현해야함~~!
	public nowVO now();
}

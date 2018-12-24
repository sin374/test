/*
 * 작성자:최황혁
 * 
 * DB테스트를 위한 VO클래스
 * 
 */

package com.shoppingmall.VO;

import java.sql.Timestamp;

public class nowVO {

	private Timestamp now;

	//기본 생성자
	public nowVO() {
		// TODO Auto-generated constructor stub
	}
	
	//생성자
	public nowVO(Timestamp now) {
		this.now = now;
	}
	
	//Setter, getter
	public Timestamp getNow() {
		return now;
	}

	public void setNow(Timestamp now) {
		this.now = now;
	}
	
	
	
}

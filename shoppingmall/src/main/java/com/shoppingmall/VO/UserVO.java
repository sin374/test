package com.shoppingmall.VO;

//작성자: 박성호
// ID값들 저장해놓고 거시기 하는 DTO


public class UserVO {
	private String id;
	private String pw;
	private String name;
	
	public boolean matchPassword(String pw) {
		return this.pw.equals(pw);
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}

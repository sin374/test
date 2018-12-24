package com.shoppingmall.VO;


//작성자: 박성호씨
// 쿠키인가 그거할때 쓰는 DTO

public class AuthInfo {
	private String id;
	private String name;

	
	public AuthInfo(String id, String name) {
		this.id = id;
		this.name = name;

	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}

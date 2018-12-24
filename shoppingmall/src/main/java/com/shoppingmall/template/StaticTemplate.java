/*
 * 작성자: 최황혁
 * 
 * DB접속 테스트를 위해 만든 클래스
 * 
 */



package com.shoppingmall.template;

import org.springframework.jdbc.core.JdbcTemplate;


//BController.java에서 jdbcTemplate객체를 불러와 저장 하였다. 
//그럼 우리는 DB연동작업(jdbcTemplate객체 사용)을 BDAO클래스에서 해야하기 때문에 
//아래와 같이 새로운 클래스를 하나 추가해서 jdbcTemplate객체를 공유시켜 주는 부분을 작성하자
public class StaticTemplate {

	public static JdbcTemplate template;
}

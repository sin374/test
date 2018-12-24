
/*
 * 작성자: 최황혁
 * 
 * DB연결이 제대로 되는지 테스트 하기 위한 컨트롤러이다.
 * 
 */

package com.shoppingmall.controller;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shoppingmall.DAO.nowInter;
import com.shoppingmall.template.StaticTemplate;



@Controller
public class dbTestController {

	//1번테스트(dataSource)를 위한 변수선언
	@Autowired
	private DataSource dataSource;
	
	//2번테스트(JDBCTemplate)를 위한 변수선언
	JdbcTemplate jdbcTemplate;
	
	//@Autowired어노테이션 기호를 통하여 <bean>태그에 대한 JdbcTemplate객체를 받아와서 저장.
	//쌤이 해둔 게시판에서 
	//BDAO랑, Controller랑 같은 template를 공유하려고 이렇게 만드는듯??!
	//StaticTemplate를 따로 클래스로 만들고,
	//BDAO에서 생성자로 넣어 씀
	@Autowired
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
		
		StaticTemplate.template = this.jdbcTemplate;
	}
	
	//3번 테스트를 위한 선언
	//servlet-context.xml에 작성된 <bean>태그에 관한 SqlSessionTemplate객체를 받을때..
	//SqlSession조상 인터페이스 타입으로 받기 위해 변수 선언.
	@Autowired
	private SqlSession sqlSessionTemplate;
	
	//1. dataSource를 제대로 가져오는지 테스트 
	@RequestMapping("/dbTest1.do")
	public String dbTest1(Model model) {
		Connection con=null;
    	Statement st = null;
    	
        try {
    		con=dataSource.getConnection();
            st = con.createStatement();
            ResultSet rs = st.executeQuery("select now() as now;");
            
            while(rs.next()) {
                model.addAttribute("serverTime", rs.getString("now"));
            }
        } catch (Exception e) {
            e.printStackTrace();    
        } finally {
            try {
                if(st != null) st.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if(con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }                        
        }
        return "dbtest";
    }
	
	
	//2. JDBCTemplate를 제대로 사용할 수 있는지 확인.
	@RequestMapping("/dbTest2.do")
	public String dbTest2(Model model) {
		
		String sql = "select now() as now";
		
        model.addAttribute("serverTime", this.jdbcTemplate.queryForObject(sql, new RowMapper<Timestamp>() {

				@Override
				public Timestamp mapRow(ResultSet rs, int rowNum) throws SQLException {
					
					Timestamp t1 = rs.getTimestamp("now");
					
					return t1;
				}
			})
        );
        return "dbtest";
    }
	
	
	//3. Mybatis를 제대로 사용되는지 테스트.(구현중...^^;;)
	@RequestMapping("/dbTest3.do")
	public String dbTest3(Model model) {
		
		
		//bdao.xml파일의 namespace태그에 해당하는 매퍼 BDAO인터페이스를 구현한 객체리턴
		nowInter now1 = sqlSessionTemplate.getMapper(nowInter.class);
		
		model.addAttribute("serverTime", now1.now().getNow());
		
		return "dbtest";
		
	}
	
	
}

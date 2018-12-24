
/*
 * 작성자: 이신희
 * 
 * 멤버 DTO클래스
 * 
 * 
 */

package com.shoppingmall.VO;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class MemberVO {
		private String id;
		private String name;
		private String pw;
		private String email;
		private String phone;
		private String sex;
		private String month;
		private String year;
		private String day;
		private String postcode;
		private String addr1;
		private String addr2;
		private Date birthdate;
		private String birth;
		private String grade;
		private Date regdate;
		private int point;
		private int emailState;
		
		
		public String getBirth() {
			String date = year+"-"+month+"-"+day;
			return date;
		}

		public void setBirth(String year, String month, String day) {
			this.year=year;
			this.month=month;
			this.day=day;
		}

		public int getEmailState() {
			return emailState;
		}

		public void setEmailState(int emailState) {
			this.emailState = emailState;
		}
		
		public String getId() {
			return id;
		}
		public Date getBirthdate() {
			return birthdate;
		}

		public void setBirthdate(Date birthdate) {
			this.birthdate = birthdate;
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
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
		public String getPhone() {
			return phone;
		}
		public void setPhone(String phone) {
			this.phone = phone;
		}
		public String getSex() {
			return sex;
		}
		public void setSex(String sex) {
			this.sex = sex;
		}
		public String getMonth() {
			return month;
		}
		public void setMonth(String month) {
			this.month = month;
		}
		public String getYear() {
			return year;
		}
		public void setYear(String year) {
			this.year = year;
		}
		public String getDay() {
			return day;
		}
		public void setDay(String day) {
			this.day = day;
		}
		public String getPostcode() {
			return postcode;
		}
		public void setPostcode(String postcode) {
			this.postcode = postcode;
		}
		public String getAddr1() {
			return addr1;
		}
		public void setAddr1(String addr1) {
			this.addr1 = addr1;
		}
		public String getAddr2() {
			return addr2;
		}
		public void setAddr2(String addr2) {
			this.addr2 = addr2;
		}
		public String getGrade() {
			return grade;
		}
		public void setGrade(String grade) {
			this.grade = grade;
		}
		public Date getRegdate() {
			return regdate;
		}
		public void setRegdate(Date regdate) {
			this.regdate = regdate;
		}
		public int getPoint() {
			return point;
		}
		public void setPoint(int point) {
			this.point = point;
		}
		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

}

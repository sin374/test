<!-- 
	원하는 페이지 바로 띄우려고 만든 페이지.
 -->


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		//response.sendRedirect("."); //홈
		
		response.sendRedirect("list"); //홈
		// response.sendRedirect("dbTest1.do"); //dataSource연결 테스트
		// response.sendRedirect("dbTest2.do"); //JDBCTemplate연결 테스트
		// response.sendRedirect("dbTest3.do"); //Mybatis연결 테스트 
	%>
</body>
</html> 












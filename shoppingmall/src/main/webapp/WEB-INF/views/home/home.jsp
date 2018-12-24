<!-- 
	작성자: 최황혁
	
	설명: 해당페이지는 사이트 접속시 처음 뜨는 화면으로 top, bottom을 inlcude하고 
			가운데 보여질 center를 변경하여 컨텐츠들이 보여지게 한다.  
 -->


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%--jstl 라이브러리 사용을 위한 선언 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
    


<!DOCTYPE html>
<html lang="en">
<head>
	<title>♥알파벳 쇼핑몰에 오신것을 환영합니다♥</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!--===============================================================================================-->
	<link rel="icon" type="image/png" href="resources/images/icons/favicon.png"/>
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/vendor/bootstrap/css/bootstrap.min.css">
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/fonts/themify/themify-icons.css">
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/fonts/elegant-font/html-css/style.css">
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/vendor/animate/animate.css">
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/vendor/css-hamburgers/hamburgers.min.css">
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/vendor/animsition/css/animsition.min.css">
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/vendor/select2/select2.min.css">
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/vendor/daterangepicker/daterangepicker.css">
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/vendor/slick/slick.css">
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/vendor/lightbox2/css/lightbox.min.css">
	<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/css/util.css">
	<link rel="stylesheet" type="text/css" href="resources/css/main.css">
	<!--===============================================================================================-->
	<!-- CSS링크 영역 끝~!! -->

	<!-- top, footer태호행님이 만들어준거에서 떼온거. -->
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<style type="text/css">
		#help,#ba{
		text-decoration: none;
		}
	</style>
	<!-- top, footer태호행님이 만들어준거에서 떼온거. -->


</head>


<body class="animsition">

	<!-- 센터 공간은 사용자로 부터 계속해서 정보가 바뀌는 부분 이기에 해당 Center.jsp의 정보를 읽어들여야 한다. --> 
 	<c:set var="center" value="${center}"/>

	 <!-- 처음 CarMain.jsp페이지를 실행하면 당연히..  param.값을 받아올수 없기에  조건 주기-->
	 <c:if test="${center == null}"> <!-- 넘겨받은 center값이 없으면.. 이동할  Center.jsp주소를 center변수에 저장 -->
	 	<c:set var="center" value="center/main.jsp"/>
	 </c:if>

 	<!-- 헤더영역(고정) -->
 	<jsp:include page="../include/top.jsp"/>
 		
 	<!-- 센터(컨텐츠가 바뀜!!) -->
 	<jsp:include page="../${center}"/>
 			
 	<!-- 푸터영역 (고정)-->
 	<jsp:include page="../include/bottom.jsp"/>
 			
 
 
 
	<!-- 자바 스크립트 영역 시작~! -->
	<!--===============================================================================================-->
	<script type="text/javascript" src="resources/vendor/jquery/jquery-3.2.1.min.js"></script>
	<!--===============================================================================================-->
	<script type="text/javascript" src="resources/vendor/animsition/js/animsition.min.js"></script>
	<!--===============================================================================================-->
	<script type="text/javascript" src="resources/vendor/bootstrap/js/popper.js"></script>
	<script type="text/javascript" src="resources/vendor/bootstrap/js/bootstrap.min.js"></script>
	<!--===============================================================================================-->
	<script type="text/javascript" src="resources/vendor/select2/select2.min.js"></script>
	<script type="text/javascript">
		$(".selection-1").select2({
			minimumResultsForSearch: 20,
			dropdownParent: $('#dropDownSelect1')
		});
	</script>
	<!--===============================================================================================-->
	<script type="text/javascript" src="resources/vendor/slick/slick.min.js"></script>
	<script type="text/javascript" src="resources/js/slick-custom.js"></script>
	<!--===============================================================================================-->
	<script type="text/javascript" src="resources/vendor/countdowntime/countdowntime.js"></script>
	<!--===============================================================================================-->
	<script type="text/javascript" src="resources/vendor/lightbox2/js/lightbox.min.js"></script>
	<!--===============================================================================================-->
	<script type="text/javascript" src="resources/vendor/sweetalert/sweetalert.min.js"></script>
	<script type="text/javascript">
		$('.block2-btn-addcart').each(function(){
			var nameProduct = $(this).parent().parent().parent().find('.block2-name').html();
			$(this).on('click', function(){
				swal(nameProduct, "is added to cart !", "success");
			});
		});

		$('.block2-btn-addwishlist').each(function(){
			var nameProduct = $(this).parent().parent().parent().find('.block2-name').html();
			$(this).on('click', function(){
				swal(nameProduct, "is added to wishlist !", "success");
			});
		});
	</script>

	<!--===============================================================================================-->
	<script src="resources/js/main.js"></script>
	<!-- 자바 스크립트 영역 끝~! -->
	
	
</body>
</html>
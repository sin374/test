<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 



<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <!-- meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0"/ -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title></title>
        <!-- Bootstrap -->
        <link rel="stylesheet" type="text/css" href="resources/vendor/bootstrap/css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="resources/vendor/bootstrap/css/bootstrap.min.css">
       <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
   		 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
      <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
        <script type="text/javascript" src="resources/vendor/bootstrap/js/bootstrap.js"></script>
        <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
      <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>  
        <script type="text/javascript">
       		var OldPw = false;
        	var bPw = false
        	var bName = true;
        	var bBirth = true;
        	var bPhone = true;
        	var bEmail = true;
        
        	
        	//기존 비밀번호 onkeyup시
        	function CKOldPW() {
        		OldPw = false;
        		$('#OldpwMessage').html('기존 비밀번호를 확인하세요');
				$('#OldpwMessage').attr('style','color:red;');
			}
        	
        	//기존 비밀번호 확인
        	function CheckOldPW() {
        		$.ajax(
    					{
    						type: 'POST',
    						url: 'OldPWck',
    						data : {"id":$("#id").val(),"pw":$("#oldpw").val() },
    						success:function(result){
    							if(result==1){
    								swal({
    				  	      			  title: "확인",
    				  	      			  text: "비밀번호가 일치 합니다.",
    				  	      			  icon: "success",
    				  	      			});
    								$('#OldpwMessage').html('확인');
    			    				$('#OldpwMessage').attr('style','color:black;');
    			    				OldPw = true;
    								
    								
    							}else{
    								swal({
    			    	      			  title: "확인",
    			    	      			  text: "비밀번호가 일치 하지 않습니다.",
    			    	      			  icon: "warning",
    			    	      			});
    								$('#OldpwMessage').html('비밀번호 불일치');
    			    				$('#OldpwMessage').attr('style','color:red;');
    			    				OldPw = false;
    								
    							}
    						}						
    					}					
    			      );
			}
        	
        	
        	
        	//비밀번호 onkeyup
        	function CheckPW() {
        		var regType=/^.*(?=^.{6,12}$)(?=.*\d)(?=.*[a-zA-Z]).*$/;
        		var regType2 = /^[a-zA-Z0-9]{6,12}$/;
        		var pw= $('#pw').val();
        		var pwCK= $('#pwCK').val();
        		
        		if(!regType.test(pw)||!regType2.test(pw)){
    				$('#pwMessage').html('6~12자리 이내 숫자와 영문을 혼합하여 입력하십시오.(공백불가)');
    				$('#pwMessage').attr('style','color:red;');
    				bPw=false;
    				return;
    			}else{
    				$('#pwMessage').html('');
    				if(pw !=pwCK){
    					$('#pwMessage2').html('비밀번호가 서로 일치하지 않습니다.');
    					$('#pwMessage2').attr('style','color:red;');
    					bPw=false;
    				}else{
    						$('#pwMessage2').html('');
    						bPw=true;
    					}
    					}
    				}
        	
        	//주소 검색버튼 눌렀을때 onclick이벤트
        	function Postcode() {
                new daum.Postcode({
                    oncomplete: function(data) {
                       
                        var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                        var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                        if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                            extraRoadAddr += data.bname;
                        }
                       
                        if(data.buildingName !== '' && data.apartment === 'Y'){
                           extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }
                        // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                        if(extraRoadAddr !== ''){
                            extraRoadAddr = ' (' + extraRoadAddr + ')';
                        }
                        // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                        if(fullRoadAddr !== ''){
                            fullRoadAddr += extraRoadAddr;
                        }

                        // 우편번호와 주소 정보를 해당 필드에 넣는다.
                        document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
                        document.getElementById('addr1').value = fullRoadAddr;
                  			
                        document.getElementById('addr2').focus();
                    }
                }).open();
        	}
        	
        	//이름 input태그 - onkeyup
        	function CheckName() {
        		var regType=/^[가-힣]+$/;
        		var name=$('#name').val();

        		if(!regType.test(name)){
    				$('#NameMessage').html('한글만 입력하세요');
    				$('#NameMessage').attr('style','color:red;');
    				bName = false;
    				return;
    			}else{
    				$('#NameMessage').html('');
    				bName = true;
    			}

			}
        	
        	//생일 onkeyup
        	function CheckBirth() {
   				var year=$('#year').val();
   				var month=$('#month').val();
        		var day=$('#day').val();
        		var ThisYear = new Date().getFullYear();
        		var ThisMonth = new Date().getMonth();
        		var Today = new Date().getDate();
        		var FullYear = ThisYear+"-"+ThisMonth+"-"+Today;
        		  if(year<ThisYear-100||year>ThisYear){
        			$('#BirthMessage').html('태어난 년도 4자리를 정확하게 입력하세요.');
    				$('#BirthMessage').attr('style','color:red;');
    				bBirth = false;
    				return;
        		}else{
    				$('#BirthMessage').html('');
    				  if(month==2){
            			  if(day>=29 || day<=0){
            				 $('#BirthMessage').html('태어난 일(날짜) 2자리를 정확하게 입력하세요.');
              				$('#BirthMessage').attr('style','color:red;');
              				bBirth=false;
              				return;
            			}
            		  }else if(month==1||month==3||month==5||month==7||month==8||month==10||month==12){
            			  if(day>=32 || day<=0){
             				 $('#BirthMessage').html('태어난 일(날짜) 2자리를 정확하게 입력하세요.');
               				$('#BirthMessage').attr('style','color:red;');
               				bBirth=false;
               				return;
             			  }
            		  }else if(month==2||month==4||month==6||month==9||month==11){
            			  if(day>=31 || day<=0){
              				 $('#BirthMessage').html('태어난 일(날짜) 2자리를 정확하게 입력하세요.');
                				$('#BirthMessage').attr('style','color:red;');
                				bBirth=false;
                				return;
              			  }
            		  }else{
            			  $('#BirthMessage').html('');
            			  bBirth = true;
            		  }
    				  bBirth = true;
    			} 
			}
        	
        	//휴대폰 - onkeyup이벤트 
        	function CheckPhone() {
        		regType = /^01([0|1|6|7|8|9]?)([0-9]{3,4})([0-9]{4})$/;
        		var phone = $('#phone').val();
        		if(!regType.test(phone)){
        			$('#PhoneMessage').html('형식에 맞지 않는 번호입니다.');
    				$('#PhoneMessage').attr('style','color:red;');
    				bPhone=false;
    				return;
    			}else{
    				$('#PhoneMessage').html('');
    				bPhone=true;
    			}
        	}
        	
        	/* email - onkeyup이벤트발생시 */
        	function CheckEmail() {
        	    	var regType = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
					var email =$('#email').val();
					document.getElementById('HiddenEmail').value="0";
        	    	if((!regType.test(email)||email==null)){
        	    		$('#EmailMessage').html('형식에 맞지 않는 메일입니다.');
        				$('#EmailMessage').attr('style','color:red;');
        				bEmail=false;
        				return;
        	    	}else{
        	    		$('#EmailMessage').html('');
        				bEmail=true;
        			}
        	}
        	    	function CheckEmail2(){

            	    	$.ajax({
            	    		type:'POST',
            	    		url :'modifyEmail',
            	    		data:{"id":$("#id").val(), "email":$("#email").val()},
            	    		success:function(result){
            	    			if(result==1){
            	    				swal({
    				  	      			  title: "인증완료",
    				  	      			  text: "인증완료된 메일 입니다.",
    				  	      			  icon: "success",
    				  	      			});
            	    				document.getElementById('HiddenEmail').value="1";
            	    			}else{
            	    				swal({
    				  	      			  title: "인증메일",
    				  	      			  text: "인증메일을 보냈습니다. 링크를 클릭하셔서 인증하십시오",
    				  	      			  icon: "info",
    				  	      			});
            	    			}
            	    		}
            	    	});
            	    	
        	    	}
        	/* 회원가입 Form 에서 onSubmit함수 실행시  */
			function FinalCheck() {
				
				if (!OldPw){
    				swal({
    	      			  title: "확인",
    	      			  text: "기존 비밀번호를 확인하세요",
    	      			  icon: "warning",
    	      			});
    				return false;
				}
					if (!bPw){
	    				swal({
	    	      			  title: "확인",
	    	      			  text: "비밀번호를 확인하세요",
	    	      			  icon: "warning",
	    	      			});
	    				return false;
					}
				
				$.ajax(
    					{	type: 'POST',
    						url: 'emailState_Ck',
    						data : {"id":document.getElementById('id').value },
    						success:function(result){
    							if(result==1){
    	    					document.getElementById('HiddenEmail').value="1"
    	    						alert("회원정보 수정 완료")
    	    				}else{
    	    					document.getElementById('HiddenEmail').value="0" 
    	    					
    	    					if (!OldPw){
	    		    				swal({
	    		    	      			  title: "확인",
	    		    	      			  text: "기존 비밀번호를 확인하세요",
	    		    	      			  icon: "warning",
	    		    	      			});
	    		    				return false;
	    						}
    	    						if (!bPw){
    	    		    				swal({
    	    		    	      			  title: "확인",
    	    		    	      			  text: "비밀번호를 확인하세요",
    	    		    	      			  icon: "warning",
    	    		    	      			});
    	    		    				return false;
    	    						}
    	    						if (!bName){
    	    		    				swal({
    	    		  	      			  title: "확인",
    	    		  	      			  text: "이름을 확인하세요",
    	    		  	      			  icon: "warning",
    	    		  	      			});
    	    		    				return false;
    	    						}
    	    						if (!bBirth){
    	    		    				swal({
    	    		  	      			  title: "확인",
    	    		  	      			  text: "생년월일을 확인하세요",
    	    		  	      			  icon: "warning",
    	    		  	      			});
    	    		    				return false;
    	    						}
    	    						if (!bEmail){
    	    		    				swal({
    	    		  	      			  title: "확인",
    	    		  	      			  text: "이메일을 확인하세요",
    	    		  	      			  icon: "warning",
    	    		  	      			});
    	    		    				return false;
    	    						}
    	    						if (!bPhone){
    	    							swal({
    	    		  	      			  title: "확인",
    	    		  	      			  text: "전화번호를 확인하세요",
    	    		  	      			  icon: "warning",
    	    		  	      			});
    	    		    				return false;
    	    						}
    	    						if (document.getElementById("postcode").value==""||document.getElementById("addr1").value=="") {
    	    							swal({
    	    		  	      			  title: "확인",
    	    		  	      			  text: "주소를 확인하세요",
    	    		  	      			  icon: "warning",
    	    		  	      			});
    	    							return false;
    	    							
    	    						}
    	    						if(document.getElementById('HiddenEmail').value=="0"){
    	    							swal({
    	    		  	      			  title: "확인",
    	    		  	      			  text: "이메일을 인증하세요",
    	    		  	      			  icon: "warning",
    	    		  	      			});
    	    							return false;
    	    						}
    	    				}
    							
    	    		}
    	    	});
    	    	
				
				
			}
        </script>
    </head>
    
    
    
    
    
    
    
    
    
    <body>
        <div class="container" style="padding-top: 70px;padding-bottom: 70px;"><!-- 좌우측의 공간 확보 -->
           <hr/>
           
         <!-- 회원수정 폼 태그, memUpdate로 컨트롤러 요청 -->  
         <form class="form-horizontal" onsubmit="return FinalCheck(); return false;" action="memUpdate" method="post">
         <input type="hidden" name="HiddenEmail" id="HiddenEmail" value="1">
           <div class="form-group" id="divId" >
                <label for="inputId" class="col-lg-2 control-label"><b>아이디</b></label>
                <div class="col-lg-10 row">
                    <input type="text" class="form-control onlyAlphabetAndNumber" id="id"  maxlength="10" name="id" onkeyup="CheckID();" value="${member.id }" readonly="readonly">
     			 </div>
            </div>
            <div class="form-group" id="divPassword">
                <label for="inputPassword" class="col-lg-2 control-label"><b>기존 비밀번호</b></label>
                <div class="col-lg-10 row">
                    <input type="password" class="form-control col-10" id="oldpw" name="oldpw" placeholder="패스워드" maxlength="20"  onkeyup="CKOldPW(); return false;">
                    <input type="button" class="col-2 btn" value="확인" style="background-color: black; color: white;" onclick="CheckOldPW();">
                    <span id="OldpwMessage"></span>
                </div>
            </div>
            <div class="form-group" id="divPassword">
                <label for="inputPassword" class="col-lg-2 control-label"><b>새 비밀번호</b></label>
                <div class="col-lg-10 row">
                    <input type="password" class="form-control" id="pw" name="pw" placeholder="패스워드" maxlength="20" onkeyup="CheckPW();">
                    <span id="pwMessage"></span>
                </div>
            </div>
            <div class="form-group" id="divPasswordCheck">
                <label for="inputPasswordCheck" class="col-lg-2 control-label"><b>새 비밀번호 확인</b></label>
                <div class="col-lg-10 row">
                    <input type="password" class="form-control" id="pwCK" placeholder="패스워드 확인" maxlength="20" onkeyup="CheckPW();">
                    <span id="pwMessage2"></span>
                </div>
            </div>
            <div class="form-group" id="divName">
                <label for="inputName" class="col-lg-2 control-label"><b>이름</b></label>
                <div class="col-lg-10 row">
                    <input type="text" class="form-control onlyHangul" id="name" value="${member.name}" maxlength="5" name="name" onkeyup="CheckName();">
                     <span id="NameMessage"></span>
                </div>
            </div>
    
            <div class="form-group">
                <label class="col-lg-2 control-label"><b>생일</b></label>
                <div class="col-lg-10 row">
                	<input type="text" class="form-control col-4" id="year" value='<fmt:formatDate value="${member.birthdate }" pattern="yyyy" />' maxlength="4" name="year" onkeyup="CheckBirth();">
                    <select class="col-4" name="month" id="month" onchange="CheckBirth();">
                    	<fmt:formatDate value="${member.birthdate }" pattern="MM" var="mon" />
                    	<option value="1" <c:if test="${mon eq '01'}" >selected</c:if> >1월</option>
                    	<option value="2" <c:if test="${mon eq '02'}" >selected</c:if>>2월</option>
                    	<option value="3" <c:if test="${mon eq '03'}" >selected</c:if>>3월</option>
                    	<option value="4" <c:if test="${mon eq '04'}" >selected</c:if>>4월</option>
                    	<option value="5" <c:if test="${mon eq '05'}" >selected</c:if>>5월</option>
                    	<option value="6" <c:if test="${mon eq '06' }" >selected</c:if>>6월</option>
                    	<option value="7" <c:if test="${mon eq '07' }" >selected</c:if>>7월</option>
                    	<option value="8" <c:if test="${mon eq '08' }" >selected</c:if>>8월</option>
                    	<option value="9" <c:if test="${mon eq '09' }" >selected</c:if>>9월</option>
                    	<option value="10" <c:if test="${mon eq '10' }" >selected</c:if>>10월</option>
                    	<option value="11" <c:if test="${mon eq '11' }" >selected</c:if>>11월</option>
                    	<option value="12" <c:if test="${mon eq '12' }" >selected</c:if>>12월</option>
                    	
                    </select>
                    <input type="text" class="col-4 form-control" max="2" id="day" name="day" value='<fmt:formatDate value="${member.birthdate }" pattern="dd" />' onkeyup="CheckBirth();">
                    <span id="BirthMessage" ></span>
                </div>
            </div>
             
            <div class="form-group" id="divEmail">
                <label for="inputEmail" class="col-lg-2 control-label"><b>이메일</b></label>
                <div class="col-lg-10 row">
                    <input type="email" class="form-control col-10" id="email" value="${member.email}" maxlength="40" name="email" onkeyup="CheckEmail();">
                    <input type="button" class="col-2 btn" value="인증" style="background-color: black; color: white;" onclick="CheckEmail2()"> 
                    <span id="EmailMessage"></span>
                </div>
            </div>
            <div class="form-group" id="divPhoneNumber">
                <label for="inputPhoneNumber" class="col-lg-2 control-label"><b>휴대폰 번호</b></label>
                <div class="col-lg-10 row">
                    <input type="tel" class="form-control onlyNumber" id="phone" name="phone" value="${member.phone}" maxlength="11" onkeyup="CheckPhone();">
                     <span id="PhoneMessage" ></span>
                </div>
            </div>
             <div class="form-group">
                <label class="col-lg-2 control-label"><b>성별</b></label>
                <div class="btn-group col-lg-10" data-toggle="buttons">
				  <label class="btn btn-info active">
				    <input type="radio" name="sex" id="male" value="남" checked > 남
				  </label>
				  <label class="btn btn-info">
				    <input type="radio" name="sex" id="female" value="여"> 여
				  </label>
				 </div>
                
            </div>
            <div class="form-group">
                <label for="inputPhoneNumber" class="col-lg-2 control-label"><b>주소</b></label>
                <div class="col-lg-10 row">
                	
               	 	<input type="text" class="form-control col-10" id="postcode" name="postcode" readonly="readonly" value="${member.postcode }">
               	 	<input type="button" class="col-2 btn" onclick="Postcode();" value="검색" style="background-color: black; color: white;">
                </div>
                <div class="col-lg-10 row">
               	 	<input type="text" class="form-control" id="addr1" name="addr1" readonly="readonly" value="${member.addr1 }">
               	 	<c:choose>
               	 		<c:when test="${empty member.addr2 }">
               	 			<input type="text" class="form-control" id="addr2" name="addr2" >
               	 		</c:when>
               	 		<c:when test="${not empty member.addr2 }">
               	 			<input type="text" class="form-control" id="addr2" name="addr2" value="${member.addr2 }" >
               	 		</c:when>
               	 	</c:choose>
				</div>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-lg-10" align="center">
                <input type="submit" class="btn" style="width: 100px; background-color: black; color: white;" value="수정" >
                <input type="reset" class="btn btn-default" style="width: 100px;" value="취소">    
                    
                </div>
            </div>
        </form>
        <hr/>
        </div>

</body>
</html>
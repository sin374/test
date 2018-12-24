<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 

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
        	var bId = false;
        	var bPw = false;
        	var bName = false;
        	var bBirth = false;
        	var bPhone = false;
        	var bEmail = false;
        
        	//ID input태그에서 onkeyup발생시
        	 function CheckID() {document.getElementById('HiddenID').value="0";} 
        	
        	//ID중복확인 onClick이벤트 발생시
        	function DoubleCheck() {
        		var userID=$('#id').val();
        		var regType1 = /^.*(?=^.{4,10}$)(?=.*\d)(?=.*[a-zA-Z]).*$/;
        		var regType2 = /^[a-zA-Z0-9]{4,10}$/;
        		
        		if(!regType1.test(userID)||!regType2.test(userID)){
    				document.getElementById('HiddenID').value="0";
    				swal({
    	      			  title: "사용할 수 없음",
    	      			  text: "4~10글자 이내 숫자와 영문을 혼합해 입력하십시오.(공백불가)",
    	      			  icon: "warning",
    	      			});
    				document.getElementById('HiddenID').value="0";
    				bId = false;
    				return;
    			}else{
    				swal({
  	      			  title: "사용가능",
  	      			  text: "사용할수 있는 아이디 입니다",
  	      			  icon: "success",
  	      			});
    				swal("사용할수 있는 아이디 입니다.");
    				document.getElementById('HiddenID').value="1";
    				bId =true;
    			}
        		$.ajax(
    					{
    						type: 'POST',
    						url: 'idck',
    						data : {"id":$("#id").val() },
    						success:function(result){
    							if(result==0){
    								swal({
    				  	      			  title: "사용가능",
    				  	      			  text: "사용할수 있는 아이디 입니다",
    				  	      			  icon: "success",
    				  	      			});
    								document.getElementById('HiddenID').value="1";
    								
    								
    							}else{
    								swal({
    			    	      			  title: "사용할 수 없음",
    			    	      			  text: "중복된 아이디입니다.",
    			    	      			  icon: "warning",
    			    	      			});
    								document.getElementById('HiddenID').value="0";
    								
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
			
			
        	
        	/* 회원가입 Form 에서 onSubmit함수 실행시  */
			function FinalCheck() {
				if (!bId){
    				swal({
  	      			  title: "확인",
  	      			  text: "아이디를 확인하세요",
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
				if(document.getElementById('HiddenID').value=="0"){
					swal({
  	      			  title: "확인",
  	      			  text: "아이디를 중복확인하세요",
  	      			  icon: "warning",
  	      			});
					return false;
				}
				swal({
      			  title: "Thank you!",
      			  text: "입력한 이메일에서 회원가입 링크를 클릭하시면 회원가입이 완료됩니다",
      			  icon: "success",
      			});
				
			}
        </script>
    <style type="text/css">
    #checkModal{margin-top: 100px;}
    
    </style>
    </head>
    
    
    
    
    
    
    
    
    
    <body>
        <div class="container" style="padding-top: 70px;padding-bottom: 70px;"><!-- 좌우측의 공간 확보 -->
           <hr/>
           
         <!-- 회원가입 폼 태그, regist로 컨트롤러 요청 -->  
         <form class="form-horizontal" onsubmit="return FinalCheck();" action="regist" method="post">
           <div class="form-group" id="divId" >
                <label for="inputId" class="col-lg-2 control-label"><b>아이디</b></label>
                <div class="col-lg-10 row">
                    <input type="text" class="form-control onlyAlphabetAndNumber col-10" id="id" placeholder="4~10글자 이내 숫자와 영문을 혼합해 입력하십시오.(공백불가)" maxlength="20" name="id" onkeyup="CheckID();">
                   	<input type="button" class="col-2 btn btn-black" onclick="DoubleCheck();" value="중복확인" style="background-color: black; color: white;">
                    <input type="hidden" name="HiddenID" id="HiddenID" value="0">
                </div>
            </div>
            <div class="form-group" id="divPassword">
                <label for="inputPassword" class="col-lg-2 control-label"><b>패스워드</b></label>
                <div class="col-lg-10 row">
                    <input type="password" class="form-control" id="pw" name="pw" placeholder="패스워드" maxlength="20" onkeyup="CheckPW();">
                    <span id="pwMessage"></span>
                </div>
            </div>
            <div class="form-group" id="divPasswordCheck">
                <label for="inputPasswordCheck" class="col-lg-2 control-label"><b>패스워드 확인</b></label>
                <div class="col-lg-10 row">
                    <input type="password" class="form-control" id="pwCK" placeholder="패스워드 확인" maxlength="20" onkeyup="CheckPW();">
                    <span id="pwMessage2"></span>
                </div>
            </div>
            <div class="form-group" id="divName">
                <label for="inputName" class="col-lg-2 control-label"><b>이름</b></label>
                <div class="col-lg-10 row">
                    <input type="text" class="form-control onlyHangul" id="name" placeholder="한글만 입력 가능합니다." maxlength="5" name="name" onkeyup="CheckName();">
                     <span id="NameMessage"></span>
                </div>
            </div>
    
            <div class="form-group">
                <label class="col-lg-2 control-label"><b>생일</b></label>
                <div class="col-lg-10 row">
                    <input type="text" class="form-control col-4" id="year" placeholder="년" maxlength="4" name="year" onkeyup="CheckBirth();">
                    <select class="col-4" name="month" id="month" onchange="CheckBirth();">
                    	<option value="1">1월</option>
                    	<option value="2">2월</option>
                    	<option value="3">3월</option>
                    	<option value="4">4월</option>
                    	<option value="5">5월</option>
                    	<option value="6">6월</option>
                    	<option value="7">7월</option>
                    	<option value="8">8월</option>
                    	<option value="9">9월</option>
                    	<option value="10">10월</option>
                    	<option value="11">11월</option>
                    	<option value="12">12월</option>
                    </select>
                    <input type="text" class="col-4 form-control" max="2" id="day" name="day" placeholder="일" onkeyup="CheckBirth();">
                    <span id="BirthMessage" ></span>
                </div>
            </div>
             
            <div class="form-group" id="divEmail">
                <label for="inputEmail" class="col-lg-2 control-label"><b>이메일</b></label>
                <div class="col-lg-10 row">
                    <input type="email" class="form-control" id="email" placeholder="이메일" maxlength="40" name="email" onkeyup="CheckEmail();">
                    
                    <span id="EmailMessage"></span>
                </div>
            </div>
            <div class="form-group" id="divPhoneNumber">
                <label for="inputPhoneNumber" class="col-lg-2 control-label"><b>휴대폰 번호</b></label>
                <div class="col-lg-10 row">
                    <input type="tel" class="form-control onlyNumber" id="phone" name="phone" placeholder="-를 제외하고 숫자만 입력하세요." maxlength="11" onkeyup="CheckPhone();">
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
               	 	<input type="text" class="form-control col-10" id="postcode" name="postcode" readonly="readonly" >
               	 	<input type="button" class="col-2 btn" onclick="Postcode();" value="검색" style="background-color: black; color: white;">
                </div>
                <div class="col-lg-10 row">
               	 	<input type="text" class="form-control" id="addr1" name="addr1"  readonly="readonly">
               	 	<input type="text" class="form-control" id="addr2" name="addr2" >
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-lg-10" align="center">
                <input type="submit" class="btn" width="100px;" value="회원가입" style="background-color: black; color: white;">
                <input type="reset" class="btn btn-default" width="100px;" value="취소">    
                    
                </div>
            </div>
        </form>
        <hr/>
        </div>


	<!-- Modal -->
	<div class="modal fade" id="checkModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="vertical-alignment-helper">
			<div class="modal-dialog vartical-align-center">
				<div id="checkType" class="modal-content panel-info">
					<div class="modal-header panel-heading">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times;</span> <span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">확인메세지</h4>
					</div>
					<div id="checkMessage" class="modal-body"></div>
					<div class="modal-footer">
							<input type="button" class="btn btn-primary" value="확인"data-dismiss="modal">
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
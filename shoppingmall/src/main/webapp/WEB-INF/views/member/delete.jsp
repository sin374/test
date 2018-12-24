<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">


    <!-- Fonts -->
    <link rel="dns-prefetch" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css?family=Raleway:300,400,600" rel="stylesheet" type="text/css">
	 <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>  
    <script type="text/javascript">
    	function DelCheck() {
    		
    		if( document.getElementById("agree1").checked==false){
    			swal({
	      			  title: "확인",
	      			  text: "탈퇴안내를 확인하고 동의해주세요",
	      			  icon: "warning",
	      			});
    			document.getElementById("agree1").focus();
    			return false;
    		}
    		if(document.getElementById("agree2").checked==false){
    			swal({
	      			  title: "확인",
	      			  text: "탈퇴안내를 확인하고 동의해주세요",
	      			  icon: "warning",
	      			});
    			document.getElementById("agree2").focus();
    			return false;
    		}
    		
    		 var check = confirm("정말로 탈퇴하시겠습니까?");
    		if(check){
    		$.ajax({
	    		type:'POST',
	    		url :'pwCK',
	    		data:{"id":$("#id").val(), "pw":$("#pw").val()},
	    		success:function(result){
	    			if(result==1){
	    				alert("탈퇴에 성공하셨습니다.");
	    				location.href="${pageContext.request.contextPath}/";
	    				
	    			}else{swal({
	  	      			  title: "확인",
	  	      			  text: "비밀번호가 일치하지 않습니다..",
	  	      			  icon: "warning",
	  	      			});
	    			
	    			}
	    		}
	    	});
    		
    		} 
    		
		}
    </script>
<style>
    #font1{font-size: 30px; text-align: center;
    
    }
</style>
<title>Insert title here</title>
</head>
<body>
 <div class="container">
            <div class="form-group">
            	<label class="control-label" style="margin-top: 70px;">
            		<b id="font1">회원 탈퇴</b>
            	</label>
            	<hr style="border-top: 1px dashed gray;">
                <label class="control-label" style="margin-top: 70px;"><b>아이디는 재사용 및 복구 불가 안내</b></label>
                <div class="col-lg-10" id="provision">
                    <textarea class="form-control" rows="3" style="resize:none">
회원탈퇴 진행 시 본인을 포함한 타인 모두 아이디 재사용이나 복구가 불가능합니다.
신중히 선택하신 후 결정해주세요.
                    </textarea>
                    <div style="margin-bottom: 30px;">
                        <label>
                            <input type="checkbox" id="agree1" name="agree1" autofocus="autofocus">
                            동의합니다.
                        </label>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="memberInfo" class="control-label"><b>내정보 및 개인형 서비스 이용 기록 삭제 안내</b></label>
                <div class="col-lg-10" id="memberInfo">
                    <textarea class="form-control" rows="3" style="resize:none">
내정보 및 개인형 서비스 이용기록이 모두 삭제되며,삭제된 데이터는 복구되지 않습니다.
삭제되는 서비스를 확인하시고, 필요한 데이터는 미리 백업을 해주세요.
                    </textarea>
                    <div>
                        <label style="margin-bottom: 100px;">
                            <input type="checkbox" id="agree2" name="agree2">
                            동의합니다.
                        </label>
                    </div>
                </div>
            </div>
            <hr style="border-top: 1px dashed gray; margin-bottom: 30px;">
            <form  onsubmit ="DelCheck(); return false;">
            <div class="form-group" id="divId">
                <label for="inputId" class="col-lg-2 control-label">아이디</label>
                <div class="col-lg-10">
                    <input type="text" class="form-control"  value="${member.id }"  readonly="readonly" id="id" name="id" >
                </div>
            </div>
            <div class="form-group" id="divPassword">
                <label for="inputPassword" class="col-lg-2 control-label">패스워드</label>
                <div class="col-lg-10" >
                    <input type="password" id="pw" class="form-control" name="pw" required autofocus style="background-color: white;"> 
                </div>
            </div>
             <div class="col-md-6 offset-md-4" style="margin-bottom: 150px;">
                 <input type="submit" class="btn " value="확인" style="width: 100px; background-color: black; color: white;">                                
                 <input type="reset" class="btn btn-default" value="취소" style="width: 100px;">
              </div>
           </form>
            </div>
            
           <%--   <div class="card" style="margin-bottom: 150px;">
                    <div class="card-header"><b>비밀번호 재확인</b></div>
                    <div class="card-body">
                       	<form  onsubmit ="DelCheck(); return false;">
                            <div class="form-group row">
                                <label for="email_address" class="col-md-4 col-form-label text-md-right"><b>아이디</b></label>
                                <div class="col-md-6">
                                    <input type="text" class="form-control"  value="${member.id }"  readonly="readonly" id="id" name="id" >
                                </div>
                            </div>

                            <div class="form-group row">
                                <label for="password" class="col-md-4 col-form-label text-md-right"> <b>비밀번호</b></label>
                                <div class="col-md-6">
                                    <input type="password" id="pw" class="form-control" name="pw" required autofocus> 
                                </div>
                            </div>
							 <div class="col-md-6 offset-md-4">
                                <input type="submit" class="btn " value="확인" style="width: 100px; background-color: black; color: white;">                                
                                <input type="reset" class="btn btn-default" value="취소" style="width: 100px;">
                             </div>
                    </div>
                 </div>
                </div>
                
            </form> --%>

</body>
</html>
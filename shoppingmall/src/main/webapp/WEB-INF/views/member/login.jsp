<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<section class="newproduct bgwhite p-t-45 p-b-105">
	<div class="container">
		<div class="sec-title p-b-60">
			<h3 class="m-text5 t-center">LOGIN</h3>
		</div>


		<div style="width: 380px; margin: 0 auto;">
			<form:form role="form" commandName="loginCommand" action="login"
				method="post">
				<div>
					<fieldset style="position: relative; width: 380px; margin: 0 auto;">
						<label class="m-text12"
							style="overflow: hidden; display: block; width: 263px; margin: 0 0 10px; border: 1px solid #d9d9d9; border-radius: 2px; color: #8F8F91;">
							<form:input type="text" path="id" placeholder="ID" />
						</label> <label class="m-text12"
							style="display: block; width: 263px; margin: 0 0 10px; border: 1px solid #d9d9d9; border-radius: 2px; color: #8F8F91;">
							<form:password path="pw" placeholder="Password" />
						</label>
						<div>
							<label> <form:checkbox path="rememberId" />아이디 기억
							</label>
						</div>
						<p>
							<small><a href="javascript:findIdPw();">Forgot your
									ID or password?</a></small>
						</p>
						<button type="submit"
							style="position: absolute; top: 0; right: 7px;">
							<img
								src="//img.echosting.cafe24.com/skin/base_ko_KR/member/btn_login.gif"
								alt="login">
						</button>
					</fieldset>


				</div>
			</form:form>
		</div>
	</div>
</section>
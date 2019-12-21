<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<jsp:include page="Header.jsp"></jsp:include>
	<div id="logo" class="container" style="width:287px; text-align: center; margin-top:350px;">
		<div>
			<h1>
				<a href="Home">DM<span>BOX</span></a>
			</h1>   
		</div>
	</div>
	<div id="login" class="container" style="width:284px; margin-top:-13px;">  
		<div style=" margin-left:18px;">   
			<form>      
				<div id="divid" class="div_left">
		        	<input id="login__username" type="text" class="form__input" placeholder="Username" name="id" required>
				</div>
				<div id="divpw" class="div_left">
			        <input id="login__password" type="password" class="form__input" placeholder="Password" name="password" required>				
				</div>
				<div class="div_left">
			        <input id="login__submit" type="submit" value="로그인" onclick="login_check();">	  			
				</div>
			</form>
		</div>
	</div>
	<script type="text/javascript">
		function login_check() {
			
			var divid = $('#divid');
			var divpw = $('#divpw');
			
			if ($('#login__username').val() == "") {
				divid.removeClass("has-success");
				divid.addClass("has-error");
			} else if($('#login__password').val() == "") {
				divpw.removeClass("has-success");
				divpw.addClass("has-error");
			} else {
				$.ajax({
					type: 'POST',
					url: 'Login_Check',
					data: {
						id: $('#login__username').val(),
						pw: $('#login__password').val()
						},
					success: function(result){
						if(result == "1") {
							location.href="Home";
						} else if(result == "0") {
							alert("아이디 혹은 비밀번호가 일치하지 않습니다.");
						}
					}, error:function(request,status,error){
					    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);}
				})
			}
		}
	</script>
</body>
</html>
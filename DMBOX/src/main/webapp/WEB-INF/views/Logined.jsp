<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<jsp:include page="Header.jsp"></jsp:include>
	<div id="logo" class="container" style="width:287px; text-align: center; margin-top:1px;">
		<div style="margin-top:180px;">
			<h1>
				<a href="Home">DM<span>BOX</span></a>
			</h1>		
		</div>
		<div style="margin-top:27px;">
			<form method="POST">
	          <input id="login__username" type="text" class="form__input" placeholder="Username" name="id" required>
	          <input id="login__password" type="password" class="form__input" placeholder="Password" name="password" required>
	          <input id="login__submit" type="button" value="로그인" onclick="login_check();">
			</form>
		</div>
	</div>
	<script type="text/javascript">
		function login_check() {
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
	</script>
</body>
</html>
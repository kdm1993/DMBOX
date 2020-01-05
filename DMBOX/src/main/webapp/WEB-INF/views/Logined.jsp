<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<c:if test="${url != null}">    
		<script>
			var url = "<%=request.getAttribute("url")%>";
			
			location.href=url; 
		</script>
	</c:if>
	<jsp:include page="Header.jsp"></jsp:include>
	<div id="logo" class="container" style="width:287px; text-align: center; margin-top:350px;">
		<div>
			<h1>
				<a href="Home">DM<span>BOX</span></a>
			</h1>   
		</div>
	</div>
	<div id="login" class="container" style="width:284px; margin-top:-13px;">  
		<div style=" margin-left:18px;" class="on">   
			<form>      
				<div id="divid" class="div_left on">
		        	<input id="login__username" type="text" class="form__input" placeholder="Username" name="id" required>
				</div>
				<div id="divpw" class="div_left on">
			        <input id="login__password" type="password" class="form__input" placeholder="Password" name="password" required>				
				</div>
				<div class="div_left" class="on">
			        <input id="login__submit" type="button" value="로그인" onclick="login_check();">	  			
				</div>
			</form>
			<div id="naverLogin" class="div_left">  
				<button>
					<img src="${pageContext.request.contextPath}/resources/images/naverLogin.png" style="width:250px; height:55px;" onclick="location.href='NaverLogin'">
				</button>
			</div>
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
						if(result == '1') {
							location.href="Home";
						} else if(result == '0') {
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
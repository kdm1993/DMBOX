<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<jsp:include page="Banner.jsp"></jsp:include>
	<div id="EmailAuthRoom" class="container">
		<div>
			<div id="EmailAuthRoom_1">
				<span><%=request.getAttribute("id")%>님의 이메일 인증이 완료되지 않았습니다</span>
			</div>
			<div class="on" id="EmailAuthRoom_2">   
				<div id="EmailAuthRoom_2_1">     
					<div id="EmailAuthRoom_2_1_top">   
						<span><%=request.getAttribute("email")%></span>
					</div>
					<div id="EmailAuthRoom_2_1_bottom">
						<input id="ReSend_btn" type="button" value="재전송">
					</div>   
				</div>  
				<div id="EmailAuthRoom_2_2">
					<div id="EmailAuthRoom_2_2_top">   
						<input id="ChangeEmail" type="text" placeholder="이메일주소를 입력해주세요">
					</div>
					<div id="EmailAuthRoom_2_2_bottom">  
						<input id="ChangeSend_btn" type="button" value="이메일 주소 변경">
					</div>
				</div>
			</div>
		</div>
	</div>  
	<jsp:include page="Copyright.jsp"></jsp:include>
	<script>
		$('#ReSend_btn').click(function(event) {
			location.href="ReAuthMail?id=<%=request.getAttribute("id")%>&email=<%=request.getAttribute("email")%>";
		});
		
		$('#ChangeSend_btn').click(function(event) {
			var email = $('ChangeEmail').val(); 
			
			location.href="ChangeAuthMail?id=<%=request.getAttribute("id")%>&email="+email;
		});
	</script>
</body>
</html>
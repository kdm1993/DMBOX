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
	<div id="sub_menu" class="container">
		<jsp:include page="Sub_menu_admin.jsp"></jsp:include>
		<div id="sub_menu_2">
			<p>2명의 회원에게 전송을 완료했습니다</p>
			
			<textarea rows="10" cols="50" style="text-align: left; width:27%; height:10%;" readonly>김동민   ||   kdm1993@naver.com김동민   ||   aodns113@gmail.co.kr</textarea>
		</div>
	</div>
	<jsp:include page="Copyright.jsp"></jsp:include>
</body>
</html>
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
	<div id="JoinClear" class="container">
		<div>
			<span style="font-weight: bold;"><%=request.getAttribute("email")%></span><span>으로 인증메일을 발송했습니다</span>
		</div>
	</div>
	<jsp:include page="Copyright.jsp"></jsp:include>
</body>
</html>
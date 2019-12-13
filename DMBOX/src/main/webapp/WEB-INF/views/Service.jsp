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
	<div id="service" class="container">
		<c:forEach items="${searchlist}" var="list" varStatus="status" begin="0">    
			<div class="movielist">
				<ul>
					<li>
						<img src="${list.img}">
					</li>
					<li>
						<a class="title" href="#">${list.title} (${list.subtitle})</a>  
					</li>
					<li>
						<span>${list.date}년 개봉</span>
					</li>
					<li>
						<span>감독 : ${list.director}</span>
					</li>
					<li>
						<span>평점 : ${list.rating}</span>
					</li>
				</ul>
			</div>		
		</c:forEach>
	</div>
	<jsp:include page="Copyright.jsp"></jsp:include>
</body>
</html>
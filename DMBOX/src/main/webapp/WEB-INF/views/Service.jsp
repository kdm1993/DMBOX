<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<jsp:include page="Banner.jsp"></jsp:include>
	<div id="service" class="container">
		<div>
			<span>검색결과 ${total}개</span>
		</div>
		<c:choose>
			<c:when test="${not empty searchlist}">
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
			</c:when>
			<c:otherwise>
				<div style="text-align: center;">
					<span style="font-weight: bold;">"${search_text}"</span><span>&nbsp;&nbsp;에 대한 검색결과가 없습니다</span>				
				</div>
			</c:otherwise>
		</c:choose>
	</div>
	<jsp:include page="Copyright.jsp"></jsp:include>
</body>
</html>
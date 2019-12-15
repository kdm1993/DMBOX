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
	<div id="service_search" class="container">
		<div id="service_1">
			<form action="Service" method="get">
				<select>
					<option>통합검색</option>
					<option>영화제목</option>
					<option>감독이름</option>
				</select>
				<input type="text" name="search_text" value="${search_text}">
				<input type="image" src="${pageContext.request.contextPath}/resources/images/search.png" id="form_submit">
			</form>		
		</div>
		<div id="service_2">
			<a href="#">이전</a>
			<c:forEach var="list" varStatus="status" begin="1" end="${total/15+1}">
				<a href="javascript:void(0);" class="search_index">${status.count}</a>
			</c:forEach>
			<a href="#">다음</a>
		</div>
	</div>
	<jsp:include page="Copyright.jsp"></jsp:include>  
	<script>
		$(document).ready(function() {
			$('.search_index').click(function(event) {
				var i = $('.search_index').index(this);
				
				location.href="Service?search_text="+ <%=request.getAttribute("search_text")%> +"&index="+i;
			})
		})
	</script>
</body>
</html>
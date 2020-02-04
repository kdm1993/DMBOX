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
	<div id="homepage" class="container">
		<div class="sub_menu_slide" style="width: 170px;">    
			<div>
				<ul>  
					<li>
						<p style="font-weight: bold;">기능</p>		  	
					</li>
					<li class="slide_bar"><a href="Homepage?index=1">실시간 예매순위</a></li>
					<li class="slide_bar"><a href="Homepage?index=2">네이버 영화 API</a></li>
					<li class="slide_bar"><a href="Homepage?index=3">네이버 로그인 API</a></li>
					<li class="slide_bar"><a href="Homepage?index=4">이메일 인증</a></li>
					<li class="slide_bar"><a href="Homepage?index=5">게시판</a></li>    
				</ul>
			</div>   
		</div>
		<div id="homepage_1">
			<c:choose>
				<c:when test="${param.index == 1}">          
					<img src="${pageContext.request.contextPath}/resources/images/1.jpg">
					<img src="${pageContext.request.contextPath}/resources/images/2.jpg">
				</c:when>
				<c:when test="${param.index == 2}">     
					<img src="${pageContext.request.contextPath}/resources/images/3.jpg">
					<img src="${pageContext.request.contextPath}/resources/images/4.jpg">
				</c:when>
				<c:when test="${param.index == 3}">     
					<img src="${pageContext.request.contextPath}/resources/images/5.jpg">
					<img src="${pageContext.request.contextPath}/resources/images/6.jpg">
				</c:when>
				<c:when test="${param.index == 4}">     
					<img src="${pageContext.request.contextPath}/resources/images/7.jpg">
					<img src="${pageContext.request.contextPath}/resources/images/8.jpg">
				</c:when>
				<c:when test="${param.index == 5}">        
					<img src="${pageContext.request.contextPath}/resources/images/9.jpg">
					<img src="${pageContext.request.contextPath}/resources/images/10.jpg">
					<img src="${pageContext.request.contextPath}/resources/images/11.jpg">
					<img src="${pageContext.request.contextPath}/resources/images/12.jpg">
					<img src="${pageContext.request.contextPath}/resources/images/13.jpg">
					<img src="${pageContext.request.contextPath}/resources/images/14.jpg">
				</c:when>
			</c:choose>
		</div>
	</div>
	<jsp:include page="Copyright.jsp"></jsp:include>
</body>
<script>
	$(document).ready(function() {
		var i = <%=request.getParameter("index")%>;
		
		$('.sub_menu_slide li:eq('+ i +')').addClass('on');
	})
</script>
</html>
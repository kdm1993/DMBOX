<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import = "com.dm.org.MemberDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.carousel-inner > .item > a > img,
.carousel-inner > .item > img,
.img-responsive,
.thumbnail a > img,
.thumbnail > img {
	height : 500px;
}
</style>
</head>
<body>
	<jsp:include page="Header.jsp"></jsp:include>
	<%
		boolean logincheck = false;
		MemberDTO mbdto = new MemberDTO();
		HttpSession httpsession = request.getSession(false);
		if(httpsession != null) {
			if(httpsession.getAttribute("user") != null) {
				logincheck = true;
				mbdto = (MemberDTO) httpsession.getAttribute("user");
				pageContext.setAttribute("user", mbdto);
			}
		}
		pageContext.setAttribute("logincheck", logincheck);
	%>
	<div id="header" class="container">
		<div><a href="#">고객센터</a></div>
		<c:choose>
			<c:when test="${logincheck == false}">
				<div><a href="#">회원가입</a></div>
				<div><a href="Logined">로그인</a></div>
			</c:when>
			<c:when test="${logincheck == true}">
				<div><a href="Logout">로그아웃</a></div>
				<%
					if(mbdto.getId().equals("root")) {
						%>
							<div><a href="Memberlist">관리자메뉴</a></div>
						<%
					} else {
						%>
							<div><a href="#">마이페이지</a></div>						
						<%
					}
				%>
				<div><a style="color:white;"><%=mbdto.getName()%>님</a></div>
			</c:when>
		</c:choose>
	</div>
	<div id="logo" class="container">
		<div id="logo1">
			<h1>
				<a href="Home">DM<span>BOX</span></a>
			</h1>		
		</div>
		<div id="logo2">
			<form action="se">
				<select>
					<option>통합검색</option>
					<option>영화제목</option>
					<option>감독이름</option>
				</select>
				<input type="text"/>	
			</form>
		</div>
		<!-- 
		<p>Design by <a href="http://templated.co" rel="nofollow">TEMPLATED</a></p>
	 -->
	</div>
	<div id="menu" class="container">
		<ul>
			<li class="current_page_item"><a href="Home">홈</a></li>
			<li><a href="">영화</a></li>
			<li><a href="">대기중</a></li>
			<li><a href="">대기중</a></li>
			<li><a href="">대기중</a></li>
			<li><a href="">고객센터</a></li>
		</ul>
	</div>
</body>
</html>
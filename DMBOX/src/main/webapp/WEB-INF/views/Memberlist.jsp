<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.dm.org.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<%
		List<MemberDTO> list = (ArrayList) request.getAttribute("list");
	%>
	<jsp:include page="Banner.jsp"></jsp:include>
	<div id="sub_menu" class="container">
		<jsp:include page="Sub_menu_admin.jsp"></jsp:include>
		<div id="sub_menu_2">
			<table class="tbl_type" cellspacing="0">
				<caption>DMBOX 회원리스트</caption>
				<colgroup>
					<col width="5%">
					<col width="10%">
					<col width="5%">
					<col width="20%">
					<col width="10%">
					<col width="5%">
					<col width="5%">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">아이디</th>
						<th scope="col">이름</th>
						<th scope="col">성별</th>
						<th scope="col">주소</th>
						<th scope="col">전화번호</th>
						<th scope="col">이메일주소</th>
						<th scope="col">이메일수신여부</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="dto" items="${list}">
						<tr align="center">
							<td>${dto.id}</td>
							<td>${dto.name}</td>
							<td>${dto.gender}</td>
							<td>${dto.otherAddress}</td>
							<td>${dto.tel}</td>
							<td>${dto.email}</td>
							<td>${dto.emailYn}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<jsp:include page="Copyright.jsp"></jsp:include>
</body>
</html>
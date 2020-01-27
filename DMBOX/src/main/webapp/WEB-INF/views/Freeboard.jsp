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
	<jsp:include page="Banner.jsp"></jsp:include>
	<div id="freeboard" class="container">
		<div id="freeboard_1">
			<table class="tbl_type" cellspacing="0">
				<caption>DMBOX 게시판</caption>
				<colgroup>
					<col width="10%">
					<col width="60%">
					<col width="10%">
					<col width="10%">   
					<col width="10%">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">제목</th>
						<th scope="col">작성자</th>
						<th scope="col">날짜</th>
						<th scope="col">조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="x" begin="1" end="20">
						<tr align="center">
							<td>${x}</td>
							<td>${x}</td>
							<td>${x}</td>
							<td>${x}</td>
							<td>${x}</td>
						</tr>					
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div id="freeboard_2">
			<button type="button" class="btn btn-success" id="write_btn">글쓰기</button>
		</div>
	</div>
	<jsp:include page="Copyright.jsp"></jsp:include>
</body>
<script type="text/javascript">
	$('#write_btn').click(function() {
		location.href='FreeboardWrite';
	})
</script>
</html>
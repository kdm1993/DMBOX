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
					<col width="50%">
					<col width="15%">  
					<col width="15%">   
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
					<c:forEach var="fb" items="${list}">   
						<tr align="center">
							<td>${fb.idx}</td>
							<td><a href="read?idx=${fb.idx}">${fb.title}<span style="color:red;">&nbsp;[${fb.reply_count}]</span></a></td>
							<td>${fb.writer}</td>
							<td>${fb.regdate}</td>
							<td>${fb.view}</td>  
						</tr>					
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div id="freeboard_2">
			<div id="service_1">
				<c:if test="${index!=0}">
					<a href="javascript:;" onClick="return false;" id="previous">이전</a>			
				</c:if>
				<c:forEach var="list" varStatus="status" begin="1" end="${index_num}">     
					<a href="javascript:;" class="search_index" onClick="return false;">${status.count + (index * 10)}</a>  
				</c:forEach>
				<c:if test="${(index+1)*200<total}">       
					<a href="javascript:;" onClick="return false;" id="next">다음</a>
				</c:if>       
				<button type="button" class="btn btn-success" id="write_btn" style="float:right">글쓰기</button>			
			</div>
			<div id="service_2" class="on">  
				<form action="Service" method="get">
					<input type="text" name="search_text" value="${search_text}">
					<input type="image" src="${pageContext.request.contextPath}/resources/images/search.png">
				</form>		
			</div>
		</div>
	</div>
	<jsp:include page="Copyright.jsp"></jsp:include>
</body>
<script type="text/javascript">
	$('#write_btn').click(function() {
		if("<%=request.getAttribute("user")%>" != "null") {
			location.href='FreeboardWrite';			
		} else {
			Login_back();
		}
	})
	
	$('.search_index').click(function(event) {
		var i = $('.search_index').index(this);
		
		location.href="<%=request.getContextPath()%>/Freeboard?index=<%=Integer.parseInt(String.valueOf(request.getAttribute("index")))%>&page="+i+"";
	})
	
	$('#previous').click(function(event) {
		var path = "<%=request.getContextPath()%>";     
		var search_text = <%=request.getAttribute("search_text")%>;   
		var index = <%=Integer.parseInt(String.valueOf(request.getAttribute("index")))-1%>;

		location.href=path+"/Freeboard?index="+index+"&page=0";
	})  
	
	$('#next').click(function(event) {  
		var path = "<%=request.getContextPath()%>";    
		var search_text = <%=request.getAttribute("search_text")%>;
		var index = <%=Integer.parseInt(String.valueOf(request.getAttribute("index")))+1%>;

		location.href=path+"/Freeboard?index="+index+"&page=0";
	})
	
	$(document).ready(function() {    
		$('.search_index').eq(<%=request.getParameter("page")%>).addClass('on');
	})
</script>
</html>
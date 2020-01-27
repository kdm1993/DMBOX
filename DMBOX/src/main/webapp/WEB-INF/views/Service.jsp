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
	<%
		int total = Integer.parseInt((String) request.getAttribute("total"));
		int page_idx = Integer.parseInt((String) request.getAttribute("page"));
		int index_num;
	
		if((total/15+1)-(page_idx * 10) > 10) {
			index_num = 10;
		} else {
			index_num = (total/15+1)-(page_idx * 10);
		}
		
		request.setAttribute("index_num", index_num);
	%>
	<jsp:include page="Banner.jsp"></jsp:include>
	<div id="service" class="container">
		<div>
			<span><strong>'<%=request.getAttribute("search_text")%>'</strong>에 대한 검색결과 <strong>${total}</strong>개</span>
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
					<span><strong>'${search_text}' 에 대한 검색결과가 없습니다</strong></span>				
				</div>
			</c:otherwise>
		</c:choose>
	</div>
	<div id="service_search" class="container">
		<div id="service_1">
			<c:if test="${page!=0}">
				<a href="javascript:;" onClick="return false;" id="previous">이전</a>			
			</c:if>
			<c:forEach var="list" varStatus="status" begin="1" end="${index_num}">
				<a href="javascript:;" class="search_index" onClick="return false;">${status.count + (page * 10)}</a>  
			</c:forEach>
			<c:if test="${(page+1)*150<total}">  
				<a href="javascript:;" onClick="return false;" id="next">다음</a>
			</c:if>  
		</div>
		<div id="service_2" class="on">  
			<form action="Service" method="get">
				<select>
					<option>통합검색</option>
					<option>영화제목</option>
					<option>감독이름</option>
				</select>
				<input type="text" name="search_text" value="${search_text}">
				<input type="image" src="${pageContext.request.contextPath}/resources/images/search.png">
			</form>		
		</div>
	</div>
	<jsp:include page="Copyright.jsp"></jsp:include>  
	<script>
		$(document).ready(function() {
			$('.search_index').click(function(event) {
				var i = $('.search_index').index(this);
				
				location.href="<%=request.getContextPath()%>/Service?search_text=<%=request.getAttribute("search_text")%>&index="+i+"&page=<%=Integer.parseInt((String)request.getAttribute("page"))%>";
			})
			
			$('#previous').click(function(event) {
				var path = "<%=request.getContextPath()%>";   
				var search_text = <%=request.getAttribute("search_text")%>;
				var page = <%=Integer.parseInt((String)request.getAttribute("page"))-1%>;

				location.href=path+"/Service?search_text="+search_text+"&index=0&page="+page;
			})
			
			$('#next').click(function(event) {
				var path = "<%=request.getContextPath()%>";   
				var search_text = <%=request.getAttribute("search_text")%>;
				var page = <%=Integer.parseInt((String)request.getAttribute("page"))+1%>;

				location.href=path+"/Service?search_text="+search_text+"&index=0&page="+page;
			})
			
			$('.search_index').eq(<%=request.getParameter("index")%>).addClass('on');
		})
	</script>
</body>
</html>
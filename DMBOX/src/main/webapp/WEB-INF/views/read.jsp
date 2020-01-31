<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<jsp:include page="Banner.jsp"></jsp:include>
	<div id="read" class="container">
		<div class="sub_menu_slide">   
			<div>
				<ul>   
					<li>
						<p style="font-weight: bold;">게시판</p>	   		
					</li>
					<li class="slide_bar"><a href="Freeboard">영화 정보 게시판</a></li>
				</ul>
			</div>   
		</div>
		<div id="read_1">
			<div id="title">
				<span style="float:left">${post.title}</span>
				<span style="float:right">${post.regdate}</span>
			</div>
			<div id="nick">
				<span>${post.writer}</span>   
			</div>
			<div id="post_content">  
				${post.content}		
			</div>
			<div id="post_info">  
				<span>댓글 ${fn:length(list)}개&nbsp;&nbsp;&nbsp;&nbsp;</span>
				<span>조회수 ${post.view}</span>
			</div>
			<c:forEach var="reply" items="${list}" varStatus="status">    
				<div class="reply">  
					<c:if test="${reply.depth == 2}">
						<div class="rereply"><span>┗</span></div>
					</c:if>	
					<div class="reply_info">
						<div>     
							<span>${reply.writer}&nbsp;&nbsp;&nbsp;&nbsp;</span>
							<span style="color:#E2E2E2;">${reply.regdate}&nbsp;&nbsp;&nbsp;&nbsp;</span>
							<button class="reply_btn">답글</button>
						</div>
						<div>
							<span>${reply.content}</span>
						</div> 						
					</div>
					<div class="rereply_on" style="display: none;">    
						<c:if test="${reply.depth == 2}">    
							<div class="rereply"></div>
						</c:if>   
						<div class="reply_input" id="rereply_input">     
							<div>
								<textarea class="recomment_text"></textarea>
							</div>       
							<div>    
								<a href="#" class="recomment_submit" onclick="return false;">등록</a>  
							</div>  
						</div>					
					</div>
				</div>
			</c:forEach>   
			<div class="reply_input">
				<div>
					<textarea id="comment_text"></textarea>
				</div>
				<div>  
					<a href="#" id="comment_submit" onclick="return false;">등록</a>  
				</div> 
			</div>
		</div>
	</div>
	<jsp:include page="Copyright.jsp"></jsp:include>
</body>
<script>
	$('.recomment_submit').click(function(event) {
		
		var i = $('.recomment_submit').index(this);
		 
		if($('.recomment_text').eq(i).val() == "") {
			alert("공백입니다")
		} else if("<%=request.getAttribute("user")%>" != "null") {  
			$.ajax({
				type: 'POST',
				url: 'reply',  
				data: {  
					value: 2,
					content : $('.recomment_text').eq(i).val(),
					writer : "<%=request.getAttribute("user")%>",
					post_idx : <%=request.getParameter("idx")%>, 
					reply_idx : <%=request.getAttribute("reply_count")%>,
					index : i  
					},
				success: function(result){
					location.reload();
				} 
			})
		} else {
			Login_back();
		}  
	}) 
	
	$('#comment_submit').click(function(event) {

		if($('#comment_text').val() == "") {
			alert("공백입니다")
		} else if("<%=request.getAttribute("user")%>" != "null") {  
			$.ajax({
				type: 'POST',
				url: 'reply',  
				data: {  
					value: 1,
					content : $('#comment_text').val(), 
					writer : "<%=request.getAttribute("user")%>",
					post_idx : <%=request.getParameter("idx")%>, 
					reply_idx : <%=request.getAttribute("reply_count")%>,
					},
				success: function(result){
					location.reload();
				} 
			})
		} else {
			Login_back();
		}  
	}) 
	
	$('.recomment_text').keyup(function(event) {
		if($(this).val().length > 1000) {   
			alert("1000자 이상 입력할 수 없습니다");    
			$(this).val($(this).val().substring(0, 100));
		}
	})
	
	$('#comment_text').keyup(function(event) {
		if($(this).val().length > 1000) {   
			alert("1000자 이상 입력할 수 없습니다");    
			$(this).val($(this).val().substring(0, 100));
		}
	})
	
	$('.reply_btn').click(function(event) {
		var i = $('.reply_btn').index(this);
		
		$('.rereply_on').hide();  
		$('.rereply_on').eq(i).show();
	})
</script>
</html>
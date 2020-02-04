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
					<li class="slide_bar"><a href="Freeboard?index=0&page=0">영화 정보 게시판</a></li>
				</ul>
			</div>   
		</div>
		<div id="read_1">
			<div id="title">
				<span style="float:left">${post.title}</span>
				<span style="float:right">${post.regdate}</span>
			</div>
			<div id="nick">
				<span>${post.writer} (${post.id})</span>     
			</div>
			<div id="post_content">  
				${post.content}		
			</div>
			<div id="post_info">   
				<span>댓글 ${fn:length(list)}개&nbsp;&nbsp;&nbsp;&nbsp;</span>
				<span>조회수 ${post.view}</span>
				<c:if test="${post.id == userID}">
					<a href="#" id="post_delete" style="float: right" onclick="return false;">삭제</a>
					<span style="float: right">&nbsp;&nbsp;&nbsp;&nbsp;</span>    
					<a href="#" id="post_change" style="float: right" onclick="return false;">수정</a>  
				</c:if>  
			</div>
			<c:forEach var="reply" items="${list}" varStatus="status">    
				<div class="reply">
					<c:choose>
						<c:when test="${reply.state == '1'}">
							<c:if test="${reply.depth == 2}">
								<div class="rereply"><span>┗</span></div>   
							</c:if>         
							<div class="reply_info">
								<span>&nbsp;&nbsp;&nbsp;&nbsp;삭제된 댓글입니다</span>
								<div style="display: none;">        
									<span>${reply.writer}  (${reply.id})&nbsp;&nbsp;&nbsp;&nbsp;</span>
									<span style="color:#E2E2E2;">${reply.regdate}&nbsp;&nbsp;&nbsp;&nbsp;</span>
									<button class="reply_btn">답글</button>   
									<button class="reply_btn_cancle" style="color: red; display: none">답글 취소</button>
									<c:if test="${reply.id == userID}">
										<input type="text" style="display: none;" class="reply_idx" value="${reply.idx}">     
										<a href="#" class="reply_delete" style="float: right" onclick="return false;">삭제</a>
										<span style="float: right">&nbsp;&nbsp;&nbsp;&nbsp;</span>    
										<a href="#" class="reply_change" style="float: right" onclick="return false;">수정</a>
										<a href="#" class="reply_change_cancle" style="float: right; color: red; display: none;" onclick="return false;">수정 취소</a>
									</c:if>  
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
							<c:if test="${reply.id == userID}">
								<div class="rereply_change_on" style="display: none;">    
									<c:if test="${reply.depth == 2}">    
										<div class="rereply"></div>
									</c:if>   
									<div class="reply_input" id="rereply_input">     
										<div>  
											<textarea class="comment_change_text">${reply.content}</textarea>
										</div>       
										<div>    
											<a href="#" class="comment_change_submit" onclick="return false;">수정</a>  
										</div>  
									</div>					
								</div>  
							</c:if>  
						</c:when>
						<c:otherwise>
							<c:if test="${reply.depth == 2}">  
								<div class="rereply"><span>┗</span></div>   
							</c:if>	
							<div class="reply_info">  
								<div>  
									<span>${reply.writer}  (${reply.id})&nbsp;&nbsp;&nbsp;&nbsp;</span>
									<span style="color:#E2E2E2;">${reply.regdate}&nbsp;&nbsp;&nbsp;&nbsp;</span>
									<button class="reply_btn">답글</button>   
									<button class="reply_btn_cancle" style="color: red; display: none">답글 취소</button>
									<c:if test="${reply.id == userID}">
										<input type="text" style="display: none;" class="reply_idx" value="${reply.idx}">
										<a href="#" class="reply_delete" style="float: right" onclick="return false;">삭제</a>
										<span style="float: right">&nbsp;&nbsp;&nbsp;&nbsp;</span>    
										<a href="#" class="reply_change" style="float: right" onclick="return false;">수정</a>
										<a href="#" class="reply_change_cancle" style="float: right; color: red; display: none;" onclick="return false;">수정 취소</a>
									</c:if>  
								</div>  
								<div class="reply_content">
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
							<c:if test="${reply.id == userID}">   
								<div class="rereply_change_on" style="display: none;">    
									<c:if test="${reply.depth == 2}">    
										<div class="rereply"></div>
									</c:if>   
									<div class="reply_input" id="rereply_input">     
										<div>  
											<textarea class="comment_change_text">${reply.content}</textarea>
										</div>       
										<div>    
											<a href="#" class="comment_change_submit" onclick="return false;">수정</a>  
										</div>  
									</div>					
								</div>  
							</c:if>
						</c:otherwise>
					</c:choose>
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
	$('.reply_change').click(function(event) {
		
		var i = $('.reply_change').index(this);
		
		$('.reply_btn').eq(i).show();
		$('.reply_btn_cancle').eq(i).hide();  
		$('.reply_change').eq(i).hide();
		$('.reply_change_cancle').eq(i).show();
		$('.reply_content').eq(i).hide();
		$('.rereply_on').eq(i).hide();
		$('.rereply_change_on').eq(i).show();  
	}) 
	
	$('.reply_change_cancle').click(function(event) {
		
		var i = $('.reply_change_cancle').index(this);
		
		$('.reply_change_cancle').eq(i).hide();
		$('.reply_change').eq(i).show();
		$('.reply_content').eq(i).show();    
		$('.rereply_change_on').eq(i).hide();  
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
					id : "<%=request.getAttribute("userID")%>"  
					},
				success: function(result){
					location.reload();
				} 
			})
		} else {
			Login_back();
		}  
	})

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
					index : i,
					id : "<%=request.getAttribute("userID")%>"   
					},
				success: function(result){
					location.reload();
				} 
			})
		} else {
			Login_back();
		}  
	})
	
	$('.comment_change_submit').click(function(event) {
		
		var i = $('.comment_change_submit').index(this);
		alert($('.reply_idx').eq(i).val()); 
		 
		if($('.comment_change_text').eq(i).val() == "") {
			alert("공백입니다")
		} else if("<%=request.getAttribute("user")%>" != "null") {  
			$.ajax({   
				type: 'POST',
				url: 'reply',  
				data: {  
					value: 3,
					content : $('.comment_change_text').eq(i).val(),
					idx : $('.reply_idx').eq(i).val()   
					},
				success: function(result){
					location.reload();
				} 
			})
		} else {
			Login_back();
		}  
	})
	
	$('.reply_delete').click(function(event) {
		
		var alert;
		
		alert = confirm("댓글을 삭제 하시겠습니까?");
		  
		if(alert) {
			var i = $('.reply_delete').index(this);
			 
			$.ajax({   
				type: 'POST',
				url: 'reply',    
				data: {  
					value: 4,
					idx : $('.reply_idx').eq(i).val()   
					},
				success: function(result){
					location.reload();
				} 
			})
		}   
	})
	
	$('#post_change').click(function(event) {  
		location.href="FreeboardChange?idx="+<%=request.getParameter("idx")%>
	}) 
	
	$('#post_delete').click(function(event) {
		var alert;
		
		alert = confirm("게시글을 삭제 하시겠습니까?");
		  
		if(alert) {
			location.href="FreeboardDelete?idx="+<%=request.getParameter("idx")%>;		
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
		
		$('.reply_change_cancle').eq(i).hide();
		$('.reply_change').eq(i).show();
		$('.reply_content').eq(i).show(); 
		$('.reply_btn_cancle').eq(i).show();
		$('.reply_btn').eq(i).hide();
		$('.rereply_on').hide();
		$('.rereply_change_on').hide();  
		$('.rereply_on').eq(i).show();
	})
	  
	$('.reply_btn_cancle').click(function(event) {
		   
		var i = $('.reply_btn_cancle').index(this);
		
		$('.reply_btn').eq(i).show();
		$('.reply_btn_cancle').eq(i).hide();  
		$('.rereply_on').hide();
	})
</script>
</html>
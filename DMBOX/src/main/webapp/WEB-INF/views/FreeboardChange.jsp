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
	<div id="FreeboardWrite" class="container">
		<form action="FreeboardChangeSend" method="POST" accept-charset="UTF-8" id="freeboard_form">
			<div>
				<label style="font-weight: bold; margin:1%;">제목</label>
				<input type="text" id="title" name="title" value="${post.title}" style="border:1px solid #CCCCCC; width:90%;" placeholder="게시글 제목을 입력하세요" required>		
			</div>    
			<div>
				<textarea name="textAreaContent" id="textAreaContent" rows="25" style="width:100%">${post.content}</textarea>		
			</div>  
			<div>
				<button type="submit" value="전송" id="submit_btn" class="btn btn-primary btn-lg" onsubmit="return false;">완료</button>
				<input type="hidden" name="writer" value="${post.writer}">
				<input type="hidden" name="id" value="${post.id}">
				<input type="hidden" name="idx" value="${post.idx}">     
			</div>
		</form>  
	</div>
	<jsp:include page="Copyright.jsp"></jsp:include>        
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/SmartEditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/SmartEditor/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>
<script type="text/javascript">
	var oEditors = [];
	
	nhn.husky.EZCreator.createInIFrame({
	    oAppRef: oEditors,
	    elPlaceHolder: "textAreaContent",
	    sSkinURI: "${pageContext.request.contextPath}/resources/SmartEditor/SmartEditor2Skin.html",
	    fCreator: "createSEditor2"
	});  
	$("#submit_btn").click(function(){ 
		if("<%=request.getAttribute("user")%>" != "null") {
			oEditors.getById["textAreaContent"].exec("UPDATE_CONTENTS_FIELD", []);
			
			return true;  			
		} else {      
			Login_back();
			return false;
		}
	});
	
	function pasteHTML(filepath){
	    var sHTML = '<img src="${pageContext.request.contextPath}/resources/SmartEditor/photo_uploader/popup/saveimg/'+filepath+'">';
	    oEditors.getById["textAreaContent"].exec("PASTE_HTML", [sHTML]);
	}
</script>
</html>
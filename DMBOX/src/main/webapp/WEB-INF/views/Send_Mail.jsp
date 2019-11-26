<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	#sub_menu_2 {
		background-color: white;
		color: black;		
	}
</style>
</head>
<body>
	<jsp:include page="Banner.jsp"></jsp:include>
	<div id="sub_menu" class="container">
		<jsp:include page="Sub_menu_admin.jsp"></jsp:include>
		<div id="sub_menu_2">
			<form action="Send" method="POST" accept-charset="UTF-8" id="mail_form">
				<div style="margin-left:1%;">
					<span style="font-weight: bold; margin:1%;">제목</span>
					<input type="text" id="title" name="title" style="border:1px solid #CCCCCC; width:90%; margin-left:3%;" required>		
				</div>
				<div style="margin-top : 3%; width:100%;">
					<textarea name="textAreaContent" id="textAreaContent" rows="25" cols="120"></textarea>		
				</div>
				<div style="margin-top : 2%; margin-left : 42%;">
					<input type="submit" value="전송" id="submit_btn">
				</div>
			</form>
		</div>
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
		oEditors.getById["textAreaContent"].exec("UPDATE_CONTENTS_FIELD", []); 
	});
	function pasteHTML(filepath){
	    var sHTML = '<img src="${pageContext.request.contextPath}/resources/SmartEditor/photo_uploader/popup/saveimg/'+filepath+'">';
	    oEditors.getById["textAreaContent"].exec("PASTE_HTML", [sHTML]);
	}
</script>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<script>
		var result = <%=request.getAttribute("result")%> 
		
		if(result == 0) {
			alert("잘못된 접근입니다.");			
		} else if(result == 1) {
			alert("인증이 완료되었습니다");
		}
		
		location.href="Home";
	</script>
</body>
</html>
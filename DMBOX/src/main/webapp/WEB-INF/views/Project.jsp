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
	<div id="project" class="container">
		<div class="sub_menu_slide">   
			<div>
				<ul>
					<li>
						<p style="font-weight: bold;">프로젝트</p>			
					</li>
					<li class="slide_bar"><a href="Project?index=1">아구몬 어드벤처</a></li>
					<li class="slide_bar"><a href="Project?index=2">슈팅 게임</a></li>
					<li class="slide_bar"><a href="Project?index=3">길 찾기</a></li>
				</ul>
			</div>   
		</div>
		<div id="project_1">
			<div id="project_1_1">
				<c:choose>
					<c:when test="${param.index == 1}">          
						<iframe width="672" height="378" src="https://www.youtube-nocookie.com/embed/6yBdFkO6REE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
					</c:when>
					<c:when test="${param.index == 2}">     
						<iframe width="672" height="378" src="https://www.youtube-nocookie.com/embed/nPPFWrsY80U" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
					</c:when>
					<c:when test="${param.index == 3}">     
						<iframe width="672" height="378" src="https://www.youtube-nocookie.com/embed/k5eV8Khxd-I" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
					</c:when>
				</c:choose>
			</div>
			<div class="table-users">
					<c:choose>
						<c:when test="${param.index == 1}">          
							<div class="header">아구몬 어드벤처</div>
							<table>
								<colgroup>
									<col width="30%">
								</colgroup>
							    <tr>
							       <td scope="col">개발기간</td>
							       <td>2달</td>   
							    </tr>
							    <tr>   
							       <td>단위</td>
							       <td>개인</td>     
							    </tr>
							    <tr>
							       <td>사용 언어</td>
							       <td>HTML, CSS, JAVASCRIPT</td>    
							    </tr>
							    <tr>
							       <td>배포여부</td>
							       <td>O</td>    
							    </tr>
							    <tr>   
							       <td>설명</td>
							       <td>플레이타임 1~2시간의 2D RPG 게임입니다.<br><br>     
							       일반 몬스터를 잡아 돈을 모아 스킬을 사고, 일부 몬스터는 일정 확률로 아이템과 펫을 드랍합니다.<br><br>
							       모든 보스 클리어가 목표인 게임입니다.</td>     
							    </tr>
							</table>
						</c:when>
						<c:when test="${param.index == 2}">     
							<div class="header">아이언맨 슈팅게임</div>
							<table>
								<colgroup>
									<col width="30%">
								</colgroup>
							    <tr>
							       <td scope="col">개발기간</td>
							       <td>2주</td>   
							    </tr>
							    <tr>   
							       <td>단위</td>
							       <td>개인</td>     
							    </tr>
							    <tr>
							       <td>사용 언어</td>
							       <td>JAVA</td>    
							    </tr>
							    <tr>
							       <td>배포여부</td>
							       <td>X</td>    
							    </tr>
							    <tr>   
							       <td>설명</td>
							       <td>오락실 게임 컨셉의 슈팅게임 입니다.<br><br>
							     일반 기술과 특수 기술이 있으며 빨간색 적을 처치 시 코인과 아이템을 드랍합니다.<br><br>
							     코인은 스코어를 올려주고 아이템은 각각 HP회복, MP회복, 기본공격 강화, 공격력 강화, 공격속도 증가의 효과가 있습니다.<br><br>
							   적은 가장 인접해있는 플레이어를 조준해 총을 발사하고 플레이어의 체력이 0이 되면 폭발합니다.</td>     
							    </tr>
							</table>
						</c:when>
						<c:when test="${param.index == 3}">     
							<div class="header">길 찾기</div>
							<table>
								<colgroup>
									<col width="30%">
								</colgroup>
							    <tr>
							       <td scope="col">개발기간</td>
							       <td>3일</td>   
							    </tr>
							    <tr>   
							       <td>단위</td>  
							       <td>팀(맡은 역할 : 개발)</td>       
							    </tr>
							    <tr>
							       <td>사용 언어</td>
							       <td>JAVA</td>    
							    </tr>
							    <tr>
							       <td>배포여부</td>
							       <td>X</td>    
							    </tr>
							    <tr>   
							       <td>설명</td>
							       <td>배열과 스택을 이용한 간단한 길찾기 프로그램입니다.<br><br>
							       좌선법, 우선법, 깊이우선탐색법 알고리즘을 사용했으며, 좌선법은 한쪽 방향으로 이동하다
							       벽을 마주하게 되면 무조건 왼쪽으로만 이동하고 우선법은 그 반대입니다.<br><br>
							       깊이우선탐색법은 출발 전 더 이상 길이 없을때까지 전진하다 막다른길이 있으면
							       가장 최근의 갈림길까지 스택에 저장된 좌표를 빼냅니다.<br><br>
							       이걸 반복하면 언젠가 출구에 다다르고 그때 캐릭터를 스택에 저장된 경로대로 이동만 시켜줍니다.<br><br></td>     
							    </tr>
							</table>
						</c:when>
					</c:choose>
				</div>
			</div>	
		</div>
	<jsp:include page="Copyright.jsp"></jsp:include>
</body>
<script>
	$(document).ready(function() {
		var i = <%=request.getParameter("index")%>;
		
		$('.sub_menu_slide li:eq('+ i +')').addClass('on');
	})
</script>
</html>
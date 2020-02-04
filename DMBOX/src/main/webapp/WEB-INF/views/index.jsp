<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<!--
Design by TEMPLATED
http://templated.co
Released for free under the Creative Commons Attribution License

Name       : WellFormed 
Description: A two-column, fixed-width design with dark color scheme.
Version    : 1.0
Released   : 20130731

-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<meta name="description" content="" />
</head>
<body>
	<%
		Cookie cookie = new Cookie("Tap_menu", "0");
		response.addCookie(cookie);     
	%>
	<jsp:include page="Banner.jsp"></jsp:include>
	<div id="banner" class="container">
		<div id="banner1">
			<div>
				<c:forEach items="${list}" var="boxoffice" varStatus="status">
					<ul>
						<li>
							<div class="rank1">
								<span style="font-weight: bold; font-style: italic; font-size: 20px;">${status.count}.</span>
							</div>
							<div class="rank2">
								<img src="${pageContext.request.contextPath}/resources/images/${boxoffice.grade}.png"
									style="width: 20px; height: 20px; vertical-align: middle;" />
							</div>
							<div class="rank3">     
								<a href="#" class="rank3_a" style="font-weight: bold; color: white;">${boxoffice.movie_name}</a>
								<div class="rank3_b">
									<img src="${boxoffice.height_poster}"></img>
								</div>
							</div>
							<div class="rank4">
								<div>
									<span style="font-size: 12px; font-weight: bold;">예매율  </span>
								</div>
								<div style="margin-left:9px;">
									<span style="font-size: 14px; color: #fc3f27; line-height: 30px; vertical-align: middle; font-weight: bold;">${boxoffice.ticketing}%</span>
								</div>
							</div>
						</li>
					</ul>
				</c:forEach>
			</div>
		</div>
		<div id="banner2">
			<div id="myCarousel" class="carousel slide" data-ride="carousel">
				<!-- Indicators -->
				<ol class="carousel-indicators">
					<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
					<li data-target="#myCarousel" data-slide-to="1"></li>
					<li data-target="#myCarousel" data-slide-to="2"></li>
					<li data-target="#myCarousel" data-slide-to="3"></li>
					<li data-target="#myCarousel" data-slide-to="4"></li>
					<li data-target="#myCarousel" data-slide-to="5"></li>
					<li data-target="#myCarousel" data-slide-to="6"></li>
					<li data-target="#myCarousel" data-slide-to="7"></li>
					<li data-target="#myCarousel" data-slide-to="8"></li>
					<li data-target="#myCarousel" data-slide-to="9"></li>
				</ol>

				<!-- Wrapper for slides -->
				<div class="carousel-inner" role="listbox">
					<div class="item active">
						<img
							src="${list[0].width_poster}"
							alt="1.jpg" width="900" height="500"
							class="width_img"/>
						<div class="item_text">
							<p class="ticket_text">예매 1위</p>
							<p class="ticket_value">${list[0].ticketing}%</p>
							<p class="title">${list[0].movie_name}</p>
							<p class="eng_title">${list[0].movie_eng_name}</p>
						</div>
					</div>
					<c:forEach items="${list}" var="list" varStatus="status" begin="1">
						<div class="item">
							<img
								src="${list.width_poster}"
								alt="${list.width_poster}" width="900" height="500"
								class="width_img" />
							<div class="item_text">
								<p class="ticket_text">예매 ${status.count+1}위</p>
								<p class="ticket_value">${list.ticketing}%</p>
								<p class="title">${list.movie_name}</p>
								<p class="eng_title">${list.movie_eng_name}</p>
							</div>
						</div>
					</c:forEach>
				</div>

				<!-- Left and right controls -->
				<a class="left carousel-control" href="#myCarousel" role="button"
					data-slide="prev"> <span
					class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
					<span class="sr-only">Previous</span>
				</a> <a class="right carousel-control" href="#myCarousel" role="button"
					data-slide="next"> <span
					class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
					<span class="sr-only">Next</span>
				</a>
			</div>
		</div>
	</div>
	<div id="page" class="container">
		<div id="content">
			<div class="title">
				<div>
					<h2>
						Welcome <span class="byline">to kim-dongmin portfolio</span> 
					</h2>				
				</div>
				<div id="all_profile">
					<ul id="profile">    
						<li><img id="profile_img" 
							src="${pageContext.request.contextPath}/resources/images/profile.jpg"
							alt="" /></li>							
					</ul>
					<ul id="profile_text">
						<li><h2><p><strong>김 동 민</strong></p></h2></li>
						<li><p>Back-end Developer(신입)</p></li>
						<li><p>1993년 7월 17일</p></li>
						<li><p>경상북도 경산시 옥곡동</p></li>
						<li><p>010-5114-7688</p></li>
						<li><p>kdm1993@naver.com</p></li>
					</ul>   
				</div>
				<div>  
					<p>프로그래밍을 처음 접했을때 생소한 개념들 때문에 혼란스러웠지만, 
					익숙해지고 나니 내가 생각하는 대로 구현할 수 있는 프로그래밍이 굉장히 매력적으로 
					다가왔고 태어나서 처음으로 무언가를 배우는 것에 재미를 느꼈습니다. 제어문을 이용해서
					 책의 예제들을 풀때는 학창 시절 시험 문제집을 푸는게 아니라 잘 만들어진 퍼즐 게임을 하는 느낌을 받았습니다. 
					이러한 경험들이 제가 개발자로 진로를 굳히게 된 계기들이 되었습니다.</p>			
				</div>
			</div>  
		</div>
		<div id="sidebar">
			<ul class="style2">  
				<li class="first">  
					<h3>
						<a href="#">Education</a>
					</h3>
					<p>국가평생교육진흥원 학점은행, 컴퓨터공학사(졸업예정)</p>
					<p>2017.12.21 ~ 2020.02.25</p>
					<p>경북산업직업전문학교 응용 SW 엔지니어링 실무과정 수료</p>
					<p>2019.07.05 ~ 2019.12.09</p>      
				</li>
				<li>
					<h3> 
						<a href="#">Certification</a>
					</h3>  
					<p>정보처리기사	</p>
					<p>사무자동화산업기사</p>
					<p>네트워크 관리사 2급</p>
				</li>
			</ul>
		</div>
	</div>  
	<div id="three-column" class="container circle">  
		<div class="title" style="margin-top:30px; margin-left:30px;">   
			<h2>
				<span class="byline">Personal Project</span>     
			</h2>				
		</div>
		<div id="tbox1">    
			<h2>아구몬 어드벤처</h2>
			<img class="tbox_img" src="${pageContext.request.contextPath}/resources/images/agumon.jpg"></img>
			<a href="Project?index=1" class="button">자세히보기</a>
		</div>
		<div id="tbox2">
			<h2>슈팅 게임</h2>
			<img class="tbox_img" src="${pageContext.request.contextPath}/resources/images/shooting.png"></img>
			<a href="Project?index=2" class="button">자세히보기</a>  
		</div>
		<div id="tbox3">
			<h2>길 찾기</h2>
			<img class="tbox_img" src="${pageContext.request.contextPath}/resources/images/miro.png"></img>
			<a href="Project?index=3" class="button">자세히보기</a>
		</div>
	</div>  
	<jsp:include page="Copyright.jsp"></jsp:include>
	<script>
		$(document).ready(function() {
			$('.carousel').carousel({
				interval : 4000
			})
			
			$('.rank3_a').mouseover(function(event) {
				var i = $('.rank3_a').index(this);
				x = event.clientX;
				y = event.clientY + $(window).scrollTop();
				
				$('.rank3_b:eq('+ i +')').css('left', x + 'px');
				$('.rank3_b:eq('+ i +')').css('top', y + 'px');
				$('.rank3_b:eq('+ i +')').css('z-index', '100');
				$('.rank3_b:eq('+ i +')').show();
			})
			
			$('.rank3_a').mouseleave(function(event) {
				var i = $('.rank3_a').index(this);
				
				$('.rank3_b:eq('+ i +')').hide();
			})
			
			$('.rank3_a').click(function(event) {
				var i = $('.rank3_a').index(this);
				
				$('.carousel').carousel(i);
			})
			
			$('.button').click(function(event) {		
				var allcookies = document.cookie;
				   cookiearray  = allcookies.split(';');

				   for(var x=0; x<cookiearray.length; x++){
					  if(cookiearray[x].split('=')[0] == 'Tap_menu') {  
					      value = cookiearray[x].split('=')[1];
					      document.cookie = "Tap_menu=3;";   
					  }
				   }
			})	
		});
	</script>
</body>
</html>

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
	<div id="three-column" class="container">
		<div id="tbox1">
			<h2>Maecenas luctus</h2>
			<p>Nullam non wisi a sem semper eleifend. Donec mattis libero
				eget urna. Duis pretium velit ac mauris. Proin eu wisi suscipit
				nulla suscipit interdum.</p>
			<a href="#" class="button">Learn More</a>
		</div>
		<div id="tbox2">
			<h2>Integer gravida</h2>
			<p>Proin eu wisi suscipit nulla suscipit interdum. Nullam non
				wisi a sem semper eleifend. Donec mattis libero eget urna. Duis
				pretium velit ac mauris.</p>
			<a href="#" class="button">Learn More</a>
		</div>
		<div id="tbox3">
			<h2>Praesent scelerisque</h2>
			<p>Donec mattis libero eget urna. Duis pretium velit ac mauris.
				Proin eu wisi suscipit nulla suscipit interdum. Nullam non wisi a
				sem semper eleifend.</p>
			<a href="#" class="button">Learn More</a>
		</div>
	</div>
	<div id="page" class="container">
		<div id="content">
			<div class="title">
				<h2>
					Welcome <span class="byline">to our website</span>
				</h2>
			</div>
			<a href="#" class="image image-full"><img
				src="${pageContext.request.contextPath}/resources/images/pic02.jpg"
				alt="" /></a>
			<p>
				This is <strong>WellFormed</strong>, a free, fully
				standards-compliant CSS template designed by <a
					href="http://templated.co" rel="nofollow">TEMPLATED</a>. The photos
				in this template are from <a href="http://fotogrph.com/">
					Fotogrph</a>. This free template is released under the <a
					href="http://templated.co/license">Creative Commons Attribution</a>
				license, so you're pretty much free to do whatever you want with it
				(even use it commercially) provided you give us credit for it. Have
				fun :)
			</p>
		</div>
		<div id="sidebar">
			<h2 class="title">Mauris vulputate</h2>
			<ul class="style2">
				<li class="first">
					<h3>
						<a href="#">Maecenas luctus lectus</a>
					</h3>
					<p>
						<a href="#">Quisque dictum integer nisl risus, sagittis
							convallis, rutrum id, congue, and nibh.</a>
					</p>
				</li>
				<li>
					<h3>
						<a href="#">Integer gravida nibh</a>
					</h3>
					<p>
						<a href="#">Quisque dictum integer nisl risus, sagittis
							convallis, rutrum id, congue, and nibh.</a>
					</p>
				</li>
				<li>
					<h3>
						<a href="#">Nulla luctus eleifend</a>
					</h3>
					<p>
						<a href="#">Quisque dictum integer nisl risus, sagittis
							convallis, rutrum id, congue, and nibh.</a>
					</p>
				</li>
			</ul>
		</div>
	</div>
	<div id="footer" class="container">
		<div id="fbox1">
			<h2 class="title">Praesent mattis</h2>
			<p>Pellentesque viverra vulputate enim. Aliquam erat volutpat.
				Pellentesque tristique ante ut risus. Quisque dictum. Integer nisl
				risus, sagittis convallis, rutrum id, elementum congue, nibh.
				Suspendisse dictum porta lectus.</p>
			<a href="#" class="button">Learn More</a>
		</div>
		<div id="fbox2">
			<h2 class="title">Praesent condimentum</h2>
			<ul class="style1">
				<li class="first"><a href="#">Pellentesque consectetuer
						gravida blandit.</a></li>
				<li><a href="#">Lorem consectetuer adipiscing elit.</a></li>
				<li><a href="#">Maecenas vitae vitae feugiat eleifend.</a></li>
			</ul>
			<a href="#" class="button">Learn More</a>
		</div>
		<div id="fbox3">
			<h2 class="title">Social</h2>
			<ul class="style1">
				<li class="first"><a href="#">Twitter</a></li>
				<li><a href="#">Facebook</a></li>
				<li><a href="#">Flickr</a></li>
				<li><a href="#">Google +</a></li>
			</ul>
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
		});
	</script>
</body>
</html>

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>오개팅</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/fiveTing/css/main.css" type="text/css" />
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon" rel="stylesheet">
</head>

<body>
<jsp:include page="/fiveTing/header.jsp" flush="false"/>

		<section id="banner">
		<header> </header>
		</section>
		

			<!-- Main -->
				<section id="main">
					<div class="container">
						<div class="row">
							<div class="col-12" align="center">

								<!-- Portfolio -->
									<section>
										<div class="row">
											<div class="col-4 col-6-medium col-12-small">
												<section class="box">
													<img src="${pageContext.request.contextPath}/fiveTing/image/main1.JPG"
													style="width: 384"; height="264">
													<header>
														<h3 align="center">회원 평균 신장</h3>
													</header>
												</section>
											</div>
											<div class="col-4 col-6-medium col-12-small">
												<section class="box">
													<img src="${pageContext.request.contextPath}/fiveTing/image/main2.JPG"
													style="width: 384"; height="264">
													<header>
														<h3 align="center">회원 평균 학력</h3>
													</header>
												</section>
											</div>
											<div class="col-4 col-6-medium col-12-small">
												<section class="box">
													<img src="${pageContext.request.contextPath}/fiveTing/image/main3.JPG"
													style="width: 384"; height="264">
													<header>
														<h3 align="center">회원 평균 연봉</h3>
													</header>
												</section>
											</div>
											<div class="col-4 col-6-medium col-12-small">
												<section class="box">
													<img src="${pageContext.request.contextPath}/fiveTing/image/main4.JPG"
													style="width: 384"; height="264">
													<header>
														<h3 align="center">매칭 성사율</h3>
													</header>
												</section>
											</div>
											<div class="col-4 col-6-medium col-12-small">
												<section class="box">
													<img src="${pageContext.request.contextPath}/fiveTing/image/main5.JPG"
													style="width: 384"; height="264">
													<header>
														<h3 align="center">거주지역</h3>
													</header>
												</section>
											</div>
											<div class="col-4 col-6-medium col-12-small">
												<section class="box">
													<img src="${pageContext.request.contextPath}/fiveTing/image/main6.jpg"
													style="width: 384"; height="264">
													<header>
														<h3 align="center">남여 비율</h3>
													</header>
												</section>
											</div>
										</div>
									</section>
									
									<footer>
								<ul class="actions">
									
									<c:if test="${!empty sessionScope.MemberInfo.id}">
									</c:if>
									<c:if test="${empty sessionScope.MemberInfo.id}">
									<li><a href="${pageContext.request.contextPath}/five/joinMember.do" class="button large" 
									style="vertical-align: middle;">join</a></li>
									</c:if>
								</ul>
							</footer>
							</div>

							</div>
						</div>
					</div>
				</section>

			<!-- Footer -->
				<section id="footer">
					<div class="container">
						<div class="row">							
							<div class="col-4 col-6-medium col-12-small">
								<section>
									<header>
										<h2>Introduce</h2>
									</header>
									<ul class="divided">
										<li>Oh Gating is a place for those who want to have love<br/>
										 	for both young and old.<br/>
											It is hard to meet new people with busy daily life<br/>
											If you want to meet but do not know <br/>
											where to meet People around you are overburdened
											We will provide you with a symbol to meet <br/>
											 new people.<br/>
											A new relationship, not alone, boyfriend, girlfriend Anyone can be "together"</li>
									</ul>
								</section>
							</div>
							<div class="col-4 col-6-medium col-12-small">
								<section>
									<header>
										<h2>Partner</h2>
									</header>
									<ul class="divided">
										<li><a href="http://www.kodachaya.com/home/intro.html">Kodachaya</a></li>
										<li><a href="http://www.panasia-food.com/">Panasia</a></li>
										<li><a href="http://mies-container.com/">MIES_container</a></li>
										<li><a href="http://www.seogaandcook.com">Seogaandcook</a></li>
										<li><a href="http://ontheborder.co.kr">Ontheborder</a></li>
									</ul>
								</section>
							</div>
							<div class="col-4 col-12-medium">
								<section>
									<header>
										<h2>오개팅</h2>
									</header>
									<ul class="social">
										<li><img src="${pageContext.request.contextPath}/fiveTing/image/facebook.png" width="40" height="40"></li>
										<li><img src="${pageContext.request.contextPath}/fiveTing/image/twitter.png" width="40" height="40"></li>
										<li><img src="${pageContext.request.contextPath}/fiveTing/image/instargram.png" width="40" height="40"></li>
									</ul>
									<ul class="contact">
										<li>
											<h3>Address</h3>
											<p>아이티윌 6강의실
											</p>
										</li>
										<li>
											<h3>Mail</h3>
											<p><a href="#">55555@55.555</a></p>
										</li>
										<li>
											<h3>Phone</h3>
											<p>(02) 000-0000</p>
										</li>
									</ul>
								</section>
							</div>
							<div class="col-12">

								<!-- Copyright -->
									<div id="copyright">
										<ul class="links">
											<li>&copy; Untitled. All rights reserved.</li>
											<li>Made by Team 5</a></li>
										</ul>
									</div>

							</div>
						</div>
					</div>
				</section>

		<!-- Scripts -->
		<script src="${pageContext.request.contextPath}/fiveTing/js/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/fiveTing/js/jquery.dropotron.min.js"></script>
		<script src="${pageContext.request.contextPath}/fiveTing/js/browser.min.js"></script>
		<script src="${pageContext.request.contextPath}/fiveTing/js/breakpoints.min.js"></script>
		<script src="${pageContext.request.contextPath}/fiveTing/js/util.js"></script>
		<script src="${pageContext.request.contextPath}/fiveTing/js/main.js"></script>
	</body>
</html>
<%@page import="com.util.MyUtil"%>
<%@page import="com.fiveTing.RestaurantDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.fiveTing.FiveTingDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.net.URLDecoder"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String cp = request.getContextPath();
	
	Connection conn = DBConn.getConnection();
	FiveTingDAO dao = new FiveTingDAO(conn);

	MyUtil myUtil = new MyUtil();
	String deleteUrl = cp+"/five/delete.do";
	//client한테 넘어온 페이지 번호
	String pageNum = request.getParameter("pageNum");
	
	int currentPage = 1;
	
	//처음실행시 null
	if(pageNum!=null)
		currentPage = Integer.parseInt(pageNum); 
	
	//전체데이터구하기
	int dataCount = dao.getDataCountRes();
	
	//전체 데이터를 기준으로 총 페이지수 계산
	int numPerPage = 5;
	int totalPage =
	myUtil.getPageCount(numPerPage, dataCount);
	
	//삭제로 인해 전체페이지수보다 표시할 페이지수가 큰경우 페이지조절
	if(currentPage>totalPage)
		currentPage=totalPage;
	
	//데이터베이스에서 가져올 시작과 끝위치 
	int start = (currentPage-1)*numPerPage+1;
	int end = currentPage*numPerPage;
	
	List<RestaurantDTO> lists = dao.getLists(start,end);
	
	
	//페이징 처리
	String listUrl = "restaurant.do";
	String pageIndexList =
	myUtil.pageIndexList(currentPage, totalPage, listUrl);
	
	
	DBConn.close();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>제휴 음식점</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/fiveTing/css/main.css" type="text/css" />
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript">
	function showAddResPopup(){
		var popOption = "width=550, height=720, left=700, top=200, resizable=no, scrollbars=no";
		window.open("addResPopup.do","", popOption);
	}
</script>
</head>
<body class="homepage is-preload">
<jsp:include page="/fiveTing/header.jsp" flush="false"/>
	
<form name="RestaurantForm" method="post" action="">
<!-- admin 작성 -->
<table align="center" style="padding-right: 160px">
	<tr>
		<c:if test="${sessionScope.MemberInfo.id eq 'admin'}">
		<td colspan="3" style="padding-left: 100px;">
		<input type="image" src="${imagePath }/button/btn_add.png" onclick="showAddResPopup();"/>
		</td>
		</c:if>

		<c:if test="${sessionScope.MemberInfo.id ne 'admin'}">
		<td colspan="3" style="padding-left: 100px;">
		</td>
		</c:if>

		
	</tr>
</table>
<!-- end  -->
<br/><br/><br/><br/>
<!-- 리스트 출력 -->
		<table border="0" align="center" cellspacing="5">
			<c:forEach items="${lists }" var="dto">
				<table border=0 width=900 height=230 cellspacing="0px" align="center">
					<tr>
						<td width=230 height=230>
							<img src="${imagePath }/restaurant/${dto.picture}" width=100% height=100%>
						</td>
						<td width=600>
							<table cellspacing="0px" border=0 width=100% height=100% style="font-size: 10pt;">
								<tr height=40% style="vertical-align: center;">
									<td colspan="2" width=15% style="text-align: right; vertical-align: top; padding-top: 17px">
									<b style="font-size: 47pt;">${dto.num }.</b></td>
									<td width=75% style="font-size: 29pt;">
										<table border=0 width=100%>
											<tr height=12><td></td></tr>
											<tr><td>&nbsp;${dto.name }</td></tr>
										</table>
									</td>
									<td width=10%><a href="${dto.homepage }"><img width=50 height=50 src="${imagePath }/icon/icon_homepage.png"></a></td>
								</tr>
								<tr height=20%>
									<td><img style="padding-right: 15px;" align="right" width=32 height=25 src="${imagePath }/icon/icon_location.png"/></td>
									<td colspan=3 style="color: #8c8c8c;font-size: 18pt;">${dto.address }</td>
								</tr>
								<tr height=30%>
									<td><img style="padding-right: 15px;" align="right" width=35 height=25 src="${imagePath }/icon/icon_content.png"/></td>
									<td colspan=2 style="font-size: 14pt;">${dto.content }</td>
								</tr>
								<tr height=10%>
									<td><img style="padding-right: 15px;" align="right" width=32 height=25 src="${imagePath }/icon/icon_phone.png"/></td>
									<td colspan=2 style="font-size: 14pt;">${dto.tel }</td>
									<!-- if admin -->
									<c:if test="${sessionScope.MemberInfo.id eq 'admin'}">
									<td align=right style="padding-right: 25px">
									<a href="<%=cp%>/five/deleteRes.do?num=${dto.num}&pageNum=${pageNum}">삭제</a>
									</td>
									</c:if>
									<c:if test="${sessionScope.MemberInfo.id ne 'admin'}">
									<td align=right style="padding-right: 25px">
									</td>
									</c:if>
									<!--  end -->
								<tr>
							</table>
						</td>
					</tr>
				</table>
				<br/>
				<hr align="center" width=45% style="background: #8c8c8c"/>
				<br/>
			</c:forEach>
		</table>
	
	<table align="center">
		<tr>
			<td style="font-size: 15pt;color: #000000;">${pageIndexList }</td>
		</tr>
	</table>
	<br/><br/><br/>
	</form>
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
<%@page import="com.util.MyUtil"%>
<%@page import="com.fiveTing.CustomInfoDTO"%>
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
	
	List<CustomInfoDTO> lists = dao.getListsCustomInfo(start, end);
	
	
	//페이징 처리
	String listUrl = "matching.do";
	String pageIndexList =
	myUtil.pageIndexList(currentPage, totalPage, listUrl);
	
	
	DBConn.close();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>매칭 회 리스트</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/fiveTing/css/main.css" type="text/css" />
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript">

function showScorePopup(){
	var popOption = "width=270, height=400, left=800, top=300, resizable=no, scrollbars=no";
	window.open("scorePopup.do","", popOption);
}
function showProfilePopup(m_id){
	
	var f = document.MatchingForm;	
	var popOption = "width=630, height=800, left=650, top=50, resizable=no, scrollbars=no";
	
	window.open("profileOther.do?m_id="+m_id,"", popOption);
}

</script>
</head>
<body>
<jsp:include page="/fiveTing/header.jsp" flush="false"/>
<form name="MatchingForm" method="post" >
<br/><br/><br/><br/>
<!-- 리스트 출력 -->
		<table align="center" cellspacing="5">
			<c:forEach items="${lists }" var="dto">
			<c:if test="${dto.id eq 'admin'}">
			<br/>
			</c:if>
			<c:if test="${dto.id ne 'admin'}">
				<table style="border: 1px solid #BDBDBD" width=500 height=350 cellspacing="0px" align="center">
					<tr height=150>
						<td width=10% style="vertical-align: top;">
							<img align="right" src="${imagePath }/profile/${dto.picture}" width=170 height=170>
						</td>
						<td width=70%>
							<table border=0>
								<tr>
									<td width=20></td>
									<td style="font-size: 10pt;text-align: center; color: #d52349;">name</td>
									<td width=18></td>
									<td style="font-size: 23pt;text-align: left;">${dto.name }</td>
								</tr>
								<tr height=15><td></td></tr>						
								<tr>
									<td width=18></td>
									<td style="font-size: 10pt;text-align: center;">age</td>
									<td width=18></td>
									<td style="font-size: 13pt;text-align: left;">${dto.age }</td>
								</tr>
								<tr><td></td></tr>
								<tr>
									<td width=18></td>
									<td style="font-size: 10pt;text-align: center;">sex</td>
									<td width=18></td>
									<td style="font-size: 13pt;text-align: left;">${dto.gender }</td>
								</tr>
								<tr>
									<td></td>
								</tr>
							</table>
						</td>
						<td width=20% style="text-align: center;">
						<c:if test="${!empty sessionScope.MemberInfo.id }">
							<img width=40 height=40 src="${imagePath }/icon/icon_profile.png" onclick="showProfilePopup('${dto.id }');" style="cursor:pointer" >
						</c:if>
						<c:if test="${empty sessionScope.MemberInfo.id }">
							<img width=40 height=40 src="${imagePath }/icon/icon_profile.png">
						</c:if>
						</td>
					</tr>
					<tr style="height: 1px;">
						<td colspan="3"><hr align="center" width=250 style="background: #8c8c8c"/></td>
					</tr>
					<tr height=150>
						<td width="5%" style="vertical-align: top;">
							<img style="padding-top: 14px; padding-right: 15px;" align="right" width=40 height=40 src="${imagePath }/icon/icon_introduce.png"/>
						</td>
						<td style="vertical-align: top;">
							<table border=0 cellspacing=0px cellpadding=0px>
								
								<tr>
									<td colspan="2" style="text-align: left;vertical-align: top;padding: 10px;">
									${dto.content }
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				</c:if>
				<br/>
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
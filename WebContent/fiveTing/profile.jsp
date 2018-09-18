<%@page import="com.fiveTing.CustomInfoDTO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.fiveTing.FiveTingDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=cp%>/fiveTing/js/profile.js"></script>
<script type="text/javascript">
	function showAddResPopup(){
		var popOption = "width=700, height=800, left=650, top=50, resizable=no, scrollbars=no";
		window.open("<%=cp %>/five/maPopup.do?id=${sessionScope.MemberInfo.id }","", popOption);
	}
	</script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/fiveTing/css/main.css" type="text/css" />
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon" rel="stylesheet">
<title>My Profile</title>
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/fiveTing/css/main.css" type="text/css" />
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon" rel="stylesheet">
<body>
<jsp:include page="/fiveTing/header.jsp" flush="false"/>

<br/>
<table width="600" border="0" cellpadding="0" cellspacing="0" align="center">
	<tr height="40">
		<td style="font-size: 40pt; text-align: center; color: #000000">
		Profile
		</td>
	</tr>
</table>
<hr width="100" color="#d52349" align="center"/>
<hr width="50" color="#d52349" align="center"/>
<p><br/></p>
<form action="" name="ProfileForm" method="post" enctype="multipart/form-data">
<table border="0" width="500" cellspacing="0" cellpadding="1" align="center" style="text-align: left; font-size: 10pt;">
	<tr>
		<td width="150" height="150">
			<img border="0" src="${imagePath }/profile/${picture }" width="150" height="150" style="border-color: #d52349;"/>
		</td>
		<td style="padding-left: 80pt">
			<table style="padding-left: 25pt;border-color: #d52349;" cellpadding="5px" align="left">
				<tr>
					<td width="80px" style="text-align: right; font-size: 17px"><p1>NAME </p1></td>
					<td width="10px"></td>
					<td style="font-size: 20px">${name }</td>
					
				</tr>
				<tr>
					<td width="80px" style="text-align: right; font-size: 17px"><b>SEX </b></td>
					<td width="10px"></td>
					<td>${gender }</td>
				</tr>
				<tr>
					<td width="80px" style="text-align: right; font-size: 17px"><b>AGE </b></td>
					<td width="10px"></td>
					<td>${age }</td>
				</tr>
			</table>
		</td>
	</tr>
	</table>
	
	<table border="0" width="500" cellspacing="0" cellpadding="1" align="center" style="text-align: left; font-size: 10pt;">
	<tr>
		<td width="150" height="150" style="text-align: center; font-size: 13pt;">
			Detail
		</td>
		<td style="padding-left: 80pt">
			<table style="padding-left: 25pt;border-color: #d52349;" cellpadding="5px" align="left">
				<tr>
					<td width="80px" style="text-align: right; font-size: 17px"><b>ID </b></td>
					<td width="10px"></td>
					<td style="font-size: 20px">${id }</td>
					
				</tr>
				<tr>
					<td width="80px" style="text-align: right; font-size: 17px"><b>JOB </b></td>
					<td width="10px"></td>
					<td>${job }</td>
				</tr>
				<tr>
					<td width="80px" style="text-align: right; font-size: 17px"><b>ADDRESS </b></td>
					<td width="10px"></td>
					<td>${address }</td>
				</tr>
				<tr>
					<td width="80px" style="text-align: right; font-size: 17px"><b>HEIGHT </b></td>
					<td width="10px"></td>
					<c:if test="${height eq '1' }">
					<td>150이하</td>
					</c:if>
					<c:if test="${height eq '2' }">
					<td>151-155</td>
					</c:if>
					<c:if test="${height eq '3' }">
					<td>156-160</td>
					</c:if>
					<c:if test="${height eq '4'}">
					<td>161-165</td>
					</c:if>
					<c:if test="${height eq '5' }">
					<td>166-170</td>
					</c:if>
					<c:if test="${height eq '6' }">
					<td>170-175</td>
					</c:if>
					<c:if test="${height eq '7' }">
					<td>176-180</td>
					</c:if>
					<c:if test="${height eq '8' }">
					<td>181-185</td>
					</c:if>
					<c:if test="${height eq '9' }">
					<td>186이상</td>
					</c:if>
				</tr>
				<tr>
					<td width="80px" style="text-align: right; font-size: 17px"><b>BODY </b></td>
					<td width="10px"></td>
					<c:if test="${body eq 's' }">
					<td>마름</td>
					</c:if>
					<c:if test="${body eq 'm' }">
					<td>보통</td>
					</c:if>
					<c:if test="${body eq 'l' }">
					<td>통통</td>
					</c:if>
					<c:if test="${body eq'xl' }">
					<td>뚱뚱</td>
					</c:if>
				</tr>
				<tr>
					<td width="80px" style="text-align: right; font-size: 17px"><b>📞 </b></td>
					<td width="10px"></td>
					<td>${tel }</td>
				</tr>
				<tr>
					<td width="80px" style="text-align: right; font-size: 17px"><b>FACE </b></td>
					<td width="10px" style="font-size: 17px"></td>
					<c:choose>
						<c:when test="${score >= 80}">
							<td>완벽</td>
						</c:when>
						<c:when test="${score >= 60}">
							<td>훈훈</td>
						</c:when>
						<c:when test="${score >= 40}">
							<td>평범</td>
						</c:when>
						<c:when test="${score >= 20}">
							<td>못남</td>
						</c:when>
						<c:otherwise>
							<td>절망</td>
						</c:otherwise>
					</c:choose>
				</tr>
			</table>
		</td>
	</tr>
	</table>
	
	
	<%-- <tr><td height="10"></td></tr>
	<tr height="10px">
		<td></td>
	</tr>
	<tr>
		<td width="150" height="150" style="text-align: center; font-size: 13pt;">
			Detail
		</td>
		<td style="padding-left: 80pt">
			<table border="0" cellpadding="5px" align="left" style="text-align: cente">
				<tr>
					<td style="text-align: right; font-size: 17px"><b>ID </b></td>
					<td width="10px"></td>
					<td>${id }</td>
				</tr>
				<tr>
					<td style="text-align: right; font-size: 17px"><b>JOB </b></td>
					<td width="10px"></td>
					<td>${job }</td>
				</tr>
				<tr>
					<td style="text-align: right; font-size: 17px"><b>Address </b></td>
					<td width="10px"></td>
					<td>${address }</td>
				</tr>
				<tr>
					<td style="text-align: right; font-size: 17px"><b>Height </b></td>
					<td width="10px"></td>
					<td>${height }</td>
				</tr>
				<tr>
					<td style="text-align: right; font-size: 17px"><b>Body Shape </b></td>
					<td width="10px"></td>
					<td>${body }</td>
				</tr>
				<tr>
					<td style="text-align: right; font-size: 17px"><b>📞 </b></td>
					<td width="10px"></td>
					<td>${tel }</td>
				</tr>
				<tr>
					<td style="text-align: right; font-size: 17px"><b>Face </b></td>
					<td width="10px"></td>
					<c:choose>
						<c:when test="${score >= 80}">
							<td>완벽</td>
						</c:when>
						<c:when test="${score >= 60}">
							<td>훈훈</td>
						</c:when>
						<c:when test="${score >= 40}">
							<td>평범</td>
						</c:when>
						<c:when test="${score >= 20}">
							<td>못남</td>
						</c:when>
						<c:otherwise>
							<td>절망</td>
						</c:otherwise>
					</c:choose>
				</tr>
			</table>
		</td>
	</tr>
</table> --%>
<hr width="500"/>
<table width="500" border="0" cellpadding="5px" align="center">
	<tr>
		<td width="150" height="150" style="text-align: center; font-size: 13pt;">
			Content</td>
		<td width="10">
		</td>
		<td style="padding-left: 10pt">
			<table width=200 border="0" style="font-size: 10pt; text-align: right;">
				<tr>
					<td>
						${content }
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</form>
<br/>
<table align="center">
	<tr>
		<td align="center">
		<img src="${imagePath }/button/btn_edit.png" 
		onclick="javascript:location.href='updateMember.do';" style="cursor:pointer"/>
		<img src="${imagePath }/button/btn_friend.png" 
		onclick="showAddResPopup();" style="cursor:pointer"/>
		<img src="${imagePath }/button/btn_out.png" 
		onclick="javascript:location.href='${pageContext.request.contextPath}/fiveTing/survey.jsp';" style="cursor:pointer"/>
		</td>
	</tr>
</table>

<br/><br/>

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

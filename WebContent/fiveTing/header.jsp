<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<body class="homepage is-preload">
	<div id="page-wrapper">

		<!-- Header -->
		<section id="header">
			<h1 style="font-size: 80px">
				<a href="<%=cp%>/five/index.do">오&nbsp;&nbsp;개&nbsp;&nbsp;팅</a>
			</h1>

			<!-- Nav -->
			<nav id="nav">
				<ul>
					<c:choose>
							<c:when test="${empty sessionScope.MemberInfo.id }">
								<li class="current"><a href="<%=cp%>/five/loginMember.do" style="font-size: 22px">로그인</a></li>
							</c:when>
							<c:otherwise>
								<li class="current"><a href="<%=cp%>/five/profile.do" style="font-size: 22px">마이페이지</a></li>
								<li class="current"><a href="<%=cp%>/five/logoutMember.do" style="font-size: 22px">로그아웃</a></li>
							</c:otherwise>
						</c:choose>
					<li><a href="<%=cp%>/five/matching.do" style="font-size: 22px">매칭</a></li>
					<li><a href="#" style="font-size: 22px">제휴</a>
						<ul>
							<li><a href="<%=cp%>/five/restaurant.do" style="font-size: 22px">음식점</a></li>
							<li><a href="<%=cp%>/five/datePlace.do"" style="font-size: 22px">데이트장소</a></li>
						</ul></li>
					<li><a href="<%=cp%>/five/list.do" style="font-size: 22px">후기게시판</a></li>
					<li><a href="#" style="font-size: 22px">서비스</a>
						<ul>
							<li><a href="<%=cp%>/five/service.do" style="font-size: 22px">사이트소개</a></li>
							<li><a href="<%=cp%>/five/soge.do" style="font-size: 22px">5조소개</a></li>
						</ul></li>
					<li><a href="#" style="font-size: 22px">고객센터</a>
						<ul>
							<li><a href="<%=cp%>/five/qna.do" style="font-size: 22px">자주묻는질문</a></li>
							<li><a href="<%=cp%>/five/qnaEmail.do" style="font-size: 22px">Q&A</a></li>
						</ul></li>
				</ul>
			</nav>
		</section>
	</div>
</body>

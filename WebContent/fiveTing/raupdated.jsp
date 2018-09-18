<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>오개팅</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/fiveTing/css/main.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/fiveTing/css/login.css" type="text/css" />
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon" rel="stylesheet">
<script type="text/javascript">

	function sendIt() {
	   
		f = document.myForm;
	
		str = f.subject.value;
		str = str.trim();
	    if(!str) {
	        alert("\n제목을 입력하세요. ");
	        f.subject.focus();
	        return;
	    }
		f.subject.value = str;
	
	    str = f.name.value;
		str = str.trim();
	    if(!str) {
	        alert("\n이름을 입력하세요. ");
	        f.name.focus();
	        return;
	    }
	    f.name.value = str;
	
	    
	    
	    
		str = f.content.value;
	    str = str.trim();
	    if(!str) {
	        alert("내용을 입력하세요. ");
	        f.content.focus();
	        return;
	    }
		f.content.value = str;
			
	    f.action = "${pageContext.request.contextPath}/five/raupdated_ok.do";
	    f.submit();
	}
	
	function reset(){
		
		f = document.myForm;
		
		f.reset;
		
	}

</script>
</head>
<body class="homepage is-preload">
<jsp:include page="/fiveTing/header.jsp" flush="false"/>		
		
	<!-- Form --> 
	<div class="content" align="center">

		<form  method="post" name="myForm" enctype="multipart/form-data">
			<div class="fields">
				<div class="field half">
					<label for="name" style="text-align: left; font-size: 18px">제목</label> 
					<input type="text" name="subject" value="${revdto.subject }"/>

				</div>
				<div class="field half">
					<label for="name" style="text-align: left; font-size: 18px">이름</label> 
					<input type="text" name="name"  value="${revdto.name}<%-- ${sessionScope.customInfo.name } --%>" />
				</div>
				<%-- <div class="field">
					<label for="name" style="text-align: left; font-size: 18px">사진</label> 
					<input type="file" name="picture" value="${revdto.picture }" ${sessionScope.customInfo.name } />
				</div> --%>
				<div class="field">
					<label for="name" style="text-align: left; font-size: 18px">내용</label>
					<textarea name="content" rows="6">${revdto.content }</textarea>
				</div>
			</div>

		<input type="hidden"  name="score" value="0"><br />
		<input type="hidden"  name="num" value="${revdto.num }"><br />
		<%-- <input type="hidden" name="id" value="${sessionScope.customInfo.id }-나중에수정<%=id %>" /> --%>
		
		<img src="${pageContext.request.contextPath}/fiveTing/image/send.png" onclick="sendIt();" />
		<img src="${pageContext.request.contextPath}/fiveTing/image/btn_reset.png" onclick="reset();" />
		<a href="${pageContext.request.contextPath}/five/list.do?${params}">
		<img src="${pageContext.request.contextPath}/fiveTing/image/cancel.png"></a>
		</form>
	</div>

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
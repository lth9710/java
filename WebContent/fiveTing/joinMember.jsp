<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	String id = (String)session.getAttribute("id");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 

"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/fiveTing/css/main.css" 

type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/fiveTing/css/login.css" 

type="text/css" />
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon" rel="stylesheet">
<script type="text/javascript">


function idid(){
	//dao를 통해서 search로 중복확인해서 하기.(포워딩할 필요가 없어짐)
	var f =document.myForm;

	if(!f.id.value){
		alert("아이디를 입력하세요")
		f.id.focus();
		return;
	}
	var str = f.id.value;

	f.action ="<%=cp%>/five/searchId_ok.do?id="+str;
	f.submit();

}
function sendId(){
	
	var f =document.myForm;
		
		if(!f.id.value){
			alert("아이디를 입력하세요")
			f.id.focus();
			return;
		}
		if(!f.pwd.value){
			alert("비밀번호를 입력하세요")
			f.pwd.focus();
			return;
		}
		if(!f.name.value){
			alert("이름을 입력하세요")
			f.name.focus();
			return;
		}
		if(!f.gender.value){
			alert("성별을 입력하세요")
			f.gender.focus();
			return;
		}
		if(!f.age.value){
			alert("나이를 입력하세요")
			f.age.focus();
			return;
		}
		if(!f.job.value){
			alert("직업을 입력하세요")
			f.job.focus();
			return
			;
		}
		if(!f.address.value){
			alert("주소를 입력하세요")
			f.address.focus();
			return;
		}
		if(!f.height.value){
			alert("키를 입력하세요")
			f.height.focus();
			return;
		}
		if(!f.body.value){
			alert("체형을 입력하세요")
			f.body.focus();
			return;
		}
		if(!f.tel.value){
			alert("전화번호를 입력하세요")
			f.tel.focus();
			return;
		}
		if(!f.picture.value){
			alert("사진을 첨부하세요")
			f.picture.focus();
			return;
		}
		if(!f.content.value){
			alert("자기소개를 입력하세요")
			f.content.focus();
			return;
		}
		
		f.action ="joinMember_ok.do"
		f.submit();
}

</script>
</head>
<body>
<jsp:include page="/fiveTing/header.jsp" flush="false"/>
<br/>
		
		<h3 align="center">회원가입</h3>
		
	<!-- Form --> 
	<div class="content" align="center">
		<form action="" method="post" name="myForm" enctype="multipart/form-data">

			<div class="fields">
			
			<div class="field half">
					<label for="name" style="text-align: left; font-size: 

20px">ID</label> 
					<input type="text" style="width: 150%" name="id" value="${messageid }"><br/>
					<b>${message }</b>
				</div>
				<div class="field half">
					<label for="name" style="text-align: left">&nbsp;</label> 
					<img align="right" src="${pageContext.request.contextPath}/fiveTing/image/btn_confirm.png" onclick="idid();">
				</div>
				<div class="field">
					<label for="name" style="text-align: left; font-size: 20px">

비밀번호</label> 
					<input type="password" name="pwd" value="" />
				</div>
			
			
				<div class="field half">
					<label for="name" style="text-align: left; font-size: 20px">

이름</label> 
					<input type="text" name="name" value=""/>
				</div>
				<div class="field half">
					<label for="name" style="text-align: left; font-size: 20px 

">나이</label> 
					<input type="text" name="age" value="" />
				</div>
				<div class="field third">
					<label for="name" style="text-align: left; font-size: 20px">

성별</label>
				</div>
				<div class="field third">
					<input type="radio" id="priority-low" name="gender" value="남자" />
					<label for="priority-low" style="font-size: 

20px">남자</label>
				</div>
				<div class="field third">
					<input type="radio" id="priority-normal" name="gender" value="여자" />
					<label for="priority-normal" style="font-size: 

20px">여자</label>
				</div>
				<div class="field">
					<label for="name" style="text-align: left; font-size: 20px">

직업</label> 
					<input type="text" name="job" value="" />
				</div>
				<div class="field">
					<label for="name" style="text-align: left; font-size: 20px">

주소</label> 
					<input type="text" name="address" value="" />
				</div>
				
				<div class="field half">
					<label for="name" style="text-align: left; font-size: 20px">

키</label>
					<select name="height" value="">
					<option value="">- 선택하세요 -</option>
					<option value="1">150이하</option>
					<option value="2">151-155</option>
					<option value="3">156-160</option>
					<option value="4">161-165</option>
					<option value="5">166-170</option>
					<option value="6">170-175</option>
					<option value="7">176-180</option>
					<option value="8">181-185</option>
					<option value="9">186이상</option>
					</select>
				</div>
				<div class="field half">
					<label for="name" style="text-align: left; font-size: 20px">

체형</label> 
					<select name="body" value="">
					<option value="">- 선택하세요 -</option>
					<option value="s">마름</option>
					<option value="m">보통</option>
					<option value="l">통통</option>
					<option value="xl">뚱뚱</option>
					</select>
				</div>
				<div class="field">
					<label for="name" style="text-align: left; font-size: 20px">

전화번호</label> 
					<input type="text" name="tel" value="" />
				</div>
				<div class="field">
					<label for="name" style="text-align: left; font-size: 20px">

사진</label>
					<input type="file" name="picture"><br/>
				</div>
				<div class="field">
					<label for="name" style="text-align: left; font-size: 20px">

소개</label>
					<textarea name="content" rows="6"></textarea>
				</div>
			</div>
	</div>

	<div align="center">
		<input type="hidden" border="1" name="score" value="0"><br />
		<img src="${pageContext.request.contextPath}/fiveTing/image/enrol.png" 

onclick="sendId();" />
		<a href="<%=cp %>/five/loginMember.do">
		<img src="${pageContext.request.contextPath}/fiveTing/image/cancel.png"/></a>
	</form>
	</div>
	</div>
	</section> 
	
	<br/><br/>

<!-- Footer -->
				<section id="footer">
					<div class="container">
						<div class="row">					

		
							<div class="col-4 col-6-medium col-12-

small">
								<section>
									<header>
										<h2>Introduce</h2>
									</header>
									<ul class="divided">
										<li>Oh Gating is a 

place for those who want to have love<br/>
										 	for both 

young and old.<br/>
											It is hard 

to meet new people with busy daily life<br/>
											If you want 

to meet but do not know <br/>
											where to 

meet People around you are overburdened
											We will 

provide you with a symbol to meet <br/>
											 new 

people.<br/>
											A new 

relationship, not alone, boyfriend, girlfriend Anyone can be "together"</li>
									</ul>
								</section>
							</div>
							<div class="col-4 col-6-medium col-12-

small">
								<section>
									<header>
										<h2>Partner</h2>
									</header>
									<ul class="divided">
										<li><a 

href="http://www.kodachaya.com/home/intro.html">Kodachaya</a></li>
										<li><a 

href="http://www.panasia-food.com/">Panasia</a></li>
										<li><a 

href="http://mies-container.com/">MIES_container</a></li>
										<li><a 

href="http://www.seogaandcook.com">Seogaandcook</a></li>
										<li><a 

href="http://ontheborder.co.kr">Ontheborder</a></li>
									</ul>
								</section>
							</div>
							<div class="col-4 col-12-medium">
								<section>
									<header>
										<h2>오개팅</h2>
									</header>
									<ul class="social">
										<li><img 

src="${pageContext.request.contextPath}/fiveTing/image/facebook.png" width="40" height="40"></li>
										<li><img 

src="${pageContext.request.contextPath}/fiveTing/image/twitter.png" width="40" height="40"></li>
										<li><img 

src="${pageContext.request.contextPath}/fiveTing/image/instargram.png" width="40" height="40"></li>
									</ul>
									<ul class="contact">
										<li>
											

<h3>Address</h3>
											<p>아이티윌 

6강의실
											</p>
										</li>
										<li>
											

<h3>Mail</h3>
											<p><a 

href="#">55555@55.555</a></p>
										</li>
										<li>
											

<h3>Phone</h3>
											<p>(02) 000

-0000</p>
										</li>
									</ul>
								</section>
							</div>
							<div class="col-12">

								<!-- Copyright -->
									<div id="copyright">
										<ul class="links">
											<li>&copy; 

Untitled. All rights reserved.</li>
											<li>Made by 

Team 5</a></li>
										</ul>
									</div>

							</div>
						</div>
					</div>
				</section>

		<!-- Scripts -->
		<script src="${pageContext.request.contextPath}/fiveTing/js/jquery.min.js"></script>
		<script 

src="${pageContext.request.contextPath}/fiveTing/js/jquery.dropotron.min.js"></script>
		<script 

src="${pageContext.request.contextPath}/fiveTing/js/browser.min.js"></script>
		<script 

src="${pageContext.request.contextPath}/fiveTing/js/breakpoints.min.js"></script>
		<script src="${pageContext.request.contextPath}/fiveTing/js/util.js"></script>
		<script src="${pageContext.request.contextPath}/fiveTing/js/main.js"></script>
	</body>
</html>
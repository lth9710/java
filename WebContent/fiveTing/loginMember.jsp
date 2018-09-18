<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	String id = (String)session.getAttribute("id");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>오개팅</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/fiveTing/css/main.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/fiveTing/css/login.css" type="text/css" />
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon" rel="stylesheet">
<script type="text/javascript">

function sendIt() {
	
	var f = document.myForm;
	
	if(!f.id.value){
		alert("아이디를 입력하세요!");
		f.id.focus();
		return;
	}
	
	
	if(!f.pwd.value){
		alert("패스워드를 입력하세요!");
		f.pwd.focus();
		return;
	}
	
	f.action ="loginMember_ok.do"

	f.submit();
	
	
}

</script>
</head>
<body>
<jsp:include page="/fiveTing/header.jsp" flush="false"/>
	<br/><br/>
	<form name=myForm>

	<div align="center" >
	<input type="text" name="id" style="width: 20%;" placeholder="ID"/><br/>
	<input type="password" name="pwd" style="width: 20%;" placeholder="PASSWORD"/>
	</div>
	
	<!-- fiveTing/image/호머심슨.jpg -->
	<br/>
	<div align="center" >
	<img src="${pageContext.request.contextPath}/fiveTing/image/button/btn_login.png" onclick="sendIt();"/>
	<img src="${pageContext.request.contextPath}/fiveTing/image/button/btn_join.png" onclick="javascript:location.href='joinMember.do';"/>
	</div>
	</form>
	
	<!-- Scripts -->
	<script src="${pageContext.request.contextPath}/fiveTing/js/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/fiveTing/js/jquery.dropotron.min.js"></script>
	<script src="${pageContext.request.contextPath}/fiveTing/js/browser.min.js"></script>
	<script src="${pageContext.request.contextPath}/fiveTing/js/breakpoints.min.js"></script>
	<script src="${pageContext.request.contextPath}/fiveTing/js/util.js"></script>
	<script src="${pageContext.request.contextPath}/fiveTing/js/main.js"></script>
</body>
</html>
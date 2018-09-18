<%@ page contentType="text/html; charset=UTF-8"%>
<%	
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

function sendIt(){
	
	var f = document.myForm;
	
	f.submit();
	
	
	
	
}


</script>

</head>
<body>

<form action="friend_ok.jsp" method="post" name="myForm">
[학생문제]<br/><br/>

이름:<input type="text" name="userName"/><br/>
나이:<input type="text" name="userAge"/><br/>
성별:<input type="radio" name="userGender" value="남"/>남 <input type="radio" name="userGender" value="여">여<br/>
이상형:<input type="checkbox" name="userType1" value="청순"/> 청순 <input type="checkbox" name="userType2" value="가련"/> 가련 <input type="checkbox" name="userType3" value="섹시"/> 섹시<br/>

<input type="button" value="등록" onclick="sendIt();"/>




</form>









<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>



</body>
</html>
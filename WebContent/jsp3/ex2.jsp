<%@ page contentType="text/html; charset=UTF-8"%>
<%	
	request.setCharacterEncoding("UTF-8");
	
	
	

	String userName =request.getParameter("userName"); 
	String userBirth = request.getParameter("userBirth");
	
	/* session.setAttribute("userName", userName);
	session.setAttribute("userBirth", userBirth); */
	
	
	
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

function sendIt(){
	
	f = document.myForm;
	
	if(!f.userId.value){
		alert("아이디입력!");
		f.userId.focus();
		return;
	}
	
	if(!f.userPwd.value){
		alert("패스워드입력!");
		f.userPwd.focus();
		return;
	}

	f.submit();
	
	
	
}






</script>



</head>
<body>

<form action="ex3.jsp" method="post" name="myForm">

아이디:<input type="text" name="userId" size="10"/><br/>
패스워드:<input type="text" name="userPwd" size="10"><br/>

<input type="hidden" name="userName" value="<%=userName%>"/>
<input type="hidden" name="userBirth" value="<%=userBirth%>"/>

<input type="button" value="가입" onclick="sendIt();"/>






</form>






<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>



</body>
</html>
<%@ page contentType="text/html; charset=UTF-8"%>
<%	
	request.setCharacterEncoding("UTF-8");

String userName = request.getParameter("userName");
String userId = request.getParameter("userId");
String users = request.getParameter("users");
String userPwd = request.getParameter("userPwd");
String email1 = request.getParameter("email1");
String email2 = request.getParameter("sel2");
String tel1 = request.getParameter("tel1");
String tel2 = request.getParameter("tel2");
String tel3 = request.getParameter("tel3");


String check1 = request.getParameter("check1");
String check2 = request.getParameter("check2");

String mailcheck = request.getParameter("mails");


String str=email1+"@"+email2;
String str2=tel1+"-"+tel2+"-"+tel3;
String str3=" ";



if(check1==null){
	
	
}else if(check1.equals("on")){

	
	str = "등록 안함";
	
}
if(check2==null){
	
	
}else if(check2.equals("on")){

	
	str2 = "등록 안함";
	
}
if(mailcheck==null){
	str3 = "이메일 수신 거부";
	
}else if(mailcheck.equals("on")){

	
	str3 = "이메일 수신 동의";
	
}




%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

회원이름 : <%=userName %><br/>
회원아이디 : <%=userId %><br/>
별명 :<%=users %><br/>
비밀번호 : <%=userPwd %><br/>
이메일 : <%=str %><br/>
휴대폰번호 : <%=str2 %><br/>
이메일 수신여부 : <%=str3 %><br/> 


<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>



</body>
</html>

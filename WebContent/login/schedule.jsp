<%@ page contentType="text/html; charset=UTF-8"%>
<%	
	
request.setCharacterEncoding("UTF-8");
	
	String sID = session.getId();
	int sTime = session.getMaxInactiveInterval();	




%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<h3>일정관리</h3>

세션아이디: <%=sID %><br/>
세션유효시간 : <%=sTime %>초<br/>

<a href="login.jsp">돌아가기</a>





<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>



</body>
</html>
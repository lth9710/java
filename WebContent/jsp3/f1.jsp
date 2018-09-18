<%@page import="java.net.URLEncoder"%>
<%@page import="javax.print.URIException"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%	
//	request.setCharacterEncoding("UTF-8");

	String eng = "test";
	String kor = "테스트";
	
	String han = URLEncoder.encode(kor, "UTF-8");





%>

<jsp:forward page="f2.jsp">
	<jsp:param value="<%=eng %>" name="eng"/>
	<jsp:param value="<%=han %>" name="kor"/>
</jsp:forward>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>








<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>



</body>
</html>
<%@page import="com.svt.MyData"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%	
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	List<MyData> lists = new ArrayList<MyData>();
	
	MyData ob; 
	
	ob = new MyData("홍길동",30);
	lists.add(ob);
	
	ob = new MyData("이효리",40);
	lists.add(ob);
	
	ob = new MyData("배수지",27);
	lists.add(ob);
	
	ob = new MyData("천송이",42);
	lists.add(ob);
	
	
	request.setAttribute("lists", lists);
	
	
	
%>
<jsp:forward page="result.jsp"/>
	
	
	

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
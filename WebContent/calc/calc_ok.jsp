<%@page import="com.calc.Calc"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%	
	request.setCharacterEncoding("UTF-8");
	
	/* int su1 = Integer.parseInt(request.getParameter("su1"));
	int su2	= Integer.parseInt(request.getParameter("su2"));
	String oper = request.getParameter("oper"); */

	/*
	
	Calc ob = new Calc();
	
	ob.setSu1(su1);
	ob.setSu2(su2);
	ob.setOper(oper);
	
	 String str = ob.result(); */
	 
	 
	 
%>
	 
<jsp:useBean id="ob" class="com.calc.Calc" scope="page"/>
<jsp:setProperty property="*" name="ob"/>

<%-- <jsp:setProperty property="su1" name="ob" />
<jsp:setProperty property="su2" name="ob"/>
<jsp:setProperty property="oper" name="ob" />
 --%>	 
	 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

결과 : <%=ob.result() %><br/>





<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>



</body>
</html>
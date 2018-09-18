<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%	
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	//배열로받음
	Cookie[] c = request.getCookies();
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%

	if(c!=null){
		
		for(Cookie ck : c){
			
			out.print("쿠키이름 : ");
			out.print(ck.getName());
			out.print(", 쿠키값:");
			
			String str = ck.getValue();
			if(ck.getName().equals("addr")){
				str = URLDecoder.decode(str,"UTF-8");
			}
			
			out.print(str + "<br/>");
			
		}
		
	}


%>


</body>
</html>
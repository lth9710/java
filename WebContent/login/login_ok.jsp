<%@ page contentType="text/html; charset=UTF-8"%>
<%	
	request.setCharacterEncoding("UTF-8");

	String userId = request.getParameter("userId");
	String userPwd = request.getParameter("userPwd");
	
	if(userId.equals("suzi")&&userPwd.equals("123")){
		
		session.setAttribute("userId", userId);
		
		response.sendRedirect("login.jsp");
		
	}






%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

아이디나 패스워드가 틀립니다!


<a href="login.jsp">돌아가기</a>






</body>
</html>
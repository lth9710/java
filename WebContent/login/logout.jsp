<%@ page contentType="text/html; charset=UTF-8"%>
<%	
	request.setCharacterEncoding("UTF-8");


	session.removeAttribute("userId");//data삭제
	session.invalidate();//변수삭제

	response.sendRedirect("login.jsp");
	
%>

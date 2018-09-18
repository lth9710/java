<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.board.BoardDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%	
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<jsp:useBean id="dto" class="com.board.BoardDTO" scope="page"/>
<jsp:setProperty property="*" name="dto"/>

<%

	


	Connection conn = DBConn.getConnection();

	BoardDAO dao = new BoardDAO(conn);

	
	
	
	
	String pageNum = request.getParameter("pageNum");
	
	String searchKey = request.getParameter("searchKey");
	String searchValue = request.getParameter("searchValue");
	
	if(searchKey!=null){
	
		if(request.getMethod().equalsIgnoreCase("GET")){
			searchValue = URLDecoder.decode(searchValue,"UTF-8");
		}
		
		
	}else{
		searchKey="subject";
		searchValue="";
	}

	
	int result = dao.updateData(dto);
	
	
	String param = "";
	if(searchValue!=null||!searchValue.equals("")){
		
		param = "&searchKey=" + searchKey;
		param+= "&searchValue=" + searchValue;
			URLEncoder.encode(searchValue, "UTF-8");
			
		
	}
	
	
	
	
	DBConn.close();
	
	response.sendRedirect("list.jsp?pageNum="+pageNum+param);

	
	

%>

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
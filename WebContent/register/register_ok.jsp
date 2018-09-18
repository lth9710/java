<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.register.RegisterDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%	
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="dto" class="com.register.RegisterDTO" scope="page"/>
<jsp:setProperty property="*" name="dto"/>

<%
session.setAttribute("userId", dto.getUserId());
if(dto.getTel1()==null){dto.setTel1("등록안함");}
if(dto.getTel2()==null){dto.setTel2(" ");}
if(dto.getTel3()==null){dto.setTel3(" ");}
if(dto.getEmail1()==null){dto.setEmail1("등록 안함");}
if(dto.getSel2()==null){dto.setSel2("등록 안함");}
if(dto.getCheck1()==null){dto.setCheck1("등록");}
else if(dto.getCheck1()!=null){dto.setCheck1("등록 안함");}
if(dto.getCheck2()==null){dto.setCheck2("등록");}
else if(dto.getCheck2()!=null){dto.setCheck2("등록 안함");}

Connection conn = DBConn.getConnection();

RegisterDAO dao = new RegisterDAO(conn);

int result = dao.insertData(dto);

DBConn.close();

if(result!=0){
	
	response.sendRedirect("list.jsp");
	
}



%>






<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

입력오류!

<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>



</body>
</html>



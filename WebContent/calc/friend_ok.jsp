<%@ page contentType="text/html; charset=UTF-8"%>
<%	
	request.setCharacterEncoding("UTF-8");


%>

<jsp:useBean id="vo" class="com.calc.FriendVO" scope="page"/>
<jsp:setProperty property="*" name="vo"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
if(vo.getUserType1()==null){vo.setUserType1("");}
if(vo.getUserType2()==null){vo.setUserType2("");}
if(vo.getUserType3()==null){vo.setUserType3("");}
%>


이름:<%=vo.getUserName() %><br/>
나이:<%=vo.getUserAge() %><br/>
성별:<%=vo.getUserGender() %><br/>
이상형:<%=vo.getUserType1() +" "+ vo.getUserType2()+" "+vo.getUserType3() %><br/>








<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>



</body>
</html>
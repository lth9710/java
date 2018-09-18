<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%	
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="" method="post" >

단:<input type="text" name="dan"/><br/>
<input type="submit" value="결과"/><br/><br/>

</form>
<br/><br/>

<c:if test="${!empty param.dan }">
		${param.dan }단: 
		<c:forEach var="j" begin="1" end="9" step="1">
		${param.dan }*${j }=${param.dan*j }&nbsp;&nbsp;&nbsp;
		
			
		</c:forEach>
	
</c:if>





<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>



</body>
</html>
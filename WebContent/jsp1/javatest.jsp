<%@ page contentType="text/html; charset=UTF-8"%>
<%	
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<body>
	<%
		String selYear = request.getParameter("selYear");
	%>
	<script type="text/javascript">
		function year(){
			form.submit();
		}
	
	</script>
	<form action="" method="get" id="form">
		<%=selYear%>
		<select name="selYear" onchange="year()">
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
		</select>
	</form>
</body>
</html>






<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>



</body>
</html>
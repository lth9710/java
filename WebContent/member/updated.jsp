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
<script type="text/javascript">
function sendIt(){
	
	var f = document.myForm;
	

	
	f.action = "<%=cp%>/join/updated_ok.do";
	f.submit();
	
	
	
}



</script>
<style type="text/css">


*{

	padding: 0px;
	margin: 0px;

} 

body {
	font-size: 9pt;
}

td{
font-size: 9pt;
}

.txtField{

font-size: 9pt;
border: 1px solid;

}
.btn{
font-size: 9pt;
background: #e6e6e6;
}

</style>

</head>
<body>

<br/><br/>

<table width="500" cellpadding="0" cellspacing="3"
align="center" bgcolor="#e4e4e4">
<tr height="50">
	<td bgcolor="#ffffff" style="padding-left: 10px;">
	<b>회원수정</b>
	</td>
</tr>
</table>

<br/>

<form action="" name="myForm" method="post">

<table width="500" cellpadding="0" cellspacing="0" 
align="center">

<tr height="2">
	<td colspan="2" bgcolor="#cccccc"></td>
</tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">아이디</td>
	<td style="padding-left: 5px;">
	 ${dto.userId }
 	</td>
</tr>

<tr height="2">
	<td colspan="2" bgcolor="#cccccc"></td>
</tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">이름</td>
	<td style="padding-left: 5px;">
	${dto.userName }
 	</td>
</tr>

<tr height="2">
	<td colspan="2" bgcolor="#cccccc"></td>
</tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">패스워드</td>
	<td style="padding-left: 5px;">
	<input type="text" name="userPwd" value="${dto.userPwd }" size="20"  class="txtField"/> 
 	</td>
</tr>

<tr height="2">
	<td colspan="2" bgcolor="#cccccc"></td>
</tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">생일</td>
	<td style="padding-left: 5px;">
	<input type="text" name="userBirth"  value="${dto.userBirth }"	size="20"  class="txtField"/> 
 	</td>
</tr>

<tr height="2">
	<td colspan="2" bgcolor="#cccccc"></td>
</tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">전화</td>
	<td style="padding-left: 5px;">
	<input type="text" name="userTel"  value="${dto.userTel }" 	size="20"  class="txtField"/>
 	</td>
</tr>

<tr height="2">
	<td colspan="2" bgcolor="#cccccc"></td>
</tr>



<tr height="2">
	<td colspan="2" bgcolor="#cccccc"></td>
</tr>

<tr height="35">
	<td align="center" colspan="2">
	
	<input type="hidden" name="userId" value="${dto.userId }"/>
	<input type="hidden" name="userName" value="${dto.userName }"/>
	
	<input type="button" class="btn" value="수정완료" 
	onclick="sendIt();"/>


	<input type="button" class="btn" value="수정취소"
	onclick="javascript:location.href='<%=cp%>';"/>
	</td>
</tr>

</table>

</form> 











</body>
</html>
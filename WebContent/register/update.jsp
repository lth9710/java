<%@page import="com.register.RegisterDTO"%>
<%@page import="com.register.RegisterDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%	
	request.setCharacterEncoding("UTF-8");

	String cp = request.getContextPath();

	String userid =request.getParameter("userId");
	
	Connection conn = DBConn.getConnection();
	
	RegisterDAO dao = new RegisterDAO(conn);
	
	RegisterDTO dto = dao.getReadData(userid);
	
	DBConn.close();
	
	if(dto==null)
		response.sendRedirect("list.jsp");
	
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원정보 수정화면</title>

<script type="text/javascript">

	function sendIt(){
		
		var f = document.myForm;
		
		if(!f.userId.value){
			alert("아이디를 입력해 주세요!");
			f.userId.focus();
			return;
		}
		
		
		
		
		

		//http://192.168.16.5:8080/study/score/write_ok.jsp원래 액션은 이렇게적어줘야함
		
		f.action = "<%=cp%>/register/update_ok.jsp";
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
	<b>회원가입 수정화면</b>
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
	<%=dto.getUserId() %> 
 	</td>
</tr>

<tr height="2">
	<td colspan="2" bgcolor="#cccccc"></td>
</tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">이름</td>
	<td style="padding-left: 5px;">
	<%=dto.getUserName() %> 
 	</td>
</tr>

<tr height="2">
	<td colspan="2" bgcolor="#cccccc"></td>
</tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">별명</td>
	<td style="padding-left: 5px;">
	<input type="text" name="users" value="<%=dto.getUsers()%>" size="20"  class="txtField"/> 
 	</td>
</tr>

<tr height="2">
	<td colspan="2" bgcolor="#cccccc"></td>
</tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">비밀번호</td>
	<td style="padding-left: 5px;">
	<input type="text" name="userPwd"  value="<%=dto.getUserPwd() %>"	size="20"  class="txtField"/> 
 	</td>
</tr>

<tr height="2">
	<td colspan="2" bgcolor="#cccccc"></td>
</tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">이메일</td>
	<td style="padding-left: 5px;">
	<input type="text" name="email1"  value="<%=dto.getEmail1() %>" 	size="20"  class="txtField"/>
 	</td>
</tr>

<tr height="2">
	<td colspan="2" bgcolor="#cccccc"></td>
</tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">이메일 도메인</td>
	<td style="padding-left: 5px;">
	<input type="text" name="sel2"  value="<%=dto.getSel2() %>" 	size="20"  class="txtField"/>
 	</td>
</tr>

<tr height="2">
	<td colspan="2" bgcolor="#cccccc"></td>
</tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">휴대폰번호(1/3)</td>
	<td style="padding-left: 5px;">
	<input type="text" name="tel1"  value="<%=dto.getTel1()%>" 	size="20"  class="txtField"/>
 	</td>
</tr>

<tr height="2">
	<td colspan="2" bgcolor="#cccccc"></td>
</tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">휴대폰번호(2/3)</td>
	<td style="padding-left: 5px;">
	<input type="text" name="tel2"  value="<%=dto.getTel2() %>" 	size="20"  class="txtField"/>
 	</td>
</tr>

<tr height="2">
	<td colspan="2" bgcolor="#cccccc"></td>
</tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">휴대폰번호(3/3)</td>
	<td style="padding-left: 5px;">
	<input type="text" name="tel3"  value="<%=dto.getTel3() %>" 	size="20"  class="txtField"/>
 	</td>
</tr>

<tr height="2">
	<td colspan="2" bgcolor="#cccccc"></td>
</tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">이메일 등록여부</td>
	<td style="padding-left: 5px;">
	<input type="text" name="check1"  value="<%=dto.getCheck1() %>" 	size="20"  class="txtField"/>
 	</td>
</tr>

<tr height="2">
	<td colspan="2" bgcolor="#cccccc"></td>
</tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">휴대폰 등록여부</td>
	<td style="padding-left: 5px;">
	<input type="text" name="check2"  value="<%=dto.getCheck2() %>" 	size="20"  class="txtField"/>
 	</td>
</tr>

<tr height="2">
	<td colspan="2" bgcolor="#cccccc"></td>
</tr>

<tr height="35">
	<td align="center" colspan="2">
	
	<input type="hidden" name="userId" value="<%=dto.getUserId() %>"/>
	<input type="hidden" name="userName" value="<%=dto.getUserName()%>"/>
	
	<input type="button" class="btn" value="수정완료" 
	onclick="sendIt();"/>


	<input type="button" class="btn" value="수정취소"
	onclick="javascript:location.href='<%=cp%>/register/list.jsp';"/>
	</td>
</tr>

</table>

</form> 






<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>



</body>
</html>
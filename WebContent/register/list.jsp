<%@page import="com.register.RegisterDTO"%>
<%@page import="com.register.RegisterDAO"%>
<%@page import="java.util.List"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%	
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	Connection conn = DBConn.getConnection();
	
	RegisterDAO dao = new RegisterDAO(conn);
	
	List<RegisterDTO> lists = dao.getList();
	
	DBConn.close();
	
	
	
	
	
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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

<table width="700" cellpadding="0" cellspacing="3"
align="center" bgcolor="#e4e4e4">
<tr height="50">
	<td bgcolor="#ffffff" style="padding-left: 10px;">
	<b>회원가입 리스트</b>
	</td>
</tr>
</table>
<br/>

<table width="560" cellpadding="0" cellspacing="3" align="center">
<tr height="35">
	<td align="right">
	<input type="button" class="btn" value="회원가입"
	onclick="javascript:location.href='<%=cp %>/register/register.jsp';"/>
	</td>
</tr>

</table>

<table width="650" cellpadding="0" cellspacing="1"
align="center" bgcolor="#cccccc">
<tr height="30">
	<td align="center" bgcolor="#e6e6e6" width="60">아이디</td>
	<td align="center" bgcolor="#e6e6e6" width="60">이름</td>
	<td align="center" bgcolor="#e6e6e6" width="60">별명</td>
	<td align="center" bgcolor="#e6e6e6" width="60">비밀번호</td>
	<td align="center" bgcolor="#e6e6e6" width="130">비밀번호 질문</td>
	<td align="center" bgcolor="#e6e6e6" width="60">비밀번호 답</td>
	<td align="center" bgcolor="#e6e6e6" width="60">이메일</td>
	<td align="center" bgcolor="#e6e6e6" width="60">이메일도메인</td>
	<td align="center" bgcolor="#e6e6e6" width="60">휴대폰 번호</td>
	<td align="center" bgcolor="#e6e6e6" width="230">이메일 등록여부</td>
	<td align="center" bgcolor="#e6e6e6" width="230">휴대폰 등록여부</td>
	<td align="center" bgcolor="#e6e6e6" width="150">수정</td>
</tr>

<%for(RegisterDTO dto : lists){%>
<tr height="30">
	<td align="center" bgcolor="#ffffff"><%=dto.getUserId() %></td>
	<td align="center" bgcolor="#ffffff"><%=dto.getUserName() %></td>
	<td align="center" bgcolor="#ffffff"><%=dto.getUsers()%></td>
	<td align="center" bgcolor="#ffffff"><%=dto.getUserPwd()%></td>
	<td align="center" bgcolor="#ffffff"><%=dto.getSel1()%></td>
	<td align="center" bgcolor="#ffffff"><%=dto.getAns2()%></td>
	<td align="center" bgcolor="#ffffff"><%=dto.getEmail1()%></td>
	<td align="center" bgcolor="#ffffff"><%=dto.getSel2()%></td>
	<td align="center" bgcolor="#ffffff"><%=dto.getTel1()%>-<%=dto.getTel2()%>-<%=dto.getTel3()%></td>
	
	<td align="center" bgcolor="#ffffff"><%=dto.getCheck1()%></td>
	<td align="center" bgcolor="#ffffff"><%=dto.getCheck2()%></td>
	<td align="center" bgcolor="#ffffff">
	<a href="<%=cp %>/register/update.jsp?userId=<%=dto.getUserId()%>">수정</a> 
	<a href="<%=cp %>/register/delete_ok.jsp?userId=<%=dto.getUserId() %>">삭제</a>
	</td>
</tr>
<%} %>


</table>







<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>



</body>
</html>
<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%	
	request.setCharacterEncoding("UTF-8");

	String userId = (String)session.getAttribute("userId");
	
	//session.setMaxInactiveInterval(20*60);//20분

	Calendar cal = Calendar.getInstance();
	
	//오늘날짜
	int nowYear = cal.get(Calendar.YEAR);
	int nowMonth = cal.get(Calendar.MONTH)+1;
	int nowDay = cal.get(Calendar.DAY_OF_MONTH);
	
	//클라이언트에서 넘어온 데이터
	String strYear = request.getParameter("selYear");
	String strMonth = request.getParameter("selMonth");
	
	//표시할 달력의 년,월
	int year = nowYear;
	int month = nowMonth;
	
	if(strYear!=null){
		year = Integer.parseInt(strYear); // client가 선택한 년도
	}
	if(strMonth!=null){
		month = Integer.parseInt(strMonth);// client가 선택한 년도
	}
	
	int preYear =year;
	int preMonth=month-1;
		
	if(preMonth<1){
		preYear=year-1;
		preMonth=12;
	}
	
	int nextYear = year;
	int nextMonth = month+1;
	if(nextMonth>12){
		nextYear=year+1;
		nextMonth=1;
	}

	int optionYear = year-5;
	int optionMonth = 1;
	
	int selectYear=0;
	int selectMonth=0;
	
	
	
	//표시할 달력 셋팅
	cal.set(year, month-1,1);
	int startDay = 1;
	int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	
	int week = cal.get(Calendar.DAY_OF_WEEK);
	


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">


function sendIt() {
	
	var f = document.myForm;
	
	if(!f.userId.value){
		alert("아이디를 입력하세요!");
		f.userId.focus();
		return;
	}
	
	
	if(!f.userPwd.value){
		alert("패스워드를 입력하세요!");
		f.userPwd.focus();
		return;
	}
	
	
	f.submit();
	
	
}


function sendIt2(){
	
	var f = document.cal;
	
	
	f.submit();
}



</script>


</head>
<body style="font-size: 9pt;">

<table border="1" width="600" align="center"
style="font-size: 9pt">

<tr height="20">
	<td colspan="2" align="right">
	|게시판|
	
	
	<%if(userId==null){%>
	일정관리
	<%}else{ %>
	<a href="schedule.jsp">일정관리</a>
	<%} %>
	|
	</td>
</tr>

<tr height="400">
	<td width="100" valign="top">

	<%if(userId==null){%>	
	<form action="login_ok.jsp" method="post" name="myForm">
	아이디:<input type="text" name="userId" size="10"/><br/>
	패스워드:<input type="password" name="userPwd" size="10"><br/>
	<input type="button" value="로그인" onclick="sendIt();"/>
	</form>
	<%}else{ %>
	<%=userId %>님 방가방가!<br/><br/>
		
	<a href="logout.jsp">로그아웃</a>	
	<%} %>
	
	</td>

	<%if(userId==null){%>	
	<td valign="middle" align="center">
	<b>로그인하면 새로운 세상이 보입니다!</b>
	</td>

<%}else{ %>

<td valign="middle" align="center">

<form action="login.jsp" name="cal" method="post">
<table align="center" width="210" cellpadding="2"
 cellspacing="1" > 

<tr>
	<td align="center">
	<select onchange="sendIt2();" name="selYear">
	<%for(int i=year-5;year>i;i++){%>
		<option value="<%=i %>"><%=i %></option> <%}%>
		
	<option selected="selected" value="<%=year %>"><%=year %></option>
	
	<%for(int i=year+1;year+5>i;i++){%>
		<option value="<%=i %>"><%=i %></option> <%}%>
	
	
	
	
	
	
	
	</select><b>년</b> <select onchange="sendIt2();" name="selMonth">
	<%for(int i=1;i<13;i++){%>																	 
		<option <%=month==i?"selected='selected'":"" %>><%=i %></option><%} %>
		
	
	</select><b>월</b>
	</td>
</tr>
</table>

<table align="center" width="210" cellpadding="0"
cellspacing="1" bgcolor="#cccccc">

<tr>
	<td bgcolor="#e6e4e6" align="center"><font color="red">일</font></td> 
	<td bgcolor="#e6e4e6" align="center">월</td> 
	<td bgcolor="#e6e4e6" align="center">화</td> 
	<td bgcolor="#e6e4e6" align="center">수</td> 
	<td bgcolor="#e6e4e6" align="center">목</td> 
	<td bgcolor="#e6e4e6" align="center">금</td> 
	<td bgcolor="#e6e4e6" align="center"><font color="blue">토</font></td> 
</tr>


<%	
	int newLine = 0;
	out.print("<tr height='20'>");
	for(int i=1;i<week;i++){
	out.print("<td bgcolor='#ffffff'>&nbsp;</td>");
		newLine++;
	}
	
	for(int i=startDay;i<=endDay;i++){
		
		String fontColor = (newLine==0)?"red":
			(newLine==6)?"blue":"black";
		
		String bgColor = (nowYear==year)&&(nowMonth==month)&&
				(nowDay==i)?"#e6e4e6":"#ffffff";
	
		out.print("<td align='center' bgcolor='" + bgColor + 
				"'><font color='" + fontColor + "'>" + i +
				"</font></td>");		
		//<td align='center' bgcolor='#ffffff'>
		//<font color='red'>26</font></td>
	
		newLine++;
		
		if(newLine==7&&i!=endDay){
			out.print("</tr><tr height='20'>");
			newLine=0;
		}
	
	}

	while(newLine>0&&newLine<7){
		out.print("<td bgcolor='#ffffff'>&nbsp;</td>");
		newLine++;
	}
	out.print("</tr>");
	
%>
<%} %>



</table>
</form>
</td>


</tr>
</table>






<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>



</body>
</html>
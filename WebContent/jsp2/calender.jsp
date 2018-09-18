<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%	
	request.setCharacterEncoding("UTF-8");


	Calendar cal = Calendar.getInstance();
	
	//오늘날짜
	int nowYear = cal.get(Calendar.YEAR);
	int nowMonth = cal.get(Calendar.MONTH)+1;
	int nowDay = cal.get(Calendar.DAY_OF_MONTH);
	
	//클라이언트에서 넘어온 데이터
	String strYear = request.getParameter("year");
	String strMonth = request.getParameter("month");
	
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

<style type="text/css">

body {
	font-size: 12pt;
}

td {
	font-size: 9pt
}

</style>

</head>
<body>
<br/><br/>

<table align="center" width="210" cellpadding="2"
 cellspacing="1" > 

<tr>
	<td align="center">
	<a href="calender.jsp?year=<%=nowYear %>&month=<%=nowMonth %>">
	<img src="./image/today.JPG" align="left"></a>
	<a href="calender.jsp?year=<%=preYear%>&month=<%=preMonth%>">◀</a>
	<b>&nbsp;<%=year %>년&nbsp;&nbsp;<%=month %>월</b>
	<a href="calender.jsp?year=<%=nextYear %>&month=<%=nextMonth %>">▶</a>
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





</table>









<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>



</body>
</html>
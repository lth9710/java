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
<title>성적처리 입력화면</title>

<script type="text/javascript">

	function sendIt(){
		
		var f = document.myForm;
		
		if(!f.hak.value){
			alert("학번을 입력해 주세요!");
			f.hak.focus();
			return;
		}
		
		
		if(!f.name.value){
			alert("학번을 입력해 주세요!");
			f.name.focus();
			return;
		}
		
		
		
		
		

		//http://192.168.16.5:8080/study/score/write_ok.jsp원래 액션은 이렇게적어줘야함
		
		f.action = "<%=cp%>/sscore/write_ok.do";
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
	<b>성적처리 입력화면</b>
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
	<td align="center" width="100" bgcolor="#e6e6e6">학번</td>
	<td style="padding-left: 5px;">
	<input type="text" name="hak" size="10" maxlength="7" class="txtField"/> 
 	</td>
</tr>

<tr height="2">
	<td colspan="2" bgcolor="#cccccc"></td>
</tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">이름</td>
	<td style="padding-left: 5px;">
	<input type="text" name="name" size="20" maxlength="10" class="txtField"/> 
 	</td>
</tr>

<tr height="2">
	<td colspan="2" bgcolor="#cccccc"></td>
</tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">국어</td>
	<td style="padding-left: 5px;">
	<input type="text" name="kor" size="20" maxlength="3" class="txtField"/> 
 	</td>
</tr>

<tr height="2">
	<td colspan="2" bgcolor="#cccccc"></td>
</tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">영어</td>
	<td style="padding-left: 5px;">
	<input type="text" name="eng" size="20" maxlength="3" class="txtField"/> 
 	</td>
</tr>

<tr height="2">
	<td colspan="2" bgcolor="#cccccc"></td>
</tr>

<tr height="30">
	<td align="center" width="100" bgcolor="#e6e6e6">수학</td>
	<td style="padding-left: 5px;">
	<input type="text" name="mat" size="20" maxlength="3" class="txtField"/> 
 	</td>
</tr>

<tr height="2">
	<td colspan="2" bgcolor="#cccccc"></td>
</tr>

<tr height="35">
	<td align="center" colspan="2">
	<input type="button" class="btn" value="입력완료" 
	onclick="sendIt();"/>


	<input type="reset" class="btn" value="다시입력"
	onclick="document.myForm.hak.focus();"/>

	<input type="button" class="btn" value="입력취소"
	onclick="javascript:location.href='<%=cp%>/sscore/list.do';"/>
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
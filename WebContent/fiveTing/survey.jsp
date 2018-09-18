<%@ page  contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
	
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/fiveTing/css/login.css" type="text/css" />

<script type="text/javascript">



function emailCheck() { // 이메일 체크 
	var f = document.myForm;

	var clength = f.sel1.options.length;

	var cvalue = f.sel1.selectedIndex;

	f.sel2.value = "";

	if (cvalue == (clength - 1)) {
		f.sel2.readOnly = false;
	} else {
		f.sel2.value = f.sel1.options[cvalue].value;
		f.sel21.readOnly = true;
	}
}

function questionCheck(){
	var f = document.myForm;
	var clength = f.selQ.options.length; // 4
	var cvalue = f.selQ.selectedIndex; // 0,1,2,3
	f.question.value = "";
	
	
	if(cvalue==(clength-1)){ // 직접입력을 선택하는 경우
		f.question.readOnly = false;
		f.question.style.backgroundColor = 'white';
		f.question.focus(); // 커서가 감.
	}else{
		f.question.value = f.selQ.options[cvalue].value;
		f.question.style.backgroundColor = '#E7E7E7';
		f.question.readOnly = true;
	}
}
function sendIt() {
	f = document.myForm;
   f.action = "<%=cp%>/five/reason.do";
   f.submit();
}

</script>

</head>
<body>

        <div style="padding-left: 500px; padding-right: 500px; padding-top: 60px;">
          
		<h1 align="left" style="font-size: 50px">탈퇴하기</h1>
		<hr color="#d52349" size="2" align="right" />
		회원탈퇴시 지금까지 제공되었던 서비스를 받을 수 없습니다.
		
		<br/>
		<br/>
		
			<form action="" method="post" name="myForm">
			<table>
				<tr>
					<td>
			  		<b><h2>탈퇴 이유를 선택해주세요</h2></b>
					 						
						
						<select name="sel1" onchange="emailCheck();" style="width: 320px; height: 60px;">
							<option>선택하세요</option> <br/>
							<option value="사용하지 않아서">사용하지 않아서</option> 
							<option value="매칭이 되어서">매칭이 되어서</option>
							<option value="서비스가 맞지 않아서">서비스가 맞지 않아서</option>
							<option value="">직접입력(기타)</option></select></td>
				</tr>
				<tr>
					<td>
					<br/>
						<input type="text" name="sel2" readonly="readonly" style="width: 600px; height: 60px;"/> &nbsp;&nbsp;
						<input type="hidden" name ="id" value="${sessionScope.MemberInfo.id }" >
					</td>
				</tr>
				
			</table>
			<table style="padding-left: 200px;">
				
				<tr>					
					<td><br/><br/><br/><br/>
						<input type="image" src="${pageContext.request.contextPath}/fiveTing/image/button/btn_ok.png" onclick="sendIt();"/>
					</td>
					<td width=20px>
					</td>
					<td><br/><br/><br/><br/>                    
						<a href="${pageContext.request.contextPath}/five/index.do">
						<img src="${pageContext.request.contextPath}/fiveTing/image/button/btn_no.png"></a>
					</td>
				</tr>
				
			</table>
			</form>
		</div>

</body>
</html>
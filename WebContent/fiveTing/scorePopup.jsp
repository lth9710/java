<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="<%=cp %>/fiveTing/css/button.css" type="text/css"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript">
	function sendScore(){
		f = document.PopupForm;
	    f.action="updateScore.do?u_id=${u_id}";
	    f.submit();
	}
</script>

</head>
<body>
<form action="" name="PopupForm" method="post">
<input type="hidden" name="u_id" value="${u_id }"/>
<table align="center" border=0 style="font-size: 8pt;">
	<tr>
		<td style="font-size: 13pt;">
			<b>외모 평가</b>
		</td>
	</tr>
	<tr><td><hr width="40" color="#d52349" align="center"/></td></tr>
	<tr height="30"><td></td></tr>
	<tr>
		<td>
		<input type="radio" id="r1" name="btnScore" value=100 />
    	<label for="r1"><span></span>완벽</label>
		</td>
	</tr>
	<tr height="20"><td></td></tr>
	<tr>
		<td>
		<input type="radio" id="r2" name="btnScore" value=60 />
   		<label for="r2"><span></span>훈훈</label>
		</td>
	</tr>
	<tr height="20"><td></td></tr>
	<tr>
		<td>
		<input type="radio" id="r3" name="btnScore" value=40 />
    	<label for="r3"><span></span>평범</label>
		</td>
	</tr>
	<tr height="20"><td></td></tr>
	<tr>
		<td>
		<input type="radio" id="r4" name="btnScore" value=20 />
    	<label for="r4"><span></span>못남</label>
		</td>
	</tr>
	<tr height="20"><td></td></tr>
	<tr>
		<td>
		<input type="radio" id="r5" name="btnScore" value=0 />
    	<label for="r5"><span></span>절망</label>
		</td>
	</tr>
	<tr height="40"><td></td></tr>
</table>
</form>
<table align="center">
	<tr>
		<td align="center">
			<!-- 확인버튼(RadioButton의 Value를 update.do에 전송한다.) -->
			<input type="image" src="${imagePath }/button/btn_popupOk.png" onclick="sendScore();"/>
		</td>
		<td width="15"></td>
		<td align="center">
			<!-- 취소버튼(팝업을 종료한다.) -->
			<input type="image" src="${imagePath }/button/btn_popupCancel.png" onclick="javascript:window.close();"/>
		</td>
	</tr>
</table>
</body>
</html>

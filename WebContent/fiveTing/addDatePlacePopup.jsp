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
<link rel="stylesheet" href="<%=cp%>/fiveTing/css/login.css" type="text/css" />
<script type="text/javascript">
	function sendDatePlace(){
		f = document.addDatePlaceForm;
	    f.action="addDatePlace.do";
	    f.submit();
	}
</script>
<title>데이트장소 등록</title>
</head>
<body>
<form action="" method="post" enctype="multipart/form-data" name="addDatePlaceForm">
<table align="left" cellspacing="0px" cellpadding="0px" height=100 style="padding-left: 70px">
	<tr>
		<td style="font-size: 25pt;font-weight: bold;">데이트장소 등록</td>
	</tr>
	<tr>
		<td style="vertical-align: top;">
			<hr width="200" color="#d52349" align="left"/>
		</td>
	</tr>
</table>
<table align="center" border="0" cellspacing="0px" width=400 height=200 style="text-align: center;font-size: 10pt;padding-right: 20px;">
	<tr height=10><td></td></tr>
	<tr>
		<td width=15% style="font-weight: bold;">장소명</td>
		<td width=5%></td>
		<td width=80%><input name="datePlace_name" type="text"/></td>
	</tr>
	<tr height=20><td></td></tr>
	<tr>
		<td style="font-weight: bold;">주소</td>
		<td></td>
		<td><input name="datePlace_address" type="text"/></td>
	</tr>
	<tr height=20><td></td></tr>
	<tr>
		<td style="font-weight: bold;">연락처</td>
		<td></td>
		<td><input name="datePlace_tel" type="text"/></td>
	</tr>
	<tr height=20><td></td></tr>
	<tr>
		<td style="font-weight: bold;">홈페이지</td>
		<td></td>
		<td><input name="datePlace_homepage" type="text"/></td>
	</tr>
	<tr height=20><td></td></tr>
	<tr>
		<td style="font-weight: bold;">소개글</td>
		<td></td>
		<td><textarea rows="5" cols="62" name="datePlace_content" class="boxTA"></textarea></td>
	</tr>
	<tr height=15><td></td></tr>
	<tr>
		<td style="font-weight: bold;">사진</td>
		<td></td>
		<td style="text-align: center;"><input height=10 type="file" name="datePlace_picture" style="padding-top: 20px;"><br/></td>
	</tr>
	<tr height=20><td></td></tr>
</table>
<br/>
<table align="center" height=40 style="padding-right: 80px">
	<tr>
		<td colspan="3" style="padding-left: 100px;">
			<input type="image" src="${imagePath }/button/btn_add.png" onclick="sendDatePlace();"/>
		</td>
		<td width=50></td>
		<td><input type="image" src="${imagePath }/button/btn_cancel.png" onclick="javascript:window.close();"/></td>
	</tr>
</table>
</form>
</body>
</html>

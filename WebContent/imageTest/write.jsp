<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=cp%>/imageTest/data/image.js"></script>
<link rel="stylesheet" href="<%=cp%>/imageTest/data/style.css"
	type="text/css" />
<title>이미지 업로드</title>
</head>
<body>
	<div id="bbsList">
		<div id="bbsList_title">이미지 게시판</div>
	</div>

	<form method="post" name="myForm" enctype="multipart/form-data">
	<div id="bbsList">
		<table>
			<tr height="2">
				<td colspan="2" bgcolor="#cccccc"></td>
			</tr>

			<tr height="25">
				<td width="80" bgcolor="#e6e4e6" align="center">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
				<td width="400" style="padding-left: 5px;"><input type="text"
					name="subject" maxlength="10" size="15"
					style="width: 300px; height: 20px;" /></td>
			</tr>

			<tr height="2">
				<td colspan="2" bgcolor="#cccccc"></td>
			</tr>

			<tr height="25">
				<td width="80" bgcolor="#e6e4e6" align="center">파&nbsp;&nbsp;&nbsp;&nbsp;일</td>
				<td width="400" style="padding-left: 5px;"><input
					type="file" name="upload" maxlength="10" size="15"
					style="width: 300px; height: 20px;" /></td>
			</tr>

			<tr height="2">
				<td colspan="2" bgcolor="#cccccc"></td>
			</tr>
			
			<tr>
	<td colspan="2" align="center">
	<input type="button" value="등록하기" class="btn2" onclick="sendIt();"/>
	<input type="reset" value="다시입력" class="btn2" 
	onclick="document.myForm.subject.focus();"/>
	<input type="button" value="작성취소" class="btn2" 
	onclick="javascript:location.href='<%=cp%>/image/list.do';"/>
	</td>
</tr>
			
		</table>
	</div>
</form>

</body>
</html>
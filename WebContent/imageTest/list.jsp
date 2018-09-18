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
<title>Insert title here</title>
<link rel="stylesheet" href="<%=cp%>/imageTest/data/style.css"
	type="text/css" />
<script type="text/javascript" src="<%=cp%>/imageTest/data/image.js"></script>
</head>
<body>

	<div id="bbsList">
		<div id="bbsList_title">이미지 게시판</div>

		<table width="100%;">
			<tr>
				<td align="left">Total ${dataCount } articles&nbsp;${totalPage } pages&nbsp;/ &nbsp;Now page is <c:if test="${pageNum==null }">1</c:if> ${pageNum }</td>
				<td align="right"><input type="button" value="게시물등록"
					onclick="javascript:location.href='<%=cp%>/image/write.do'"></td>
			</tr>

			<tr height="2">
				<td colspan="2" bgcolor="#cccccc"></td>
			</tr>





		


	</div>
	<c:set var="i" value="0" />
	<c:set var="j" value="3" />
	<table border="1" align="center" cellspacing="5">
		<c:forEach items="${lists }" var="dto">
			<c:if test="${i%j == 0 }">
				<tr>
			</c:if>
			<td><img src="${imagePath }/${dto.saveFileName }" width="180"
				height="180"><br/><p style="text-align: center;">${dto.subject }&nbsp;<a href="<%=cp%>/image/delete.do?num=${dto.num }&pageNum=${pageNum}">삭제</a></p></td>
			<c:if test="${i%j == j-1}">
				</tr>
			</c:if>
			<c:set var="i" value="${i+1 }" />
		</c:forEach>
		
		<tr align="center">
			<td colspan="3">${pageIndexList }</td>
		</tr>
	</table>

</table>






</body>
</html>
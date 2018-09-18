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
<link rel="stylesheet" href="<%=cp%>/filetest/list.css" type="text/css"/>
<title>Insert title here</title>
</head>
<body>



<table width="560" cellpadding="0" cellspacing="3" align="center" >
<tr height="35">
	<td align="right">
	<input type="button" class="btn" value="글쓰기" 
		onclick="javascript:location.href='<%=cp %>/file/write.do';"/>
	</td>
</tr>
</table>

<table width="650" cellpadding="0" cellspacing="1" align="center" >
<tr height="30">
	<td align="center"  width="60">번호</td>
	<td align="center"  width="60">제목</td>
	<td align="center"  width="60">파일명</td>
	<td align="center"  width="60">삭제</td>

</tr>

<c:forEach var="dto" items="${lists2 }">
<tr height="30"	>
	<td align="center" bgcolor="#ffffff">${dto.num }</td>			
	<td align="center" bgcolor="#ffffff">${dto.subject }</td>			
	<td align="center" bgcolor="#ffffff"><%-- <a href="${downloadPath }?num=${dto.num}">${dto.originalFileName}</a> --%>
	
	<a href="${imagePath }/${dto.saveFileName }"><img src="${imagePath }/${dto.saveFileName }" width="180" height="180">
	</a>
	
	</td>			
	<td align="center" bgcolor="#ffffff">
	<a href="<%=cp%>/file/delete.do?num=${dto.num }&pageNum=${pageNum}">삭제 </a>
	</td>
</tr>
	
</c:forEach>
</table>

		<div id="footer" align="center">
			<p>
				<c:if test="${dataCount!=0 }">
					${pageIndexList }
				</c:if>
				<c:if test="${dataCount==0 }">
					등록된 게시물이 없습니다.
				</c:if>
			</p>
		</div>







</body>
</html>
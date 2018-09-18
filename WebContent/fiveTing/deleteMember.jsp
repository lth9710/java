<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%	
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	String id = (String)session.getAttribute("id");

	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원탈퇴</title>


<script type="text/javascript">

	function sendIt(){
		
		var f = document.myForm;
		
		if(!f.pwd.value){
			alert("비밀번호를 입력하세요!");
			f.pwd.focus();
			return;
		}
		if(confirm("탈퇴하시겠습니까?")){
			
		f.action = "<%=cp%>/five/deleteMember_ok.do";	
		
		f.submit();

		}
		return false;
	}
	


</script>
</head>
<body>

<form action="" method="post" name="myForm">
${sessionScope.MemberInfo.id }님  회원 탈퇴 화면<br/><br/>
	
아이디:<input type="text" name="id" value="${sessionScope.MemberInfo.id }"><br/>
비밀번호:<input type="password" name="pwd">
<input type="button" value="회원탈퇴" onclick="sendIt();">
<input type="button" value="취소" onclick="<%=cp %>/five/loginMember.do">

</form>

${message }<br/>
<!-- 비밀번호 틀렸을시 -->






<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
</body>
</html>
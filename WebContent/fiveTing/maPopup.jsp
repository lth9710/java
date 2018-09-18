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
	    f.action="updateScore.do";
	    f.submit();
	}
</script>

</head>
<body>
<table width="600" border="0" cellpadding="0" cellspacing="0" align="center">
	<tr height="40">
		<td style="font-size: 40pt; text-align: center; color: #000000">
		매칭신청함
		</td>
	</tr>
</table>
<hr width="100" color="#d52349" align="center"/>
<hr width="50" color="#d52349" align="center"/>
<p><br/></p>



<form action="" name="ProfileForm" method="post" enctype="multipart/form-data">
<table border="0" width="500" cellspacing="0" cellpadding="1" align="center" style="text-align: left; font-size: 10pt;">
	

<table align="center" border="2">
	<tr>
		<td>
		<div style="overflow:scroll; width:550px; height:600px;" align="center">
		<!-- 스크롤바 height 조절  -->
		<table width="500" cellspacing="0" cellpadding="1" align="center" style="text-align: left; font-size: 10pt;" border="0">
			<tr style="font-size: 20"><b>친구목록</b></tr>
			<hr width="100" color="#d52349" align="center"/>
			<tr><td colspan="10" height="0.5" bgcolor="#dbdbdb"></td></tr>
					
			<tr>
				<td width="15%S"></td>			
				<td style="text-align: center; width: 10%" color: #d52349;"><b>ID</b></td>
				<td style="text-align: center; width: 20%" color: #d52349;"><b></b></td>
				<tr><td colspan="4" height="0.5" bgcolor="#dbdbdb"></td></tr>
			</tr>
			
			
			
			

			<c:forEach var="fdto" items="${fdto }">	
			<!-- 친구목록 -->

			<tr>
			<c:if test="${fdto.accept!=0 }">
							
				<td width="15%"></td>			
				<td style="text-align: center; width: 15%" color: #d52349;">			
				<a href="profileOther.do?m_id=${fdto.senderId }"color: #d52349;" >${fdto.senderId }</a><br/></td>
				<td style="padding: 7px; text-align: left; width: 10%" color: #d52349;">
					<img style="cursor:pointer" src="<%=cp %>/fiveTing/image/button/btn_listChat.png" onclick="javascript:location.href='chatting.do?id=${sessionScope.MemberInfo.id }&receiverId=${fdto.senderId }';">
				</td>	
			</tr>
			

			
			</c:if>
		
			</c:forEach>
			
			
		</table>
				<br/><br/><br/><br/><br/><br/>
		
		<table border="1">
		
			<table border="0" width="500" cellspacing="0" cellpadding="1" align="center" style="text-align: left; font-size: 10pt;">

				<tr style="font-size: 20"><B>신청목록</B></tr>	
				<hr width="100" color="#d52349" align="center"/>	
				<tr><td colspan="4" height="0.5" bgcolor="#dbdbdb"></td></tr>

				<c:forEach var="fdto" items="${fdto }">	
					<!-- 매칭신청한 아이디 정보 -->
				<c:if test="${fdto.accept!=1 }">
				
				<tr>
					<td style=" width: 1%"></td>
					<td style="text-align: center; width: 30%">${fdto.created }</td>
					<td style="text-align: left; width: 50%;" >
					<a href="profileOther.do?m_id=${fdto.senderId }" style="text-align: right;" >
						 ${fdto.senderId }</a>님이 매칭 신청을 하였습니다
					 </td>
					 <td>
					 <img style="cursor:pointer" src="<%=cp %>/fiveTing/image/button/btn_listOk.png" onclick="javascript:location.href='addFollow.do?senderId=${fdto.senderId }&receiverId=${sessionScope.MemberInfo.id }';"/>
					 </td>
					 <td>
					 <img style="cursor:pointer" src="<%=cp %>/fiveTing/image/button/btn_listNo.png" onclick="javascript:location.href='matchDeny.do?senderId=${fdto.senderId }&receiverId=${sessionScope.MemberInfo.id }';"/> 
					 </td>
				</tr>
				</c:if>
				</c:forEach>
			</table>
		</table>
		</div>

	</table>

	</td>
	</tr>
	
</table>



</form>
</body>
</html>

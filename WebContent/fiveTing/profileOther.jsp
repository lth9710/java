<%@page import="com.fiveTing.CustomInfoDTO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.fiveTing.FiveTingDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
#dialogoverlay{
	display: none;
	opacity: .7;
	position: fixed;
	top: 0px;
	left: 0px;
	background: #000000;
	width: 100%;
	z-index: 10;
}
#dialogbox{
	display: none;
	position: fixed;
	background: #FFFFFF;
	border-radius:7px; 
	border-right: 3px solid #A6A6A6;
	border-bottom: 3px solid #A6A6A6;
	width:350px;
	z-index: 10;
}
#dialogbox > div{ background:#FFFFFF; margin:8px; }
#dialogbox > div > #dialogboxhead{ font-weight: bold;  background: #FFFFFF; font-family: "Nanum Gothic"; text-align: center; font-size:17px; padding:10px; padding-top: 15px; color:#000000;}
#dialogbox > div > #dialogboxbody{ background: #FFFFFF; padding:0px; color:#000000; }
#dialogbox > div > #dialogboxfoot{ background: #FFFFFF; padding:10px; text-align:right; }
#dialogbox > div > #dialogboxfoot1{ background: #FFFFFF; padding:15px; padding-left:30px; text-align:left; float: left;}
#dialogbox > div > #dialogboxfoot2{ background: #FFFFFF; padding:15px; padding-right:30px; text-align:right; float: right; }
</style>
<link rel="stylesheet" type="text/css" href="style.css"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>

<script type="text/javascript">



function showScorePopup(u_id){
	
	var popOption = "width=270, height=400, left=800, top=300, resizable=no, scrollbars=no";
	window.open("scorePopup.do?u_id="+u_id,"", popOption);
}
function showProfilePopup(){
	var popOption = "width=630, height=800, left=800, top=300, resizable=no, scrollbars=no";
	window.open("profileOther.do","", popOption);
}

</script>
<script>
function CustomAlert(){
    this.render = function(dialog){
        var winW = window.innerWidth;
        var winH = window.innerHeight;
        var dialogoverlay = document.getElementById('dialogoverlay');
        var dialogbox = document.getElementById('dialogbox');
        dialogoverlay.style.display = "block";
        dialogoverlay.style.height = winH+"px";
        dialogbox.style.left = (winW/2) - (550 * .3)+"px";
        dialogbox.style.top = "200px";
        dialogbox.style.display = "block";
        document.getElementById('dialogboxhead').innerHTML = "매칭을 신청하시겠습니까?";
        /* document.getElementById('dialogboxbody').innerHTML = "매칭을 신청하시겠습니까?"; */
        document.getElementById('dialogboxfoot1').innerHTML = '<img src="<%=cp %>/fiveTing/image/button/btn_ok.png" style="cursor:pointer" onclick="Alert.accept()">';
        document.getElementById('dialogboxfoot2').innerHTML = '<img src="<%=cp %>/fiveTing/image/button/btn_no.png" style="cursor:pointer" onclick="Alert.ok()">';
    }
	this.ok = function(){
		/* var f = document.ProfileForm;
		f.action="five/matchDeny.do";
		f.submit(); */
		document.getElementById('dialogbox').style.display = "none";
		document.getElementById('dialogoverlay').style.display = "none";
	}
	this.close = function(){
		
		document.getElementById('dialogbox').style.display = "none";
		document.getElementById('dialogoverlay').style.display = "none";
		
		
	}
	
	this.accept = function(){
		var f = document.ProfileForm;
		f.action="five/matchAccept.do?senderId=${sessionScope.MemberInfo.id }&receiverId=${id}";
		f.submit(); 
		/* window.open("matchAccept.do?senderId=${sessionScope.MemberInfo.id }&receiverId=${id}",'popup','width=400,heigth=300') */
		
		document.getElementById('dialogbox').style.display = "none";
		document.getElementById('dialogoverlay').style.display = "none";
	}
	
	
	
	
}
var Alert = new CustomAlert();

</script>
<title>Profile</title>

</head>
<body leftmargin="8">
<div id="dialogoverlay"></div>
<div id="dialogbox">
  <div>
    <img src="<%=cp %>/fiveTing/image/icon/icon_message.png" style="margin-left: 150px;" width=35 height=35/>
    <div id="dialogboxhead"></div>
    <hr width="50" color="#d52349" align="center"/>
    <div id="dialogboxbody"></div>
    <div id="dialogboxfoot1"></div>
    <div id="dialogboxfoot2"></div>
  </div>
</div>
<br/>
<table width="600" border="0" cellpadding="0" cellspacing="0" align="center">
	<tr height="40">
		<td style="font-size: 40pt; text-align: center; color: #000000">
		Profile
		</td>
	</tr>
</table>
<hr width="100" color="#d52349" align="center"/>
<hr width="50" color="#d52349" align="center"/>

<p><br/></p>

<form action="" name="ProfileForm" method="post" enctype="multipart/form-data">
<table border="0" width="500" cellspacing="0" cellpadding="1" align="center" style="text-align: left; font-size: 10pt;">
	<tr>
		<td width="150" height="150">
			<img border="0" src="${imagePath }/profile/${picture }" width="150" height="150" style="border-color: #d52349;"/>
		</td>
		<td style="padding-left: 80pt">
			<table style="padding-left: 25pt;border-color: #d52349;" cellpadding="5px" align="left">
				<tr>
					<td style="text-align: right; color: #d52349;"><b>NAME </b></td>
					<td width="10px"></td>
					<td>${name }</td>
				</tr>
				<tr>
					<td style="text-align: right;"><b>SEX </b></td>
					<td width="10px"></td>
					<td>${gender }</td>
				</tr>
				<tr>
					<td style="text-align: right;"><b>AGE </b></td>
					<td width="10px"></td>
					<td>${age }</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr><td height="10"></td></tr>
	<tr><td colspan="4" height="0.5" bgcolor="#dbdbdb"></td></tr>
	<tr height="10px">
		<td></td>
	</tr>
	<tr>
		<td width="150" height="150" style="text-align: center; font-size: 13pt;">
			Detail
		</td>
		<td style="padding-left: 80pt">
			<table border="0" cellpadding="5px" align="left">
				<tr>
					<td style="text-align: right;"><b>ID </b></td>
					<td width="10px"></td>
					<td>${id }</td>
				</tr>
				<tr>
					<td style="text-align: right;"><b>JOB </b></td>
					<td width="10px"></td>
					<td>${job }</td>
				</tr>
				<tr>
					<td style="text-align: right;"><b>Address </b></td>
					<td width="10px"></td>
					<td>${address }</td>
				</tr>
				<tr>
					<td style="text-align: right;"><b>Height </b></td>
					<td width="10px"></td>
					<c:if test="${height eq '1' }">
					<td>150이하</td>
					</c:if>
					<c:if test="${height eq '2' }">
					<td>151-155</td>
					</c:if>
					<c:if test="${height eq '3' }">
					<td>156-160</td>
					</c:if>
					<c:if test="${height eq '4'}">
					<td>161-165</td>
					</c:if>
					<c:if test="${height eq '5' }">
					<td>166-170</td>
					</c:if>
					<c:if test="${height eq '6' }">
					<td>170-175</td>
					</c:if>
					<c:if test="${height eq '7' }">
					<td>176-180</td>
					</c:if>
					<c:if test="${height eq '8' }">
					<td>181-185</td>
					</c:if>
					<c:if test="${height eq '9' }">
					<td>186이상</td>
					</c:if>
				</tr>
				<tr>
					<td style="text-align: right;"><b>Body Shape </b></td>
					<td width="10px"></td>
					<c:if test="${body eq 's' }">
					<td>마름</td>
					</c:if>
					<c:if test="${body eq 'm' }">
					<td>보통</td>
					</c:if>
					<c:if test="${body eq 'l' }">
					<td>통통</td>
					</c:if>
					<c:if test="${body eq'xl' }">
					<td>뚱뚱</td>
					</c:if>
				</tr>
				<tr>
					<td style="text-align: right;"><b>📞 </b></td>
					<td width="10px"></td>
					<td>${tel }</td>
				</tr>
				<tr>
					<td style="text-align: right;"><b>Face </b></td>
					<td width="10px"></td>
					<c:choose>
						<c:when test="${score >= 80}">
							<td>완벽</td>
						</c:when>
						<c:when test="${score >= 60}">
							<td>훈훈</td>
						</c:when>
						<c:when test="${score >= 40}">
							<td>평범</td>
						</c:when>
						<c:when test="${score >= 20}">
							<td>못남</td>
						</c:when>
						<c:otherwise>
							<td>절망</td>
						</c:otherwise>
					</c:choose>
				</tr>
			</table>
		</td>
	</tr>
</table>
<hr width="500" color="#dbdbdb"/>
<table width="500" border="0" cellpadding="5px" align="center">
	<tr>
		<td width="140" height="100" style="text-align: center; font-size: 13pt;">
			Content
		</td>
		<td width="10">
		</td>
		<td style="padding-left: 10pt">
			<table width=200 border="0" style="font-size: 10pt; text-align: right;">
				<tr>
					<td>
						${content }
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<input type="hidden" name="senderId" value="${sessionScope.MemberInfo.id }"/>
</form>
<br/>
<table align="center">
	<tr>
		<td align="center">
		<img src="${imagePath }/button/btn_asking.png" onclick="Alert.render();" style="cursor:pointer"/>
		</td>
		<td width="50"></td>
		<td align="center">
		<img src="${imagePath }/button/btn_givingScore.png" onclick="showScorePopup('${u_id}');" style="cursor:pointer"/>
		</td>
	</tr>
</table>

</body>
</html>

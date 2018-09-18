<%@page import="org.apache.catalina.Session"%>
<%@ page  contentType="text/html; charset=UTF-8"%>

<% request.setCharacterEncoding("utf-8"); 
	
	String id = request.getParameter("id");
	String receiverId = request.getParameter("receiverId");
%>


  


<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#dialogoverlay{
	display: none;
	opacity: .8;
	position: fixed;
	top: 0px;
	left: 0px;
	background: #FFF;
	width: 100%;
	z-index: 10;
}
#dialogbox{
	display: none;
	position: fixed;
	background: #000;
	border-radius:7px; 
	width:550px;
	z-index: 10;
}
#dialogbox > div{ background:#FFF; margin:8px; }
#dialogbox > div > #dialogboxhead{ background: #666; font-size:19px; padding:10px; color:#CCC; }
#dialogbox > div > #dialogboxbody{ background:#333; padding:20px; color:#FFF; }
#dialogbox > div > #dialogboxfoot{ background: #666; padding:10px; text-align:right; }
#dialogbox > div > #dialogboxfoot1{ background: #666; padding:10px; text-align:left; float: left;}
#dialogbox > div > #dialogboxfoot2{ background: #666; padding:10px; text-align:right; float: right; }
</style>
<link rel="stylesheet" type="text/css" href="style.css"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>

<script type='text/javascript'>
	<%-- function matchfunction()
	{
		if(confirm("매칭을 신청하시겠습니까?"))
		{
			window.open("chatting.do?id=<%=id%>",'popup','width=375,heigth=200')
			
					}
		
	} --%>
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
        dialogbox.style.left = (winW/2) - (550 * .5)+"px";
        dialogbox.style.top = "100px";
        dialogbox.style.display = "block";
        document.getElementById('dialogboxhead').innerHTML = "매칭확인";
        document.getElementById('dialogboxbody').innerHTML = "매칭을 수락하시겠습니까?";
        document.getElementById('dialogboxfoot1').innerHTML = '<button onclick="Alert.accept()">수락</button>&nbsp;';
        document.getElementById('dialogboxfoot2').innerHTML = '<button onclick="Alert.ok()">거절</button>';
    }
	this.ok = function(){
		document.getElementById('dialogbox').style.display = "none";
		document.getElementById('dialogoverlay').style.display = "none";
	}
	this.close = function(){
		document.getElementById('dialogbox').style.display = "none";
		document.getElementById('dialogoverlay').style.display = "none";
	}
	
	this.accept = function(){
		
		window.open("chatting.do?id=<%=id%>&receiverId=<%=receiverId%>",'popup','width=400,heigth=300')
		document.getElementById('dialogbox').style.display = "none";
		document.getElementById('dialogoverlay').style.display = "none";
	}
	
	
	
	
}
var Alert = new CustomAlert();
</script>
</head>

<body leftmargin="8">
<div id="dialogoverlay"></div>
<div id="dialogbox">
  <div>
    <div id="dialogboxhead"></div>
    <div id="dialogboxbody"></div>
    <div id="dialogboxfoot1"></div>
    <div id="dialogboxfoot2"></div>
    
  </div>
</div>

<table cellSpacing=0 cellPadding=0 border=0 width="700">
<tr>
  <td align="center">매칭신청</td>
</tr>
<tr>
<td align="center">
 <button type="button" class="btn btn-danger " onclick="Alert.render();">매칭신청</button>
</td>

</tr>
</table>

</body>
</html>
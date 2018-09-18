<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">


function emailCheck(){
		
		var f = document.myform3;
		
		var clength = f.sel1.options.length;
		
		var cvalue = f.sel1.selectedIndex;
		
		f.ans1.value = "";
		
		if(cvalue==(clength-1)){ // 직접입력 (마지막순서 옵션)
		
			f.ans1.readOnly = false;
			f.ans1.focus();
		}else{
			f.ans1.value = 
				f.sel1.options[cvalue].value;
			f.ans1.readOnly=true;
		}
		
	}


function emailCheck2(){
	
	var f = document.myform3;
	
	var clength = f.sel2.options.length;
	
	var cvalue = f.sel2.selectedIndex;
	
	f.email2.value = "";
	
	if(cvalue==(clength-1)){ // 직접입력 (마지막순서 옵션)
	
		f.email2.readOnly = false;
		f.email2.focus();
	}else{
		f.email2.value = 
			f.sel2.options[cvalue].value;
		f.email2.readOnly=true;
	}
	
}


function onlyNum(){
	
	if(event.keyCode < 48 || event.keyCode > 57)
		event.returnValue = false;
	
}

function idCheck(){
	var f = document.myform3;
	if(!f.userId.value){
		alert("아이디를 입력하세요!");
		f.userId.focus();
		return;
	}
}



function sendIt() {
	
	var f = document.myform3;
	var cvalue1;
	var cvalue2;
	
	cvalue1 = f.check1.checked;
	cvalue2 = f.check2.checked;
	
	if(!f.userName.value){
		alert("이름을 입력하세요!");
		f.userName.focus();
		return;
	}
	
	if(!f.userId.value){
		alert("아이디를 입력하세요!");
		f.userId.focus();
		return;
	}
	
	if(!f.users.value){
		alert("별명을 입력하세요!");
		f.users.focus();
		return;
	}
	
	if(!f.userPwd.value){
		alert("패스워드를 입력하세요!");
		f.userPwd.focus();
		return;
	}
	
	if(!f.userPwd.value==f.userPwd2.value){
		alert("비밀번호 불일치");
		f.userPwd.focus();
		return;
	}
	
	
	
	
	
	if(!(f.sel1.value&& f.ans2.value)){
		alert("비밀번호 질문,답을 입력하세요!");
		f.ans2.focus();
		return;
	}
	
	if(!cvalue1){
	
	if(!(f.email1.value&& f.sel2.value)){
		alert("이메일을 입력하세요!");
		f.email1.focus();
		return;
		
		}
	}
	
	if(!cvalue2){
	if(!(f.tel1.value&&f.tel2.value&&f.tel3.value)){
		alert("휴대폰번호를 입력하세요!")
		f.tel2.focus();
		return;
		}
	}
	
	alert("가입 성공!!");
	
	f.action="naver_ok.jsp";
	
	f.submit();
	
	
}


function check1Option(){
	
	var f = document.myform3;
	
	
	
	if(f.check1.checked){
		f.email1.value = "";
		f.email2.value = "";
		f.sel2.value = "";
		f.email1.readOnly=true;
	}else{
		f.email1.readOnly=false;
		
	}
}

function check2Option(){
	
	var f = document.myform3;
	
	if(f.check2.checked){
		f.tel1.value="";
		f.tel2.value="";
		f.tel3.value="";
		f.tel2.readOnly=true;
		f.tel3.readOnly=true;
	}else{
		f.tel2.readOnly=false;
		f.tel3.readOnly=false;
		
	}
	
	
}



</script>
</head>
<body>

<b>회원정보입력</b><br/>
<img src="../html1/image/2naver1.PNG" width="100%">
<img src="../html1/image/2naver2.PNG" width="100%">


<form action="" name="myform3">

<table border="1" bordercolor="#D5D5D5" cellpadding="0" cellspacing="0" width="100%">
<tr>
	<td width="155" height="40"><img src="../html1/image/2naver3.PNG" width="100%"></td> 
	<td colspan="4">&nbsp;&nbsp; <input type="text" align="middle" name="userName"></td>
</tr>

<tr>
	<td rowspan="2"><img src="../html1/image/2naver4.PNG" width="100%"></td> 
	<td colspan="4">&nbsp;&nbsp; <input type="text" align="middle" name="userId"> ＠naver.com <input type="button" value="중복확인" onclick="idCheck();"/>	</td> 
</tr>

<tr>
	<td colspan="4" style="font-size: 7pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;입력하신 아이디로 네이버 이메일 주소가 생성됩니다.</td>
</tr>	

<tr>
	<td width="155" height="40"><img src="../html1/image/2naver5.PNG" width="100%"></td>
	<td colspan="4">&nbsp;&nbsp; <input type="text" align="middle" name="users">
</tr>

<tr>
	<td width="155" height="40"><img src="../html1/image/2naver6.PNG" width="100%"></td>
	<td colspan="4">&nbsp;&nbsp; <input type="text" align="middle" name="userPwd"> <a href="" style="font-size: 5pt;">비밀번호 도움말</a></td>
</tr>

<tr>
	<td width="155" height="40"><img src="../html1/image/2naver7.PNG" width="100%"></td>
	<td colspan="4">&nbsp;&nbsp; <input type="text" align="middle" name="userPwd2">
</td>

<tr>
	<td rowspan="10"><img src="../html1/image/2naver8.PNG" width="100%"></td> 
	<td  colspan="4" style="font-size:7pt;color: #B77300" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;아래 항목은 아이디 확인, 임시번호 발급 시 반드시 필요한 정보입니다.<br/>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;정확한 정보를 입력한 후 꼭 기억해 주세요.</td>
</tr>

<tr>
	<td colspan="4" style="font-size: 10pt;"><b>&nbsp;&nbsp;&nbsp;&nbsp;1.비밀번호 질문·답</b></td>
</tr>	

<tr>
	<td colspan="4" style="font-size: 7pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;질문 
	<select name="sel1" onchange="emailCheck();">
	<option>가장 기억에 남는 장소는?</option>
	<option>1</option>
	<option>2</option>
	<option>직접입력</option>
	</select>
	</td>
</tr>
	
<tr>
	<td colspan="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <input type="text" name="ans1" readonly="readonly" style="background-color: #EAEAEA;
	 "
	/></td>
</tr>

<tr>
	<td colspan="4" style="font-size: 7pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;답변
	<input type="text" name="ans2" >
	</td>
	
</tr>

<tr>
	<td colspan="4" style="font-size: 10pt;"><b>&nbsp;&nbsp;&nbsp;&nbsp;2. 이메일 주소</b></td>
</tr>

<tr>
	<td colspan="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="email1" /> ＠ <input type="text" name="email2" readonly="readonly">
	&nbsp; <select name="sel2" onchange="emailCheck2();">
	<option value="">선택하세요</option>
	<option value="naver.com">네이버</option>
	<option value="hanmail.net">다음</option>
	<option value="gmail.com">구글</option>
	<option value="yahoo.co.kr">야후</option>
	<option value="">직접입력</option> 
	</select>
	<input type="checkbox" name="check1" style="font-size: 7pt;" onchange="check1Option();"> 등록 안함 
	</td>
</tr>

<tr>
	<td colspan="4" style="font-size: 10pt;"><b>&nbsp;&nbsp;&nbsp;&nbsp;3. 휴대폰 번호</b></td>

</tr>

<tr>
	<td colspan="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<select name="tel1">
	<option value="">선택</option>
	<option value="011">011</option>
	<option value="010">010</option>
	<option value="070">070</option>
</select>
<input type="text" name="tel2" onkeypress="onlyNum();"/> 
-
<input type="text" name="tel3" onkeypress="onlyNum();"/>
<input type="checkbox" name="check2" style="font-size: 7pt;" onchange="check2Option();"> 등록 안함 
</td>
</tr>

<tr>
<td></td>
</tr>



<tr>
	<td rowspan="2"><img src="../html1/image/2naver9.PNG" width="100%"></td>
	<td colspan="4"  rowspan="2">&nbsp;&nbsp; <input type="checkbox" name="mails" style="font-size: 3pt;"> 네이버 메일로 네이버 소식지를 수신합니다.
</tr>
	


</table>

</form>

<p align="center"><button onclick="sendIt();"><img src="../html1/image/2naver.10.PNG"  border="0;"> </button></p>






<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>



</body>
</html>
<%@ page contentType="text/html; charset=UTF-8"%>
<%	
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

	function sendIt(val){
		
		var f = document.myForm1;
		//var f = document.forms[0] //폼여러개사용하면 자동인덱스부여됨
		
		
		if(!f.name.value){
			alert("이름!!");
			f.name.focus();
			return;
		}
		
		if(val=='a')
			f.action = "test6a_ok.jsp";
		else
			f.action = "test6b_ok.jsp";
	
		f.submit();
		
		
	}

	function sendData(){
		
		var f =document.myForm2;
		//var f =document.forms[1];
		
		if(!f.name.value){
			alert("이름!!");
			f.name.focus();
			return;
		}
		f.submit();
		
		
	}

	
	
	
	
	

</script>


</head>
<body>

<!-- button에서 데이터검사 -->
<form action="" method="post" name="myForm1">
이름:<input type="text" name="name"/><br/>

<input type="button" value="첫번째 전송" onclick="sendIt('a')"/>
<input type="button" value="두번째 전송" onclick="sendIt('b')"/>

</form>

<br/><br/>


<!-- submit에서 데이터검사 -->

<form action="" method="post" name="myForm2" 
onsubmit="return sendData();">
이름:<input type="text" name="name"/><br/>

<input type="submit" value="첫번째 전송" onclick="this.form.action='test6a_ok.jsp';"/>
<input type="submit" value="두번째 전송" onclick="this.form.action='test6b_ok.jsp';"/>


</form>
<form action="" method="post" name="myForm3">



</form>






<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>



</body>
</html>
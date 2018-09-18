<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

	var str;

	str = "자바스크립트 어렵다!!";
	
	document.write(str + "<br/>");

	str = "문자열!!";
	document.write(str+ ":" +typeof(str) + "<br/>");

	str = 123;
	document.write(str+ ":"+ typeof(str) + "<br/>");
	
	str = true;
	document.write(str+ ":" +typeof(str) + "<br/>");
	document.write("<br/><br/>");
	//--------------------------------------------------
	
	var hello = "함수밖 전역변수";
	function thisFunction(){
		
		var hello = "함수안 지역변수-hello";
		global = "함수안 전역변수"; //함수안전역변수줄때는 var 생략하면됨
		var local = "함수안 지역변수-local";
	
		document.write("함수 안에서 출력...<br/>");
		document.write(hello + "<br/>");
		document.write(global+ "<br/>");
		document.write(local+ "<br/>");
		document.write("<br/><br/>");
		
	}
	
	thisFunction();
	
	document.write("함수 밖에서 출력...<br/>");
	document.write(hello + "<br/>");
	document.write(global+ "<br/>");
	//document.write(local+ "<br/>"); // 에러임 => local은 지역변수이기떄문에 출력이되지않음( 자바스크립트는 에러를 잡아주지않음)
	document.write("<br/><br/>");
	
	var num1=20, num2=3;
	document.write("num1 + num2 = " + (num1 + num2) + "<br/>");
	document.write("num1 - num2 = " + (num1 - num2) + "<br/>");
	document.write("num1 * num2 = " + (num1 * num2) + "<br/>");
	document.write("num1 / num2 = " + (num1 / num2) + "<br/>");
	document.write("num1 % num2 = " + (num1 % num2) + "<br/>");
	document.write("<br/><br/>");
	
	document.write("num1 > num2 = " + (num1 > num2) + "<br/>");
	document.write("num1 < num2 = " + (num1 < num2) + "<br/>");
	document.write("num1 >= num2 = " + (num1 >= num2) + "<br/>");
	document.write("num1 <= num2 = " + (num1 <= num2) + "<br/>");
	document.write("num1 == num2 = " + (num1 == num2) + "<br/>");
	document.write("num1 != num2 = " + (num1 != num2) + "<br/>");
	document.write("<br/><br/>");
	
	var answer;
	answer = 0;
	if(answer>0){
		document.write("양수!");
	}else if(answer<0){
		document.write("음수!");
	}else{
		document.write("영!");
	}
	document.write("<br/><br/>");
	
	for(var i=1;i<=10;i++){
		document.write(i + "<br/>");
	}
	
	document.write("<br/><br/>");
	
	var j=1
	while(j<=10){
		document.write(j + "\t");
		j++;
	}
	
	document.write("<br/><br/>");
	
	

	document.write("함수 밖!!!<br/>");
	
	test1();
	
	function test1(){
		document.write("함수 안!!!<br/>");
	}
	
	test1();
	
	
	
	
	
</script>

</head>
<body onload="test1();">













<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
</body>
</html>
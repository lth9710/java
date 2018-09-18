<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

	function fImg(csrc){
		
		window.document.images["img1"].src = csrc;
		
		
	}

	function textCopy(){
		
		var cvalue;
		cvalue = window.document.myform.check1.checked;

		if(cvalue){
		
			document.myform.client2.value =
				document.myform.client1.value
			
		}else{
			document.myform.client2.value = "";
		}
		
		
	}
	
	function fCheck1(){

		var clength;
		clength = document.myform1["chk"].length; //chk가 여러개가있으므로 이럴떄 [] 이렇게사용해줌
		
		for(var i=0;i<clength;i++){
			document.myform1["chk"][i].checked=true;
		}
		
	}
	
	function fCheck2(){
		

		var clength;
		clength = document.myform1["chk"].length; //chk가 여러개가있으므로 이럴떄 [] 이렇게사용해줌
		
		for(var i=0;i<clength;i++){
			document.myform1["chk"][i].checked=false;
		}
		
		
	}
	
	function poll(){
		
		var clength;
		clength = document.myform2.r1.length;
		
		for(var i=0;i<clength;i++){
			
			if(document.myform2.r1[i].checked){
				alert(document.myform2.r1[i].value + "가 가장 이쁨!");
				return;
			}
			
		}
		alert("투표하세요!!");
		
		
		
	}

	function emailCheck(){
		
		var f = document.myform3;
		
		var clength = f.sel1.options.length;
		
		var cvalue = f.sel1.selectedIndex;
		
		f.email2.value = "";
		
		if(cvalue==(clength-1)){ // 직접입력 (마지막순서 옵션)
		
			f.email2.readOnly = false;
			f.email2.focus();
		}else{
			f.email2.value = 
				f.sel1.options[cvalue].value;
			f.email2.readOnly=true;
		}
		
	}
	
	
	

</script>




</head>
<body>

<img src="../html1/image/13798939b.jpg"
width="300" height="300" name="img1"><br/> 

<img src="../html1/image/13798939c.jpg"
width="80" height="80" border="1" 
style="cursor: hand" onmouseover="fImg('../html1/image/13798939c.jpg')">

<img src="../html1/image/13798939e.jpg"
width="80" height="80" border="1" 
style="cursor: hand" onmouseover="fImg('../html1/image/13798939e.jpg')">

<img src="../html1/image/13798939f.jpg"
width="80" height="80" border="1" 
style="cursor: hand" onmouseover="fImg(this.src)">

<br/><br/><br/>

<form action="" name="myform">

주문고객 정보-주소
<input type="text" size="40" name="client1"/>
<input type="checkbox" name="check1" onclick="textCopy();" /> 
배송장소가 위와 동일<br/>
배송장소 정보-주소
<input type="text" size="40" name="client2"/><br/>

 

</form>

<br/><br/><br/>

<form action="" name="myform1">
<a href="javascript:fCheck1();">전체선택</a>/
<a href="javascript:fCheck2();">전체해제</a><br/>

<input type="checkbox" name="chk">대한민국<br/>
<input type="checkbox" name="chk">일본<br/>
<input type="checkbox" name="chk">중국<br/>
<input type="checkbox" name="chk">미국<br/>


</form>

<br/><br/><br/>

<form action="" name="myform2">

<img src="../html1/image/icon_poll_q.gif">
<b>가장 연기 잘하는 연예인</b>
<br/><br/>
<input type="radio" name="r1" value="배수지">배수지<br/>
<input type="radio" name="r1" value="김태리">김태리<br/>
<input type="radio" name="r1" value="한효주">한효주<br/>
<input type="radio" name="r1" value="김태희">김태희<br/>
<input type="radio" name="r1" value="박신혜">박신혜<br/>

<a href="javascript:poll();">
<img alt="" src="../html1/image/btn_poll01.gif" border="0"/>
</a>

</form>
<br/><br/><br/>

<form action="" name="myform3">

email주소
<input type="text" name="email1"/>
@
<input type="text" name="email2" readonly="readonly"/>
<select name="sel1" onchange="emailCheck();">
<option value="">선택하세요</option>
<option value="naver.com">네이버</option>
<option value="hanmail.net">다음</option>
<option value="gmail.com">구글</option>
<option value="yahoo.co.kr">야후</option>
<option value="">직접입력</option>

</select>

</form>


<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>



</body>
</html>
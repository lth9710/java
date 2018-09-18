<%@page import="javax.websocket.Session"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.util.DBCPConn"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.fiveTing.ChatDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=cp%>/fiveTing/css/chatting.css"
	type="text/css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	
<script type="text/javascript">

function pageScroll() {
	location.reload();
	window.scrollBy(0,window.innerHeight); 
	
}
</script>
	
	
	
</head>

<body>


	<%-- <div class="chat">
<c:forEach  items="${lists }" var="dto">
<c:if test="${dto.id==id}">
<ul class="from_you">
<li>
<span class="nm">${dto.id }</span>
<span class="co">${dto.content }</span>
<span class="tm">${dto.created }</span>
</li>
</ul>
</c:if>
<c:if test="${dto.id!=id }">
<ul class="from_me">
<li>
<span class="nm">${dto.id }</span>
<span class="co">${dto.content }</span>
<span class="tm">${dto.created }</span>
</li>
</ul>
</c:if>
<br/>
</c:forEach>
</div>
</div> --%>

	<div class="reply_list" align="center"
		style="width: 100%; ">
		<c:forEach items="${lists }" var="dto">
			<!-- id가 내것인것만출력 -->
			<c:if test="${dto.id==id}">
				<div class="name" align="right" style="padding-right: 50px;">${id}
				</div>
				<div class="my_con">
					<div class="my_reply">

						<div class="txt">
							<p>${dto.content }</p>
						</div>
					</div>
				</div>
				<br />
			</c:if>
			<!-- id가 상대방것인것만출력 -->
			<c:if test="${dto.id!=id }">
				<div class="name" style="text-align: left; padding-left: 50px;">${receiverId}
				</div>
				<div class="other_con">
					<div class="other_reply">
						<div class="txt">
							<p>${dto.content }</p>
						</div>
					</div>
				</div>
				<br />
			</c:if>
		</c:forEach>
	</div>

	<div id="inner_center" align="center" >
		<form>
			<!-- 송신 메시지 작성하는 창 -->
			<input id="textMessage" type="text" value="${sessionScope.MemberInfo.id }"
				style="width: 65%; float: left;">

			<!-- 송신 버튼 -->
			<input onclick="sendMessage()" value="확인" type="button"
				class="btn btn-primary" style="float: left;">&nbsp;
			<!-- 종료 버튼 -->
			<input onclick="disconnect()" value="연결종료" type="button"
				class="btn btn-primary" style="float: left">&nbsp; <input
				onclick="pageScroll()" value="보내기" type="button"
				class="btn btn-primary" style="float: left;">&nbsp;
		</form>
		<br />
		<!-- 결과 메시지 보여주는 창 -->
		<textarea id="messageTextArea" rows="5" cols="175"
			style="float: left;"></textarea>
	</div>
	
	<script type="text/javascript">
		//WebSocketEx는 프로젝트 이름
		//websocket 클래스 이름
		var webSocket = new WebSocket("ws://192.168.16.5:8080/study/websocket");
		var messageTextArea = document.getElementById("messageTextArea");
		webSocket.onmessage = function processMessage(message) {
			//json풀기
			var jsonData = JSON.parse(message.data);
			if (jsonData.message != null) {
				messageTextArea.value += jsonData.message + "\n"
			}
			;
		}

		//웹 소켓이 연결되었을 때 호출되는 이벤트
		webSocket.onopen = function(message) {
 			messageTextArea.value += "ID를 입력해주세요...\n"; 
		};
		//웹 소켓이 닫혔을 때 호출되는 이벤트
		webSocket.onclose = function(message) {
			messageTextArea.value += "연결종료...\n";
		};
		//웹 소켓이 에러가 났을 때 호출되는 이벤트
		webSocket.onerror = function(message) {
			messageTextArea.value += "error...\n";
		};
		//웹 소켓에서 메시지가 날라왔을 때 호출되는 이벤트
		webSocket.onmessage = function(message) {
			/* messageTextArea.value += "전송할 내용을입력해주세요" + "\n"; */
			/* messageTextArea.value += "Recieve From Server => "+message.data+"\n"; */
		};
		//Send 버튼을 누르면 실행되는 함수
		function sendMessage() {
			
			
			
			/* var senderId = document.getElementById("senderId");//수정2 */  
			var message = document.getElementById("textMessage");
			messageTextArea.value += message.value + "\n";
			//웹소켓으로 textMessage객체의 값을 보낸다.
			webSocket.send(message.value);
			/* webSocket.send(userSession.setUserProperties().set(senderId.value)); *///수정3
			/* webSocket.send(senderId.value); */
			
			
			/* webSocket.send(senderId.value); */
			//여기서 senderId를 보내서 읽어오고싶었지만 실패..            
			//textMessage객체의 값 초기화
			message.value = "";
			/* senderId.value = "";*/
			 window.scrollBy(0,50); // horizontal and vertical scroll increments
			

		}
		//웹소켓 종료
		function disconnect() {
			webSocket.close();
		}
	</script>



</body>
</html>



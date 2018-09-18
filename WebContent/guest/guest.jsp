<%@page import="com.util.MyUtil"%>
<%@page import="com.guest.GuestDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.guest.GuestDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.net.URLDecoder"%>


<%@ page contentType="text/html; charset=UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String cp = request.getContextPath();
	
	Connection conn = DBConn.getConnection();
	GuestDAO dao = new GuestDAO(conn);
	
	MyUtil myUtil = new MyUtil();
	
	//client한테 넘어온 페이지 번호
	String pageNum = request.getParameter("pageNum");
	
	int currentPage = 1;
	
	
	
	
	//처음실행시 null
	if(pageNum!=null)
		currentPage = Integer.parseInt(pageNum); 
	
	if(pageNum==null)
		pageNum= "1";
	
	
	//전체데이터구하기
	int dataCount = dao.getDataCount();
	
	//전체 데이터를 기준으로 총 페이지수 계산
	int numPerPage = 5;
	int totalPage =
			myUtil.getPageCount(numPerPage, dataCount);
	
	//삭제로 인해 전체페이지수보다 표시할 페이지수가 큰경우 페이지조절
	if(currentPage>totalPage)
		currentPage=totalPage;
	
	//데이터베이스에서 가져올 시작과 끝위치 
	int start = (currentPage-1)*numPerPage+1;
	int end = currentPage*numPerPage;
	
	
	
	
	List<GuestDTO> lists = dao.getLists(start,end);
	
	
	//페이징 처리
	String listUrl = "guest.jsp";
	String pageIndexList =
			myUtil.pageIndexList(currentPage, totalPage, listUrl);
	
	
	DBConn.close();
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>방 명 록</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<link rel="stylesheet" href="<%=cp%>/guest/data/style.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/guest/data/created.css" type="text/css"/>
<script type="text/javascript" src="<%=cp%>/guest/data/guest.js"></script>
<script type="text/javascript">


function check(num) {
	
	
	var f=document.myForm;
	var up;
	var getNum = num;
	var getpageNum = pageNum; 
	
	up= confirm("삭제 하시겠습니까? ");
	
	if(up){
		f.action="/study/guest/delete.jsp?num=" + getNum + "&pageNum="+getpageNum;
        f.submit();
		
	}else{
		return;
	}
	
}



</script>
</head>

<body>
<!-- 작성========================================== -->
<div id="bbs">
	<div id="bbs_title">
	방 명 록(JDBC 사용)
	</div>

	<form name="myForm" method="post" action="">
	<div id="bbsCreated">
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>작성자</dt>
				<dd>
				      <input type="text" name="name" size="74" maxlength="100"  class="boxTF" />
				</dd>
			</dl>
		</div>

		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>E-Mail</dt>
				<dd>
				      <input type="text" name="email" size="35" maxlength="50" class="boxTF" />
				</dd>
			</dl>
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>홈페이지</dt>
				<dd>
				      <input type="text" name="homepage"  value="http://"	size="35" maxlength="50" class="boxTF" />
				</dd>
			</dl>
		</div>

		<div id="bbsCreated_content">
			<dl>
				<dt>내&nbsp;&nbsp;&nbsp;&nbsp;용</dt>
				<dd>
				      <textarea name="content" cols="63" rows="12" class="boxTA"></textarea>
				</dd>
			</dl>
		</div>
	</div>

	<div id="bbsCreated_footer">
        <input type="button" value=" 등록하기 " class="btn2"
         onclick="sendIt();"/>
        <input type="reset" value=" 다시입력 " class="btn2"
         onclick="document.myForm.subject.focus();"/>
	</div>

    </form>


<!-- 리스트====================================================== -->

<div id="bbsList">
	<div id="bbsList_list">
		
		<div id="lists">
		<%for(GuestDTO dto : lists){ %>	
			<div id="bbsCreated">
			<div class="bbsCreated_bottomLine">
				<dl>
					<dt style="width: 305px; padding-left: 0px; font-size: 12px; font-style: oblique;"><b>NO <%=dto.getNum() %>.&nbsp;<%=dto.getName() %>
					(<%=dto.getEmail() %>)</b></dt>
					
					<dd style="width: 285px; background-color: #EEEEEE; text-align: right; vertical-align: middle;">홈페이지 : &nbsp;<a href="<%=dto.getHomepage() %>" target="blank_"><%=dto.getHomepage() %></a></dd>
					<dt style="width: 305px; padding-left: 0px">&nbsp;작성일 : <%=dto.getCreated() %> &nbsp;(<%=dto.getIpAddr()%>)</dt>
					<dd style="width: 285px; background-color: #EEEEEE; text-align: right; onclick=""><input type="button"<%-- href="<%=cp%>/guest/delete.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>" --%> onclick="check(<%=dto.getNum()%>)" value="삭제"/></dd>
				</dl>
			</div>
	
			<div class="bbsCreated_bottomLine">
				<dl style="word-break: break-all;">&nbsp;<%=dto.getContent() %></dl>
			</div>
			</div>	
		<%} %>
		</div>
		<div id="footer">
			<p>
				<%if(dataCount!=0){ %>
					<%=pageIndexList %>
				<%}else{ %>
					등록된 게시물이 없습니다.
				<%} %>
			</p>
		</div>
	</div>
</div>
</div>
</body>

</html>
<%@page import="java.util.List"%>
<%@page import="com.util.MyUtil"%>
<%@page import="com.fiveTing.ChatDAO"%>
<%@page import="com.util.DBCPConn"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.fiveTing.ChatDTO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%	
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	Connection conn = DBCPConn.getConnection();
	ChatDAO dao = new ChatDAO(conn);
	
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
	
	
	
	
	List<ChatDTO> lists = dao.getLists(start, end);
	
	
	//페이징 처리
	String listUrl = "matchingList.jsp";
	String pageIndexList =
			myUtil.pageIndexList(currentPage, totalPage, listUrl);
	
	
	DBCPConn.close();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=cp%>/fiveTing/style.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/finveTing/created.css" type="text/css"/>
<script type="text/javascript" src="<%=cp%>/fiveTing/guest.js"></script>
<script type="text/javascript">
function check(num) {
	
	
	var f=document.myForm;
	var up;
	var getNum = num;
	var getpageNum = pageNum; 
	
	up= confirm("삭제 하시겠습니까? ");
	
	if(up){
		f.action="/study/fiveTing/delete.jsp?num=" + getNum + "&pageNum="+getpageNum;
        f.submit();
		
	}else{
		return;
	}
	
}



</script>
</head>
<body>
<div id="bbsList">
	<div id="bbsList_list">
		
		<div id="lists">
		<%for(ChatDTO dto : lists){ %>	
			<div id="bbsCreated">
			<div class="bbsCreated_bottomLine">
				<dl>
					<dt style="width: 305px; padding-left: 0px; font-size: 12px; font-style: oblique;"><b><%=dto.getId() %>
					</b></dt>
					
					<dt style="width: 305px; padding-left: 0px">&nbsp;작성일 : <%=dto.getCreated() %> &nbsp;</dt>
					<dd style="width: 285px; background-color: #EEEEEE; text-align: right; onclick=""><input type="button"<%-- href="<%=cp%>/guest/delete.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>" --%> onclick="check(<%=dto.getCreated()%>)" value="삭제"/></dd>
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









</body>
</html>
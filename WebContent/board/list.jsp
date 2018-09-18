<%@page import="com.util.DBCPConn"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.util.MyUtil"%>
<%@page import="com.board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.board.BoardDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String cp = request.getContextPath();

	Connection conn = DBCPConn.getConnection();
	BoardDAO dao = new BoardDAO(conn);
	
	
	MyUtil myUtil = new MyUtil();
	
	//client한테 넘어온 페이지 번호
	String pageNum = request.getParameter("pageNum");
	
	int currentPage = 1;

	//처음실행시 null
	if(pageNum!=null)
		currentPage = Integer.parseInt(pageNum); 

	//검색-----------------------------------------------------
	String searchKey = request.getParameter("searchKey");
	String searchValue = request.getParameter("searchValue");

	if(searchKey!=null){

		if(request.getMethod().equalsIgnoreCase("GET")){
	searchValue = URLDecoder.decode(searchValue,"UTF-8");
		}
		
		
	}else{
		searchKey="subject";
		searchValue="";
	}
	
	
	
	//전체데이터구하기
	int dataCount = dao.getDataCount(searchKey,searchValue);
	
	//전체 데이터를 기준으로 총 페이지수 계산
	int numPerPage = 3;
	int totalPage =
	myUtil.getPageCount(numPerPage, dataCount);
	
	//삭제로 인해 전체페이지수보다 표시할 페이지수가 큰경우 페이지조절
	if(currentPage>totalPage)
		currentPage=totalPage;
	
	//데이터베이스에서 가져올 시작과 끝위치 
	int start = (currentPage-1)*numPerPage+1;
	int end = currentPage*numPerPage;
	
	List<BoardDTO> lists = dao.getLists(start,end,searchKey,searchValue);
	
	
	//검색--------------------------------------
	String param = "";
	
	if(!searchValue.equals("")){
		
		param = "?searchKey=" + searchKey;
		param +="&searchValue=" + URLEncoder.encode(searchValue,"UTF-8");	
		
	}
	
	
	
	
	//페이징 처리
	String listUrl = "list.jsp" + param;
	String pageIndexList =
	myUtil.pageIndexList(currentPage, totalPage, listUrl);

	//article 주소정리
	
	String articleUrl = cp + "/board/article.jsp";
	
	if(param.equals("")){
		articleUrl = articleUrl + "?pageNum=" + currentPage; 
	}else{
		articleUrl = articleUrl + param + "&pageNum=" +currentPage;
	}
	
	
	DBCPConn.close();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>게 시 판</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<link rel="stylesheet" href="<%=cp%>/board/css/style.css"
	type="text/css" />
<link rel="stylesheet" href="<%=cp%>/board/css/list.css" type="text/css" />

<script type="text/javascript">

	function sendIt(){
		
		var f = document.searchForm;
		
		f.action ="<%=cp%>
	/board/list.jsp";
		f.submit();
	}
</script>


</head>

<body>
	<div id="bbsList">
		<div id="bbsList_title">게 시 판(JSP)</div>

		<div id="bbsList_header">
			<div id="leftHeader">
				<form name="searchForm" method="post" action="">
					<select name="searchKey" class="selectFiled">
						<option value="subject">제목</option>
						<option value="name">작성자</option>
						<option value="content">내용</option>
					</select> <input type="text" name="searchValue" class="textFiled" /> <input
						type="button" value=" 검 색 " class="btn2" onclick="sendIt();" />
				</form>
			</div>
			<div id="rightHeader">
				<input type="button" value=" 글올리기 " class="btn2"
					onclick="javascript:location.href='<%=cp%>/board/created.jsp';" />
			</div>
		</div>
		<div id="bbsList_list">
			<div id="title">
				<dl>
					<dt class="num">번호</dt>
					<dt class="subject">제목</dt>
					<dt class="name">작성자</dt>
					<dt class="created">작성일</dt>
					<dt class="hitCount">조회수</dt>
				</dl>
			</div>
			<div id="lists">
				<%
					for (BoardDTO dto : lists) {
				%>
				<dl>
					<dd class="num"><%=dto.getNum()%></dd>
					<dd class="subject">
						<a href="<%=articleUrl%>&num=<%=dto.getNum()%>"> <%=dto.getSubject()%>
						</a>
					</dd>
					<dd class="name"><%=dto.getName()%></dd>
					<dd class="created"><%=dto.getCreated()%></dd>
					<dd class="hitCount"><%=dto.getHitCount()%></dd>
				</dl>
				<%
					}
				%>
			</div>
			<div id="footer">
				<p>
					<%
						if (dataCount != 0) {
					%>
					<%=pageIndexList%>
					<%
						} else {
					%>
					등록된 게시물이 없습니다.
					<%
						}
					%>
				</p>
			</div>
		</div>
	</div>
</body>

</html>
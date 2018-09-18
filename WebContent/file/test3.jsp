<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%	
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();

	
	//D:\java\work\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\study => root 위치
	/* String root = request.getRealPath("/"); */
	
	String root = pageContext.getServletContext().getRealPath("/");
	
	//저장되는 폴더와 위치   \ File.separator 는 파일과 파일의 경계선(/코딩)
	String path = root + File.separator + "pds" + File.separator + "saveData";
	
	//저장폴더가 없으면 생성
	File dir = new File(path);
	if(!dir.exists())
		dir.mkdirs();
	
	
	String encType = "UTF-8";
	int maxFileSize = 10*1024*1024; //10m
	
	try{
		
	//파일전송 코딩 한줄임
	MultipartRequest mr = new MultipartRequest(request,path,maxFileSize,encType,new DefaultFileRenamePolicy());

	
	//DB에 저장할 파일정보를 추출
	out.print("이름: " + mr.getParameter("name") + "<br/>");
	out.print("서버에 저장될 파일명: " + mr.getFilesystemName("upload") + "<br/>");
	out.print("업로드 한 파일명: " + mr.getOriginalFileName("upload") + "<br/>");
	out.print("파일 타입: " + mr.getContentType("upload") + "<br/>");
	
	File f = mr.getFile("upload");
	if(f!=null)
		out.print("파일길이 : " + f.length() + "<br/>");
		
	}catch(Exception e){
		System.out.print(e.toString());		
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>


업로드 성공!




<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>



</body>
</html>
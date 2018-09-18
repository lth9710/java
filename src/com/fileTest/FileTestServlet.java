package com.fileTest;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Connection;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.board.BoardDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.util.DBCPConn;
import com.util.FileManager;
import com.util.MyUtil;

public class FileTestServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		doPost(req, resp);
		
	}

	
	protected void forward(HttpServletRequest req, HttpServletResponse resp , String url)
			throws ServletException, IOException {
		
		RequestDispatcher rd = req.getRequestDispatcher(url);
		
		rd.forward(req, resp);
		
	}
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		
		Connection conn = DBCPConn.getConnection();
		FileTestDAO dao = new FileTestDAO(conn);
		MyUtil myUtil = new MyUtil();
		
		
		String cp = req.getContextPath();
		String uri = req.getRequestURI();
		String url;
		
		//파일을 저장할 경로
		
		String root = getServletContext().getRealPath("/");
		String path = root + File.separator + "pds" + File.separator + "saveFile";
		
		File f = new File(path);
		if(!f.exists())
			f.mkdirs();
		
		if(uri.indexOf("write.do")!=-1){
			
			url = "/fileTest/write.jsp";
			forward(req, resp, url);

		}else if(uri.indexOf("write_ok.do")!=-1){
			
			//파일업로드
			String encType = "UTF-8";
			int maxSize = 10*1024*1024;
			
			MultipartRequest mr = new MultipartRequest(req,path,maxSize,encType, new DefaultFileRenamePolicy());
			
			
			//DB에 파일정보저장
			if(mr.getFile("upload")!=null){
				
				FileTestDTO dto = new FileTestDTO();
				
				
				
				int maxNum = dao.getMaxNum();
				
				dto.setNum(maxNum+1);
				dto.setSubject(mr.getParameter("subject"));
				dto.setSaveFileName(mr.getFilesystemName("upload"));
				dto.setOriginalFileName(mr.getOriginalFileName("upload"));
				
				dao.insertData(dto);
				
			}
			
			url = cp + "/file/list.do";
			resp.sendRedirect(url);
			
		}else if(uri.indexOf("list.do")!=-1){
			
			
			
			
			
			HttpSession session = req.getSession();
			
			FileTestDTO sessiondto = new FileTestDTO();
			List<FileTestDTO> lists = dao.getlist();
			
			String downloadPath = cp + "/file/download.do";
			String deletePath = cp + "/file/delete.do";
			
			String imagePath = cp + "/pds/saveFile";
			req.setAttribute("imagePath", imagePath);
			
			
			
			session.setAttribute("dto", sessiondto);
			
			
			
			String pageNum = req.getParameter("pageNum");

			int currentPage = 1;
			if(pageNum!=null)
				currentPage = Integer.parseInt(pageNum);
									
			int numPerPage = 3;
			int dataCount = dao.getDataCount();

			int totalPage = 
					myUtil.getPageCount(numPerPage, dataCount);

			if(currentPage>totalPage)
				currentPage=totalPage;					

			
			int start = (currentPage-1)*numPerPage+1;
			int end = currentPage*numPerPage;

			List<FileTestDTO> lists2 =
					dao.getLists(start, end);
			
			
			String listUrl = cp+"/file/list.do";
			
			
			String pageIndexList =
					myUtil.pageIndexList(currentPage, totalPage, listUrl);
			String articleUrl = cp + "/file/list.do?pageNum=" + currentPage;
			
			req.setAttribute("lists2", lists2);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("articleUrl", articleUrl);
			req.setAttribute("pageNum",pageNum);
			req.setAttribute("downloadPath", downloadPath);
			req.setAttribute("deletePath", deletePath);
			
			
			
			url = "/fileTest/list.jsp";
			forward(req,resp,url);
			
		}else if(uri.indexOf("delete.do")!=-1){
			
			HttpSession session = req.getSession();
			String pageNum = req.getParameter("pageNum");
			int numb = Integer.parseInt(req.getParameter("num"));
			
			FileTestDTO dto = dao.getReadData(numb);
			
			//파일삭제
			FileManager.doFileDelete(dto.getSaveFileName(), path);
			
			
			
			session.setAttribute("pageNumb", pageNum);
			
			dao.deleteData(numb);
			
			url = cp + "/file/list.do";
			
			if(!session.getAttribute("pageNumb").equals(null)&&!session.getAttribute("pageNumb").equals("")){
			url = cp + "/file/list.do?pageNum="+session.getAttribute("pageNumb");
			}
			resp.sendRedirect(url);			
			
			
		}else if(uri.indexOf("article.do")!=-1){
			
			int num = Integer.parseInt(req.getParameter("num"));
			String pageNum = req.getParameter("pageNum");

			//데이터읽기
			FileTestDTO dto = dao.getReadData(num);

			if(dto==null){
				url = cp+ "/file/list.do"; 
				resp.sendRedirect(url);
			}


			req.setAttribute("dto", dto);
			req.setAttribute("pageNum", pageNum);


			url= "/fileTest/list.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("download.do")!=-1){
			
			
			int num = Integer.parseInt(req.getParameter("num"));
			
			FileTestDTO dto = dao.getReadData(num);
			
			if(dto==null)
				return;
						
			//반환값(true:다운로드완료)
			boolean flag = FileManager.doFileDownload(resp, dto.getSaveFileName(), dto.getOriginalFileName(), path);
			
			
			if(flag==false){
				
				resp.setContentType("text/html;charset=UTF-8");
				
				PrintWriter out = resp.getWriter();
				
				out.print("<script type='text/javascript'>");
				out.print("alert('download error');");
				out.print("history.back();");//뒤로가기
				out.print("</script>");
				
				
			}
			
			
			
			
		}
		
			
		
		
	}

	
	
	
	
	
	
	
	
	
	
}

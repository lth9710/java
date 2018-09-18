package com.imageTest;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.util.DBCPConn;
import com.util.FileManager;
import com.util.MyUtil;

public class ImageTestServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		doPost(req, resp);

	}

	protected void forward(HttpServletRequest req, HttpServletResponse resp,String url)
			throws ServletException, IOException {

		RequestDispatcher rs = req.getRequestDispatcher(url);

		rs.forward(req, resp);




	}


	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {



		req.setCharacterEncoding("UTF-8");
		Connection conn = DBCPConn.getConnection();
		ImageTestDAO dao = new ImageTestDAO(conn);
		MyUtil myUtil = new MyUtil();

		String cp = req.getContextPath();
		String uri = req.getRequestURI();
		String url;

		String root = getServletContext().getRealPath("/");
		String path = root + File.separator + "pds" + File.separator + "imageFile";

		File f = new File(path);
		if(!f.exists())
			f.mkdirs();


		if(uri.indexOf("write.do")!=-1){

			url = "/imageTest/write.jsp";
			forward(req, resp, url);

		}else if(uri.indexOf("write_ok.do")!=-1){

			//파일업로드
			String encType = "UTF-8";
			int maxSize = 10*1024*1024;

			MultipartRequest mr = new MultipartRequest(req,path,maxSize,encType, new DefaultFileRenamePolicy());


			//DB에 파일정보저장
			if(mr.getFile("upload")!=null){

				ImageTestDTO dto = new ImageTestDTO();



				int maxNum = dao.getMaxNum();

				dto.setNum(maxNum+1);
				dto.setSubject(mr.getParameter("subject"));
				dto.setSaveFileName(mr.getFilesystemName("upload"));
				dto.setOriginalFileName(mr.getOriginalFileName("upload"));
				dao.insertData(dto);

			}

			
			url = cp + "/image/list.do";
			resp.sendRedirect(url);




		}else if(uri.indexOf("list.do")!=-1){


			HttpSession session = req.getSession();
			String deletePath = cp + "/image/delete.do";
			String downloadPath = cp + "/image/download.do";


			String imagePath = cp + "/pds/imageFile";
			req.setAttribute("imagePath", imagePath);


			String pageNum = req.getParameter("pageNum");



			int currentPage = 1;
			if(pageNum!=null)
				currentPage = Integer.parseInt(pageNum);

			int numPerPage = 9;
			int dataCount = dao.getDataCount();

			int totalPage = 
					myUtil.getPageCount(numPerPage, dataCount);

			if(currentPage>totalPage)
				currentPage=totalPage;					


			int start = (currentPage-1)*numPerPage+1;
			int end = currentPage*numPerPage;



			List<ImageTestDTO> lists =
					dao.getLists(start, end);

			String listUrl = cp+"/image/list.do";

			String pageIndexList =
					myUtil.pageIndexList(currentPage, totalPage, listUrl);

			
			req.setAttribute("lists", lists);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("pageNum",pageNum);
			req.setAttribute("downloadPath", downloadPath);
			req.setAttribute("deletePath", deletePath);
			req.setAttribute("totalPage", totalPage);
			url = "/imageTest/list.jsp";
			forward(req,resp,url);





		}else if(uri.indexOf("delete.do")!=-1){

			HttpSession session = req.getSession();
			String pageNum = req.getParameter("pageNum");
			int numb = Integer.parseInt(req.getParameter("num"));

			ImageTestDTO dto = dao.getReadData(numb);

			//파일삭제
			FileManager.doFileDelete(dto.getSaveFileName(), path);



			session.setAttribute("pageNumb", pageNum);

			dao.deleteData(numb);

			url = cp + "/image/list.do";

			if(!session.getAttribute("pageNumb").equals(null)&&!session.getAttribute("pageNumb").equals("")){
				url = cp + "/image/list.do?pageNum="+session.getAttribute("pageNumb");
			}
			resp.sendRedirect(url);			



		}else if(uri.indexOf("download.do")!=-1){



			int num = Integer.parseInt(req.getParameter("num"));

			ImageTestDTO dto = dao.getReadData(num);

			if(dto==null)
				return;

			//반환값(true:다운로드완료)
			boolean flag = FileManager.doFileDownload(resp,dto.getSaveFileName(),dto.getOriginalFileName(), path);


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

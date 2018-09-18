package com.board;

import java.io.IOException;
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

import com.join.CustomInfo;
import com.util.DBCPConn;
import com.util.MyUtil;

public class BoardServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		doPost(req, resp);
	}


	protected void forward(HttpServletRequest req, HttpServletResponse resp, String url)
			throws ServletException, IOException {

		RequestDispatcher rd = req.getRequestDispatcher(url);

		rd.forward(req, resp);


	}




	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {


		/*req.setCharacterEncoding("UTF-8");*/
		String cp = req.getContextPath();
		Connection conn = DBCPConn.getConnection();

		BoardDAO dao = new BoardDAO(conn);

		MyUtil myUtil = new MyUtil();

		String url;

		String uri = req.getRequestURI(); //cp 포함 전체주소표시

		//study/bbs/list.jsp -진짜주소
		//study/sboard/list.do - 가상주소

		if(uri.indexOf("created.do")!=-1){

			HttpSession session = req.getSession();
			
			CustomInfo info = (CustomInfo)session.getAttribute("customInfo");
			

			if(info==null){
				
				url = "/member/login.jsp";
				forward(req, resp, url);
				return;
				
			}
			
			
			
			url = "/bbs/created.jsp";

			forward(req, resp, url);

		}

		else if(uri.indexOf("created_ok.do")!=-1){

			BoardDTO dto = new BoardDTO();

			int maxNum = dao.getMaxNum();

			dto.setNum(maxNum+1);
			dto.setName(req.getParameter("name"));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			dto.setEmail(req.getParameter("email"));
			dto.setPwd(req.getParameter("pwd"));
			dto.setIpAddr(req.getRemoteAddr());

			dao.insertData(dto);

			url = cp + "/sboard/list.do";
			resp.sendRedirect(url);




		}else if(uri.indexOf("list.do")!=-1){


			String pageNum = req.getParameter("pageNum");

			int currentPage = 1;
			if(pageNum!=null)
				currentPage = Integer.parseInt(pageNum);

			//검색
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");

			if(searchKey==null){
				searchKey = "subject";
				searchValue = "";
			}else{
				if(req.getMethod().equalsIgnoreCase("GET")){
					searchValue = 
							URLDecoder.decode(searchValue, "UTF-8");

				}
			}

			//전체데이터개수
			int numPerPage = 5;
			int dataCount = dao.getDataCount(searchKey, searchValue);

			int totalPage = 
					myUtil.getPageCount(numPerPage, dataCount);

			//삭제후 전체 페이지수보다 표시할 페이지가 큰경우
			if(currentPage>totalPage)
				currentPage=totalPage;

			//데이터의 시작과 끝
			int start = (currentPage-1)*numPerPage+1;
			int end = currentPage*numPerPage;

			List<BoardDTO> lists =
					dao.getLists(start, end, searchKey, searchValue);


			//페이징처리
			String param = "";

			if(!searchValue.equals("")){
				param = "searchKey=" + searchKey;
				param+= "&searchValue=" + 
						URLEncoder.encode(searchValue,"UTF-8");	
			}

			String listUrl = cp + "/sboard/list.do";

			if(!param.equals(null))
				listUrl= listUrl +"?"+ param;

			String pageIndexList =
					myUtil.pageIndexList(currentPage, totalPage, listUrl);


			//글보기 주소
			String articleUrl = cp + "/sboard/article.do?pageNum=" + currentPage;


			if(!param.equals(""))
				articleUrl = articleUrl + "&" + param;


			//포워딩 페이지에 데이터를 넘김
			req.setAttribute("lists", lists);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("dataCount",dataCount);
			req.setAttribute("articleUrl", articleUrl);

			url = "/bbs/list.jsp";

			forward(req, resp, url);

		}else if(uri.indexOf("article.do")!=-1){

			int num = Integer.parseInt(req.getParameter("num"));
			String pageNum = req.getParameter("pageNum");

			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");

			if(searchKey!=null){
				searchValue =
						URLDecoder.decode(searchValue,"UTF-8");

			}

			//조회수 증가
			dao.updateHitCount(num);

			//데이터읽기
			BoardDTO dto = dao.getReadData(num);

			if(dto==null){
				url = cp+ "/sboard/list.do"; 
				resp.sendRedirect(url);
			}

			int lineSu = dto.getContent().split("\n").length;

			dto.setContent(dto.getContent().replaceAll("\n", "<br/>"));

			String param = "pageNum="+pageNum;

			if(searchKey!=null){
				param +="&searchKey=" + searchKey;
				param+="&searchValue=" + 
						URLEncoder.encode(searchValue,"UTF-8");
			}

			req.setAttribute("dto", dto);
			req.setAttribute("params", param);
			req.setAttribute("lineSu", lineSu);
			req.setAttribute("pageNum", pageNum);


			url= "/bbs/article.jsp";
			forward(req, resp, url);

		}else if(uri.indexOf("updated.do")!=-1){

			int num = Integer.parseInt(req.getParameter("num"));
			String pageNum = req.getParameter("pageNum");

			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");

			if(searchKey!=null){
				searchValue =
						URLDecoder.decode(searchValue,"UTF-8");

			}

			BoardDTO dto = dao.getReadData(num);


			if(dto==null){
				url = cp + "/sboard/list.do";
				resp.sendRedirect(url);

			}

			String param = "pageNum="+pageNum;

			if(searchKey!=null){
				param +="&searchKey=" + searchKey;
				param+="&searchValue=" + 
						URLEncoder.encode(searchValue,"UTF-8");
			}else{
				searchKey = "subject";
				searchValue = "";
			}



			req.setAttribute("dto", dto);
			req.setAttribute("pageNum", pageNum);
			req.setAttribute("params", param);
			req.setAttribute("searchKey", searchKey);
			req.setAttribute("searchValue", searchValue);


			url = "/bbs/updated.jsp";
			forward(req, resp, url);



		}else if(uri.indexOf("updated_ok.do")!=-1){

			String pageNum = req.getParameter("pageNum");
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");




			BoardDTO dto = new BoardDTO();

			dto.setNum(Integer.parseInt(req.getParameter("num")));
			dto.setSubject(req.getParameter("subject"));
			dto.setName(req.getParameter("name"));
			dto.setEmail(req.getParameter("email"));
			dto.setPwd(req.getParameter("pwd"));
			dto.setContent(req.getParameter("content"));


			dao.updateData(dto);

			String params = "pageNum="+pageNum;

			if(searchKey!=null){
				//params +="&searchKey=" + searchKey;
				//params +="&searchValue=" + 
						//URLEncoder.encode(searchValue,"UTF-8");
			}

			url = cp + "/sboard/list.do?" + params;
			resp.sendRedirect(url);

		}else if(uri.indexOf("deleted.do")!=-1){

			int num = Integer.parseInt(req.getParameter("num"));
			String pageNum = req.getParameter("pageNum");
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");

			dao.deleteData(num);

			String params = "pageNum="+pageNum;

			if(searchKey!=null){
				params +="&searchKey=" + searchKey;
				params+="&searchValue=" + 
						URLEncoder.encode(searchValue,"UTF-8");
			}

			url = cp + "/sboard/list.do?" + params;
			resp.sendRedirect(url);

			
			
		}

	}

}

package com.score;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.board.BoardDTO;
import com.util.DBCPConn;

public class ScoreServlet extends HttpServlet {

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

		req.setCharacterEncoding("UTF-8");
		String cp = req.getContextPath();
		Connection conn = DBCPConn.getConnection();

		ScoreDAO dao = new ScoreDAO(conn);

		String url;

		String uri = req.getRequestURI(); //cp 포함 전체주소표시

		//study/bbs/list.jsp -진짜주소
		//study/sboard/list.do - 가상주소

		if(uri.indexOf("write.do")!=-1){

			url ="/sung/write.jsp";
			forward(req, resp, url);
		}else if(uri.indexOf("write_ok.do")!=-1){

			ScoreDTO dto = new ScoreDTO();
			
			dto.setHak(req.getParameter("hak"));
			dto.setName(req.getParameter("name"));
			dto.setKor(Integer.parseInt(req.getParameter("kor")));
			dto.setEng(Integer.parseInt(req.getParameter("eng")));
			dto.setMat(Integer.parseInt(req.getParameter("mat")));
			
			dao.insertData(dto);
			
			url =cp + "/sscore/list.do";
			resp.sendRedirect(url);

		}else if(uri.indexOf("list.do")!=-1){

			List<ScoreDTO> lists = dao.getList();
			
			req.setAttribute("lists", lists);
			
			url ="/sung/list.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("update.do")!=-1){

			String hak = req.getParameter("hak");

			ScoreDTO dto = dao.getReadData(hak);
			
			if(dto==null){
				url =cp + "/sscore/list.do";
				resp.sendRedirect(url);
			}
			req.setAttribute("dto", dto);

			url = "/sung/update.jsp";
			forward(req, resp, url);

		}else if(uri.indexOf("update_ok.do")!=-1){

			ScoreDTO dto = new ScoreDTO();

			dto.setHak(req.getParameter("hak"));
			dto.setName(req.getParameter("name"));
			dto.setKor(Integer.parseInt(req.getParameter("kor")));
			dto.setEng(Integer.parseInt(req.getParameter("eng")));
			dto.setMat(Integer.parseInt(req.getParameter("mat")));

			dao.updateData(dto);

			url = cp +"/sscore/list.do";
			resp.sendRedirect(url);

		}else if(uri.indexOf("delete_ok.do")!=-1){

			String hak = req.getParameter("hak");

			dao.deleteData(hak);

			url = cp + "/sscore/list.do";
			
			resp.sendRedirect(url);
		}

	}

}

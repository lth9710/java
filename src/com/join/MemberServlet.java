package com.join;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.util.DBCPConn;

public class MemberServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}

	protected void forward(HttpServletRequest req, HttpServletResponse resp,String url)
			throws ServletException, IOException {

		RequestDispatcher rd = req.getRequestDispatcher(url);
		rd.forward(req, resp);

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		Connection conn = DBCPConn.getConnection();
		MemberDAO dao = new MemberDAO(conn);

		String cp = req.getContextPath();
		String uri = req.getRequestURI();

		String url;

		if(uri.indexOf("created.do")!=-1){

			url = "/member/created.jsp"; // 회원가입창?
			forward(req, resp, url);

		}else if(uri.indexOf("created_ok.do")!=-1){

			MemberDTO dto = new MemberDTO();

			dto.setUserId(req.getParameter("userId"));
			dto.setUserPwd(req.getParameter("userPwd"));
			dto.setUserName(req.getParameter("userName"));
			dto.setUserBirth(req.getParameter("userBirth"));
			dto.setUserTel(req.getParameter("userTel"));

			dao.insertData(dto);

			url = cp +"/index.jsp";
			resp.sendRedirect(url);
		}else if(uri.indexOf("login.do")!=-1){
			url = "/member/login.jsp";
			forward(req, resp, url);


		}else if(uri.indexOf("login_ok.do")!=-1){

			String userId = req.getParameter("userId");
			String userPwd = req.getParameter("userPwd");

			MemberDTO dto = dao.getReadData(userId);

			if(dto==null||(!dto.getUserPwd().equals(userPwd))){

				req.setAttribute("message",
						"아이디 또는 패스워드를 정확히 입력하세요!");
				req.setAttribute("bool", "true");
				
				
				url = "/member/login.jsp";
				forward(req, resp, url);
				return;
			}

			HttpSession session = req.getSession(true);//새로운세션생성할떄는 true값을줌

			CustomInfo info = new CustomInfo();

			info.setUserId(userId);
			info.setUserName(dto.getUserName());

			session.setAttribute("customInfo", info);

			url = cp;
			resp.sendRedirect(url);

		}else if(uri.indexOf("logout.do")!=-1){

			HttpSession session = req.getSession();//기존에있는 세션을 사용할때는 ()로 boolean값없이사용

			session.removeAttribute("customInfo");
			session.invalidate();//변수삭제

			url = cp;

			resp.sendRedirect(url);


		}else if(uri.indexOf("updated.do")!=-1){

			HttpSession session = req.getSession();
			
			CustomInfo info = (CustomInfo)session.getAttribute("customInfo");
							
			String userId = info.getUserId();
			
			MemberDTO dto = dao.getReadData(userId);

			/*session.setAttribute("userId", dto.getUserId());
			session.setAttribute("userName", dto.getUserName());
			session.setAttribute("userPwd", dto.getUserPwd());
			session.setAttribute("userBirth", dto.getUserBirth());
			session.setAttribute("userTel", dto.getUserTel());*/
			
			req.setAttribute("dto", dto);
			
			url ="/member/updated.jsp";
			
			forward(req, resp, url);
			
		}else if(uri.indexOf("updated_ok.do")!=-1){
		
			MemberDTO dto = new MemberDTO();
			
			dto.setUserId(req.getParameter("userId"));
			dto.setUserPwd(req.getParameter("userPwd"));
			dto.setUserName(req.getParameter("userName"));
			dto.setUserBirth(req.getParameter("userBirth"));
			dto.setUserTel(req.getParameter("userTel"));
			
			dao.updateData(dto);
			
			url = cp;
			
			resp.sendRedirect(url);
		}else if(uri.indexOf("searchpw.do")!=-1){
		
			
			url ="/member/searchpw.jsp";
			
			forward(req, resp, url);
			
		}else if(uri.indexOf("searchpw_ok.do")!=-1){
		
			
		String userId =	req.getParameter("userId");
		String userTel = req.getParameter("userTel");
			
			MemberDTO dto = dao.getReadData(userId);
			
			if(dto==null||(!dto.getUserId().equals(userId))||(!dto.getUserTel().equals(userTel))){
				
				req.setAttribute("message", "회원정보가 존재하지 않습니다.");
				
			}else if(dto.getUserId().equals(userId)&&dto.getUserTel().equals(userTel)){
				req.setAttribute("message", "비밀번호는 ["+dto.getUserPwd()+"]입니다.");
				
			}
			url = "/member/login.jsp";
			forward(req, resp, url);
			
			
		}
	}
}

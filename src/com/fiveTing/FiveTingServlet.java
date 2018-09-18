package com.fiveTing;

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

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.util.DBCPConn;
import com.util.FileManager;
import com.util.MyUtil;

public class FiveTingServlet extends HttpServlet{

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
		FiveTingDAO dao = new FiveTingDAO(conn);






		String cp = req.getContextPath();
		String url;
		String uri = req.getRequestURI();
		String imagePath = cp + "/fiveTing/image";
		String imagePathMember = imagePath + "/profile";
		String imagePathDatePlace = imagePath + "/datePlace";
		String imagePathRes = imagePath + "/restaurant";

		req.setAttribute("imagePath", imagePath);
		MyUtil mu = new MyUtil();


		req.setAttribute("imagePath", imagePath);

		// ������ ������ ��� ����
		// ���
		// C:\eclipse\EclipseWorkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\study
		String root = getServletContext().getRealPath("/");
		String pathRes = root + File.separator + "fiveTing" + File.separator
				+ "image" + File.separator + "restaurant";
		String pathMember = root + File.separator + "fiveTing" + File.separator
				+ "image" + File.separator + "profile";
		String pathDatePlace = root + File.separator + "fiveTing"
				+ File.separator + "image" + File.separator + "datePlace";

		File fOrder = new File(pathMember);
		//������ ������ ���

		String path = root + File.separator + "pds" + File.separator + "reviewFile";

		File fMy = new File(path);
		if(!fMy.exists())
			fMy.mkdirs();




		if (uri.indexOf("loginMember.do") != -1) {

			url = "/fiveTing/loginMember.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("loginMember_ok.do") != -1) {

			String MemberId = req.getParameter("id");
			String MemberPwd = req.getParameter("pwd");

			CustomInfoDTO dtoMember = dao.getReadMemberData(MemberId);

			if (dtoMember == null || (!dtoMember.getPwd().equals(MemberPwd))) {

				req.setAttribute("message", "���̵� �Ǵ� �н����带 ��Ȯ�� �Է��ϼ���");
				req.setAttribute("bool", "true");

				url = "/five/loginMember.do";
				forward(req, resp, url);

				return;

			}

			HttpSession session = req.getSession(true);

			MemberInfo info = new MemberInfo(); // ����

			info.setId(dtoMember.getId());

			session.setAttribute("id", info.getId());
			session.setAttribute("MemberInfo", info);

			url = cp + "/five/index.do";
			resp.sendRedirect(url);



		}else if (uri.indexOf("profile.do") != -1) {

			HttpSession session = req.getSession(true);
			MemberInfo info = (MemberInfo)session.getAttribute("MemberInfo");


			CustomInfoDTO dto = dao.getReadProfile(info.getId());
			req.setAttribute("name", dto.getName());
			req.setAttribute("gender", dto.getGender());
			req.setAttribute("age", dto.getAge());
			req.setAttribute("id", dto.getId());
			req.setAttribute("pwd",dto.getPwd());
			req.setAttribute("job", dto.getJob());
			req.setAttribute("address", dto.getAddress());
			req.setAttribute("height", dto.getHeight());
			req.setAttribute("body", dto.getBody());
			req.setAttribute("tel", dto.getTel());
			req.setAttribute("score", dto.getScore());
			req.setAttribute("content", dto.getContent());
			req.setAttribute("picture", dto.getPicture());

			url = "/fiveTing/profile.jsp";
			forward(req, resp, url);


			/*}else if (uri.indexOf("updateScore.do") != -1) {

			String u_id = req.getParameter("u_id");



			CustomInfoDTO dto = dao.getReadProfile(u_id);


			System.out.println("Here is updateScore");

			//String id = req.getParameter("id");
			int receivedScore = Integer.parseInt(req.getParameter("btnScore"));

			System.out.println(dto.getScore());

			System.out.println("���� ����:"+receivedScore);
			int postScore = (dto.getScore()+receivedScore) / 2; //���� ������ �޾ƿ� ������ ����� ����.

			dao.updateScore(u_id, postScore);

			req.setAttribute("preScore", dto.getScore());

			url = "/fiveTing/updateScore.jsp";
			forward(req, resp, url);
			 */



		}else if(uri.indexOf("login_ok.do")!=-1){

			HttpSession session = req.getSession(true);
			MemberInfo info = (MemberInfo)session.getAttribute("MemberInfo");


			CustomInfoDTO dto = dao.getReadProfile(info.getId());


			CustomInfoDTO cusdto = dao.getReadProfile(info.getId());
			ReviewArtDTO revdto = dao.getReadData(info.getId());

			if(dto==null||(!cusdto.getPwd().equals(info.getId()))){

				req.setAttribute("message",
						"���̵� �Ǵ� �н����带 ��Ȯ�� �Է��ϼ���!");
				req.setAttribute("bool", "true");

				session.setAttribute("id", info.getId());

				url = "/fiveTing/login.jsp";
				forward(req, resp, url);
				return;
			}


			info.setId(info.getId());
			info.setName(revdto.getName());

			session.setAttribute("MemberInfo", info);

			url = cp;
			resp.sendRedirect(url);



		}else if(uri.indexOf("chatting.do")!=-1){


			//���⼭ 

			String chatId =req.getParameter("id");
			String receiverId = req.getParameter("receiverId");
			url = "/fiveTing/chatting.jsp";

			/*getlist�� �޾ƿ��µ����͸� 2�����ϱ�*/
			List<ChatDTO> lists = dao.getChatList(chatId,receiverId);
			req.setAttribute("lists", lists);
			req.setAttribute("id", chatId);			
			req.setAttribute("receiverId", receiverId);
			forward(req, resp, url);


			/*}else if(uri.indexOf("created.do")!=-1){ //������ reviewart ���۵Ǵ� �����κ�

			HttpSession session = req.getSession();

			MemberInfo info = (MemberInfo)session.getAttribute("MemberInfo");


			if(info==null){

				url = "/fiveTing/reviewart.jsp"; // �α���â���� ���ư��� �ٲ����
				forward(req, resp, url);
				return;

			}

			 */

			/*url = "/fiveTing/rawrite.jsp";

			forward(req, resp, url);*/



		}else if(uri.indexOf("list.do")!=-1){//����¡ó�� + ����Ʈ�����ִ� ���弭�����ִ� ����

			String pageNum = req.getParameter("pageNum");			

			if(pageNum == null || pageNum.equals("")){
				pageNum="1";
			}

			int currentPage = 1;


			if(pageNum!=null){
				currentPage = Integer.parseInt(pageNum);
			}
			//�˻�
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

			//��ü�����Ͱ���
			int numPerPage = 5;
			int dataCount = dao.getDataCount(searchKey, searchValue);

			int totalPage = 
					mu.getPageCount(numPerPage, dataCount);

			//������ ��ü ������������ ǥ���� �������� ū���
			if(currentPage>totalPage)
				currentPage=totalPage;

			//�������� ���۰� ��
			int start = (currentPage-1)*numPerPage+1;
			int end = currentPage*numPerPage;

			List<ReviewArtDTO> revlists =
					dao.getReviewLists(start, end, searchKey, searchValue);


			//����¡ó��
			String param = "";

			if(!searchValue.equals("")){
				param = "searchKey=" + searchKey;
				param+= "&searchValue=" + 
						URLEncoder.encode(searchValue,"UTF-8");	
			}

			String listUrl = cp + "/five/list.do";

			if(!param.equals(null))
				listUrl= listUrl +"?"+ param;

			String pageIndexList =
					mu.pageIndexList(currentPage, totalPage, listUrl);


			//�ۺ��� �ּ�
			String articleUrl = cp + "/five/raarticle.do?pageNum=" + currentPage;


			if(!param.equals(""))
				articleUrl = articleUrl + "&" + param;


			//������ �������� �����͸� �ѱ�

			req.setAttribute("pageNum", pageNum);
			req.setAttribute("revlists", revlists);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("dataCount",dataCount);
			req.setAttribute("articleUrl", articleUrl);

			url = "/fiveTing/reviewart.jsp";

			forward(req, resp, url);

		}else if(uri.indexOf("raarticle.do")!=-1){

			int num = Integer.parseInt(req.getParameter("num"));
			String pageNum = req.getParameter("pageNum");

			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");


			//��ȸ�� ����
			dao.updatehitCount(num);

			//�������б�
			ReviewArtDTO revdto = dao.getReadData(num);

			if(revdto==null){
				url = cp+ "/five/list.do"; 
				resp.sendRedirect(url);
			}

			int lineSu = revdto.getContent().split("\n").length;

			revdto.setContent(revdto.getContent().replaceAll("\n", "<br/>"));

			String param = "pageNum="+pageNum;

			if(searchKey!=null){
				param +="&searchKey=" + searchKey;
				param+="&searchValue=" + 
						URLEncoder.encode(searchValue,"UTF-8");
			}
			/*HttpSession session = req.getSession();

			CustomInfo info = (CustomInfo)session.getAttribute("customInfo");
			 */
			/*String userId = info.getId();*/

			req.setAttribute("revdto", revdto);
			req.setAttribute("params", param);
			req.setAttribute("lineSu", lineSu);
			req.setAttribute("pageNum", pageNum);
			/*			session.setAttribute("userId", userId);
			 */			url= "/fiveTing/raarticle.jsp";
			 forward(req, resp, url);


		}else if(uri.indexOf("rawrite.do")!=-1){

			String pageNum = req.getParameter("pageNum");

			req.setAttribute("pageNum", pageNum);					

			url = "/fiveTing/rawrite.jsp";
			forward(req, resp, url);



		}else if(uri.indexOf("rawrite_ok.do")!=-1){



			//���Ͼ��ε�
			String encType = "UTF-8";
			int maxSize = 10*1024*1024;

			MultipartRequest mr = new MultipartRequest(req,path,maxSize,encType, new DefaultFileRenamePolicy());
			String pageNum=	mr.getParameter("pageNum");
			//DB�� ������������
			if(mr.getFile("picture")!=null){

				ReviewArtDTO revdto = new ReviewArtDTO();



				int maxNum = dao.getMaxNum();

				revdto.setNum(maxNum+1);
				revdto.setId(mr.getParameter("id"));
				revdto.setName(mr.getParameter("name"));
				revdto.setContent(mr.getParameter("content"));
				revdto.setSubject(mr.getParameter("subject"));
				revdto.setOriginPicture(mr.getOriginalFileName("picture"));
				revdto.setPicture(mr.getFilesystemName("picture"));

				dao.insertData(revdto);

			}else if(mr.getFile("picture")==null){

				ReviewArtDTO revdto = new ReviewArtDTO();

				int maxNum = dao.getMaxNum();

				revdto.setNum(maxNum+1);
				revdto.setId(mr.getParameter("id"));
				revdto.setName(mr.getParameter("name"));
				revdto.setContent(mr.getParameter("content"));
				revdto.setSubject(mr.getParameter("subject"));

				dao.insertData2(revdto);

			}

			url = cp + "/five/list.do?pageNum=" + pageNum;
			resp.sendRedirect(url);




		}else if(uri.indexOf("reviewart.do")!=-1){ //������� ����

			int num = Integer.parseInt(req.getParameter("num"));
			String pageNum = req.getParameter("pageNum");

			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");


			//��ȸ�� ����
			dao.updatehitCount(num);

			//�������б�
			ReviewArtDTO revdto = new ReviewArtDTO();
			revdto = dao.getReadData(num);

			if(revdto==null){
				url = cp+ "/five/list.do"; 
				resp.sendRedirect(url);
			}

			int lineSu = revdto.getContent().split("\n").length;

			revdto.setContent(revdto.getContent().replaceAll("\n", "<br/>"));

			String param = "pageNum="+pageNum;

			if(searchKey!=null){
				param +="&searchKey=" + searchKey;
				param+="&searchValue=" + 
						URLEncoder.encode(searchValue,"UTF-8");
			}

			req.setAttribute("revdto", revdto);
			req.setAttribute("params", param);
			req.setAttribute("lineSu", lineSu);
			req.setAttribute("pageNum", pageNum);


			url= "/fiveTing/raarticle.jsp";
			forward(req, resp, url);
		}else if(uri.indexOf("raupdated.do")!=-1){

			int num =Integer.parseInt(req.getParameter("num"));

			ReviewArtDTO revdto=dao.getReadData(num);

			num = revdto.getNum();
			req.setAttribute("num", num);
			req.setAttribute("revdto", revdto);

			url = "/fiveTing/raupdated.jsp";
			forward(req, resp, url);



			/*

			ReviewArtDTO revdto = new ReviewArtDTO();


			revdto = dao.getReadData(num);


			revdto.setNum(Integer.parseInt(req.getParameter("num")));
			revdto.setContent(req.getParameter("content"));
			revdto.setSubject(req.getParameter("subject"));
			revdto.setPicture(req.getParameter("picture"));

			dao.updateData(revdto);


			url = cp + "/five/list.do";
			resp.sendRedirect(url);
			 */



			/*}else if(uri.indexOf("raupdated.do")!=-1){


			HttpSession session = req.getSession();

			CustomInfo info = (CustomInfo)session.getAttribute("customInfo");

			String userId = info.getId();


				//���Ͼ��ε�
				String encType = "UTF-8";
				int maxSize = 10*1024*1024;

				MultipartRequest mr = new MultipartRequest(req,path,maxSize,encType, new DefaultFileRenamePolicy());


				//DB�� ������������
				if(mr.getFile("picture")!=null){

					ReviewArtDTO revdto = new ReviewArtDTO();


					revdto = dao.getReadData(userId);


					revdto.setNum(revdto.getNum());
					revdto.setContent(mr.getParameter("content"));
					revdto.setSubject(mr.getParameter("subject"));
					revdto.setOriginPicture(mr.getOriginalFileName("picture"));
					revdto.setPicture(mr.getFilesystemName("picture"));

					dao.updateData(revdto);

				}

				url = cp + "/five/list.do";
				resp.sendRedirect(url);



		}	

			 */
		}else if(uri.indexOf("raupdated_ok.do")!=-1){

			//���Ͼ��ε�
			String encType = "UTF-8";
			int maxSize = 10*1024*1024;

			MultipartRequest mr = new MultipartRequest(req,path,maxSize,encType, new DefaultFileRenamePolicy());
			int num = Integer.parseInt(mr.getParameter("num")); 
			//DB�� ������������
			if(mr.getFile("picture")!=null){


				ReviewArtDTO revdto = new ReviewArtDTO();

				revdto = dao.getReadData(num);

				revdto.setName(mr.getParameter("name"));
				revdto.setContent(mr.getParameter("content"));
				revdto.setSubject(mr.getParameter("subject"));
				revdto.setPicture(mr.getFilesystemName("picture"));
				dao.updateData(revdto);
			}else {

				ReviewArtDTO revdto = new ReviewArtDTO();

				revdto = dao.getReadData(num);

				revdto.setName(mr.getParameter("name"));
				revdto.setContent(mr.getParameter("content"));
				revdto.setSubject(mr.getParameter("subject"));

				dao.updateData2(revdto);
			}

			url = "/five/list.do";
			forward(req, resp, url);

		}else if(uri.indexOf("radelete.do")!=-1){

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

			url ="/five/list.do"+params;
			forward(req, resp, url);



			//�������� ����
		}else if (uri.indexOf("joinMember.do") != -1) {

			url = "/fiveTing/joinMember.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("joinMember_ok.do") != -1) {

			// ���Ͼ��ε�
			String encType = "UTF-8";
			int maxSize = 10 * 1024 * 1024;

			MultipartRequest mr = new MultipartRequest(req, pathMember,
					maxSize, encType, new DefaultFileRenamePolicy());

			// DB�� ������������
			if (mr.getFile("picture") != null) {
				CustomInfoDTO dtoMember = new CustomInfoDTO();

				dtoMember.setName(mr.getParameter("name"));
				dtoMember.setGender(mr.getParameter("gender"));
				dtoMember.setAge(Integer.parseInt(mr.getParameter("age")));
				dtoMember.setJob(mr.getParameter("job"));
				dtoMember.setAddress(mr.getParameter("address"));
				dtoMember.setId(mr.getParameter("id"));
				dtoMember.setPwd(mr.getParameter("pwd"));
				dtoMember.setHeight(mr.getParameter("height"));
				dtoMember.setBody(mr.getParameter("body"));
				dtoMember.setTel(mr.getParameter("tel"));
				dtoMember.setContent(mr.getParameter("content"));
				dtoMember.setPicture(mr.getFilesystemName("picture"));
				dtoMember.setScore(Integer.parseInt(mr.getParameter("score")));

				dao.insertMemberData(dtoMember);
			}

			url = cp + "/five/index.do";
			resp.sendRedirect(url);

		} else if (uri.indexOf("loginMember.do") != -1) {

			url = "/fiveTing/loginMember.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("loginMember_ok.do") != -1) {

			String MemberId = req.getParameter("id");
			String MemberPwd = req.getParameter("pwd");

			CustomInfoDTO dtoMember = dao.getReadMemberData(MemberId);

			if (dtoMember == null || (!dtoMember.getPwd().equals(MemberPwd))) {

				req.setAttribute("message", "���̵� �Ǵ� �н����带 ��Ȯ�� �Է��ϼ���");
				req.setAttribute("bool", true);

				url = "/five/loginMember.do";
				forward(req, resp, url);

				return;

			}

			HttpSession session = req.getSession(true);

			MemberInfo info = new MemberInfo(); // ����

			info.setId(dtoMember.getId());

			session.setAttribute("MemberInfo", info);
			session.setAttribute("id", info.getId());

			url = cp + "/five/index.do";
			resp.sendRedirect(url);

		} else if (uri.indexOf("logoutMember.do") != -1) {// �α׾ƿ�

			HttpSession session = req.getSession();
			session.removeAttribute("MemberInfo");
			session.removeAttribute("id");
			session.invalidate();// ��������
			url = cp + "/five/index.do";
			resp.sendRedirect(url);

			DBCPConn.close();


		} else if (uri.indexOf("deleteMember_ok.do") != -1) {// ȸ��Ż��

			String MemberId = req.getParameter("id");
			String MemberPwd = req.getParameter("pwd");
			System.out.println(MemberId);
			System.out.println(MemberPwd);

			CustomInfoDTO dtoMember = dao.getReadMemberData(MemberId);

			if (!dtoMember.getPwd().equals(MemberPwd)) {

				req.setAttribute("message", "�н����带 ��Ȯ�� �Է��ϼ���");
				req.setAttribute("bool", "true");

				url = "/five/deleteMember.do";
				forward(req, resp, url);

				return;

			}

			int result = dao.deleteMemberData(MemberId);

			url = cp + "/five/joinMember.do";
			resp.sendRedirect(url);

		} else if (uri.indexOf("deleteMember.do") != -1) {

			url = "/fiveTing/deleteMember.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("updateMember_ok.do") != -1) {


			// ���Ͼ��ε�
			String encType = "UTF-8";
			int maxSize = 10 * 1024 * 1024;

			req.setAttribute("imagePathMember", imagePathMember);

			MultipartRequest mr = new MultipartRequest(req, pathMember,
					maxSize, encType, new DefaultFileRenamePolicy());

			// DB�� ������������
			if (mr.getFile("picture") != null) {
				CustomInfoDTO dtoMember = new CustomInfoDTO();

				dtoMember.setJob(mr.getParameter("job"));
				dtoMember.setAddress(mr.getParameter("address"));
				dtoMember.setHeight(mr.getParameter("height"));
				dtoMember.setBody(mr.getParameter("body"));
				dtoMember.setTel(mr.getParameter("tel"));
				dtoMember.setPicture(mr.getFilesystemName("picture"));
				dtoMember.setContent(mr.getParameter("content"));
				dtoMember.setPwd(mr.getParameter("pwd"));
				dtoMember.setId(mr.getParameter("id"));

				System.out.println(mr.getParameter("id"));
				dao.updateMemberData(dtoMember);




			}else if(mr.getParameter("body")==null||mr.getParameter("height")==null){
				CustomInfoDTO dtoMember = new CustomInfoDTO();

				dtoMember.setJob(mr.getParameter("job"));
				dtoMember.setAddress(mr.getParameter("address"));
				dtoMember.setTel(mr.getParameter("tel"));
				dtoMember.setPicture(mr.getFilesystemName("picture"));
				dtoMember.setContent(mr.getParameter("content"));
				dtoMember.setPwd(mr.getParameter("pwd"));
				dtoMember.setId(mr.getParameter("id"));


				dao.updateMemberData3(dtoMember);


			}else{
				CustomInfoDTO dtoMember = new CustomInfoDTO();

				dtoMember.setJob(mr.getParameter("job"));
				dtoMember.setAddress(mr.getParameter("address"));
				dtoMember.setHeight(mr.getParameter("height"));
				dtoMember.setBody(mr.getParameter("body"));
				dtoMember.setTel(mr.getParameter("tel"));
				dtoMember.setContent(mr.getParameter("content"));
				dtoMember.setPwd(mr.getParameter("pwd"));
				dtoMember.setId(mr.getParameter("id"));


				System.out.println(mr.getParameter("id"));
				dao.updateMemberData2(dtoMember);


				url = "/five/index.do";
				forward(req, resp, url);
			}

		} else if (uri.indexOf("updateMember.do") != -1) {

			HttpSession session = req.getSession();

			String MemberId = (String)session.getAttribute("id");

			CustomInfoDTO dtoMember = dao.getReadMemberData(MemberId);

			req.setAttribute("imagePathMember", imagePathMember);
			System.out.println("ã�ƶ�" + imagePathMember);
			if (dtoMember == null) {
				url = cp + "/five/loginMember.do";
				resp.sendRedirect(url);

			}

			req.setAttribute("dtoMember", dtoMember);
			req.setAttribute("MemberId", MemberId);

			url = "/fiveTing/joinupdate.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("searchId_ok.do") != -1) {

			String MemberId = req.getParameter("id");

			int num = dao.searchId(MemberId);

			if (num == 1) {
				req.setAttribute("message", "���̵� �ߺ�");

			} else {
				req.setAttribute("message", "���̵� ��밡���մϴ�");
				req.setAttribute("messageid", MemberId);

			}
			url = "/fiveTing/joinMember.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("profile.do") != -1) {

			HttpSession session = req.getSession();

			String id = (String)session.getAttribute("id");

			CustomInfoDTO dtoProfile = dao.getReadProfile(id);
			req.setAttribute("name", dtoProfile.getName());
			req.setAttribute("gender", dtoProfile.getGender());
			req.setAttribute("age", dtoProfile.getAge());
			req.setAttribute("id", dtoProfile.getId());
			req.setAttribute("pwd", dtoProfile.getPwd());
			req.setAttribute("job", dtoProfile.getJob());
			req.setAttribute("address", dtoProfile.getAddress());
			req.setAttribute("height", dtoProfile.getHeight());
			req.setAttribute("body", dtoProfile.getBody());
			req.setAttribute("tel", dtoProfile.getTel());
			req.setAttribute("score", dtoProfile.getScore());
			req.setAttribute("content", dtoProfile.getContent());
			req.setAttribute("picture", dtoProfile.getPicture());

			url = "/fiveTing/profile.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("profileOther.do") != -1) {


			String id = req.getParameter("m_id");
			System.out.println(req.getParameter("m_id"));
			System.out.println(id);


			CustomInfoDTO dtoProfile = dao.getReadProfile(id);

			req.setAttribute("name", dtoProfile.getName());
			req.setAttribute("gender", dtoProfile.getGender());
			req.setAttribute("age", dtoProfile.getAge());
			req.setAttribute("id", dtoProfile.getId());
			req.setAttribute("pwd", dtoProfile.getPwd());
			req.setAttribute("job", dtoProfile.getJob());
			req.setAttribute("address", dtoProfile.getAddress());
			req.setAttribute("height", dtoProfile.getHeight());
			req.setAttribute("body", dtoProfile.getBody());
			req.setAttribute("tel", dtoProfile.getTel());
			req.setAttribute("score", dtoProfile.getScore());
			req.setAttribute("content", dtoProfile.getContent());
			req.setAttribute("picture", dtoProfile.getPicture());


			req.setAttribute("u_id", dtoProfile.getId());

			url = "/fiveTing/profileOther.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("updateScore.do") != -1) {


			String u_id = req.getParameter("u_id");



			CustomInfoDTO dtoProfile = dao.getReadProfile(u_id);

			// String id = req.getParameter("id");
			int receivedScore = Integer.parseInt(req.getParameter("btnScore"));

			System.out.println("���� ����:" + receivedScore);
			System.out.println("���� ���̵�:" +u_id);
			int postScore = (dtoProfile.getScore() + receivedScore) / 2; // ���� ������ �޾ƿ�
			// ������ �����
			// ����.


			System.out.println(postScore);

			dao.updateScore(u_id, postScore);

			req.setAttribute("preScore", dtoProfile.getScore());

			url = "/fiveTing/closePopup.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("scorePopup.do") != -1) {

			String u_id = req.getParameter("u_id");
			req.setAttribute("u_id", u_id);
			url = "/fiveTing/scorePopup.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("qnaEmail.do") != -1) {

			url = "/fiveTing/qnaEmail.jsp";
			forward(req, resp, url);
		} else if (uri.indexOf("qnaEmailFinish.do") != -1) {
			

			url = "/five/index.do";
			forward(req, resp, url);
			
			
		} else if (uri.indexOf("qnaEmail_ok.do") != -1) {

			String mail_senderName = req.getParameter("mail_senderName");
			String mail_senderEmail = req.getParameter("mail_senderEmail");
			String mail_subject = req.getParameter("mail_subject");
			String mail_content = req.getParameter("mail_content");

			String mail_receiverEmail = "spurscho@naver.com";

			req.setAttribute("mail_subject", mail_subject);
			req.setAttribute("mail_senderEmail", mail_senderEmail);
			req.setAttribute("mail_senderName", mail_senderName);
			req.setAttribute("mail_content", mail_content);
			req.setAttribute("mail_receiverEmail", mail_receiverEmail);

			url = "/fiveTing/qnaEmail_ok.jsp";
			forward(req, resp, url);

		}
		// //////// RESTAURANT /////////////
		else if (uri.indexOf("restaurant.do") != -1) {

			String pageNum = req.getParameter("pageNum");
			int currentPage = 1;

			if (pageNum != null) {
				currentPage = Integer.parseInt(pageNum);
			}

			int numPerPage = 5;
			int start = (currentPage - 1) * numPerPage + 1;
			int end = currentPage * numPerPage;

			int dataCount = dao.getDataCountRes();
			int totalPage = mu.getPageCount(numPerPage, dataCount);

			List<RestaurantDTO> lists = dao.getLists(start, end);

			String listUrl = cp + "/five/restaurant.do";
			String pageIndexList = mu.pageIndexList(currentPage, totalPage,
					listUrl);

			req.setAttribute("lists", lists);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("pageNum", currentPage);

			url = "/fiveTing/restaurant.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("addResPopup.do") != -1) {

			url = "/fiveTing/addResPopup.jsp";
			forward(req, resp, url);
		} else if (uri.indexOf("addRes.do") != -1) {
			// ���� ���ε�
			String encType = "UTF-8";
			int maxSize = 10 * 1024 * 1024;

			MultipartRequest mr = new MultipartRequest(req, pathRes, maxSize,
					encType, new DefaultFileRenamePolicy());

			// DB�� ���� ���� ����
			if (mr.getFile("res_picture") != null) {
				System.out.println("null�� �ƴϿ���");
				RestaurantDTO res_dto = new RestaurantDTO();
				int maxNum = dao.getMaxNumRes();
				res_dto.setNum(maxNum + 1);
				res_dto.setName(mr.getParameter("res_name"));
				res_dto.setContent(mr.getParameter("res_content"));
				res_dto.setHomepage(mr.getParameter("res_homepage"));
				res_dto.setAddress(mr.getParameter("res_address"));
				res_dto.setTel(mr.getParameter("res_tel"));
				res_dto.setPicture(mr.getFilesystemName("res_picture"));

				dao.insertDataRes(res_dto);
			}

			url = "/fiveTing/closePopup.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("deleteRes.do") != -1) {
			int num = Integer.parseInt(req.getParameter("num"));
			int pageNum = Integer.parseInt(req.getParameter("pageNum"));

			RestaurantDTO delRes_dto = dao.getReadRes(num);

			if (delRes_dto == null) {
				return;
			}

			// ���� ����
			FileManager.doFileDelete(delRes_dto.getPicture(), pathRes);

			// DB ���� ����
			dao.deleteResData(num);
			url = cp + "/five/restaurant.do?pageNum=" + pageNum;
			resp.sendRedirect(url);
		}

		// ////////// DATEPLACE //////////
		else if (uri.indexOf("datePlace.do") != -1) {

			String pageNum = req.getParameter("pageNum");
			int currentPage = 1;

			if (pageNum != null) {
				currentPage = Integer.parseInt(pageNum);
			}

			int numPerPage = 5;
			int start = (currentPage - 1) * numPerPage + 1;
			int end = currentPage * numPerPage;

			int dataCount = dao.getDataCountDatePlace();
			int totalPage = mu.getPageCount(numPerPage, dataCount);

			List<DatePlaceDTO> lists = dao.getListsDatePlace(start, end);

			String listUrl = cp + "/five/datePlace.do";
			String pageIndexList = mu.pageIndexList(currentPage, totalPage,
					listUrl);

			req.setAttribute("lists", lists);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("pageNum", currentPage);

			url = "/fiveTing/datePlace.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("addDatePlacePopup.do") != -1) {

			url = "/fiveTing/addDatePlacePopup.jsp";
			forward(req, resp, url);
		} else if (uri.indexOf("addDatePlace.do") != -1) {
			// ���� ���ε�
			String encType = "UTF-8";
			int maxSize = 10 * 1024 * 1024;

			MultipartRequest mr = new MultipartRequest(req, pathDatePlace,
					maxSize, encType, new DefaultFileRenamePolicy());

			// DB�� ���� ���� ����
			if (mr.getFile("datePlace_picture") != null) {
				System.out.println("null�� �ƴϿ���");
				DatePlaceDTO date_dto = new DatePlaceDTO();
				int maxNum = dao.getMaxNumDatePlace();
				date_dto.setNum(maxNum + 1);
				date_dto.setName(mr.getParameter("datePlace_name"));
				date_dto.setContent(mr.getParameter("datePlace_content"));
				date_dto.setHomepage(mr.getParameter("datePlace_homepage"));
				date_dto.setAddress(mr.getParameter("datePlace_address"));
				date_dto.setTel(mr.getParameter("datePlace_tel"));
				date_dto.setPicture(mr.getFilesystemName("datePlace_picture"));

				dao.insertDataDatePlace(date_dto);
			}

			url = "/fiveTing/closePopup.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("deleteDatePlace.do") != -1) {
			int num = Integer.parseInt(req.getParameter("num"));
			int pageNum = Integer.parseInt(req.getParameter("pageNum"));

			DatePlaceDTO delDate_dto = dao.getReadDatePlace(num);

			if (delDate_dto == null) {
				return;
			}

			// ���� ����
			FileManager.doFileDelete(delDate_dto.getPicture(), pathDatePlace);

			// DB ���� ����
			dao.deleteDatePlaceData(num);
			url = cp + "/five/datePlace.do?pageNum=" + pageNum;
			resp.sendRedirect(url);
		} else if (uri.indexOf("index.do") != -1) {

			url = "/fiveTing/index.jsp";
			forward(req, resp, url);



		}else if (uri.indexOf("matching.do") != -1) {

			String pageNum = req.getParameter("pageNum");
			int currentPage = 1;

			if (pageNum != null) {
				currentPage = Integer.parseInt(pageNum);
			}

			int numPerPage = 5;
			int start = (currentPage - 1) * numPerPage + 1;
			int end = currentPage * numPerPage;

			int dataCount = dao.getDataCountCustomInfo();
			int totalPage = mu.getPageCount(numPerPage, dataCount);

			List<CustomInfoDTO> lists = dao.getListsCustomInfo(start, end);

			String listUrl = cp + "/five/matching.do";
			String pageIndexList = mu.pageIndexList(currentPage, totalPage,
					listUrl);

			req.setAttribute("lists", lists);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("pageNum", currentPage);

			url = "/fiveTing/matching.jsp";
			forward(req, resp, url);

		}else if (uri.indexOf("matchAccept.do") != -1) {

			String senderId = req.getParameter("senderId");
			String receiverId = req.getParameter("receiverId");

			dao.getMatchingList(senderId, receiverId);

			resp.setContentType("text/html;charset=UTF-8");

			PrintWriter out = resp.getWriter();

			out.print("<script type='text/javascript'>");
			out.print("alert('��û�Ǿ����ϴ�');");
			out.print("history.back();");//�ڷΰ���
			out.print("</script>");

		}else if (uri.indexOf("matchDeny.do") != -1) {//������� �����ϴ¹�ư������ �����Ҽ���

			String senderId = req.getParameter("senderId");
			String receiverId = req.getParameter("receiverId");

			dao.delMatchingList(senderId, receiverId);


		}else if (uri.indexOf("service.do") != -1) {

			url = "/fiveTing/service.jsp";
			forward(req, resp, url);

		}else if (uri.indexOf("soge.do") != -1) {

			url = "/fiveTing/soge.jsp";
			forward(req, resp, url);

		}else if (uri.indexOf("qna.do") != -1) {

			url = "/fiveTing/qna.jsp";
			forward(req, resp, url);

		}else if(uri.indexOf("maPopup.do")!=-1){


			String id = req.getParameter("id");
			CustomInfoDTO dto = dao.getReadProfile(id);
			List<FollowDTO> fdto = dao.followData(id);//��Ī��û�� ���̵� ��ȸ(SENDERID)

			imagePath = cp + "/pds/saveFile";
			req.setAttribute("imagePath", imagePath);

			if(dto==null){
				url = cp + "/five/login.do";
				resp.sendRedirect(url);

			}

			req.setAttribute("dto", dto);
			req.setAttribute("id", id);
			req.setAttribute("fdto", fdto);

			url = "/fiveTing/maPopup.jsp";
			forward(req, resp, url);



		}else if(uri.indexOf("addFollow.do")!=-1){
			
			String senderId = req.getParameter("senderId");
			String receiverId = req.getParameter("receiverId");
			
			
			
			dao.updateAccept(senderId, receiverId);
			dao.getMatchingList(receiverId, senderId);
			dao.updateAccept(receiverId, senderId);
			
			resp.sendRedirect(cp+"/five/maPopup.do?id="+receiverId);

			
		}else if(uri.indexOf("reason.do")!=-1){
			
			String id = req.getParameter("id");
			dao.deleteMemberData(id);
			String sel1 = req.getParameter("sel1");
			String sel2 = req.getParameter("sel2");
			String reason = sel1+sel2;
			
			dao.surveyInsertData(reason);
			
			HttpSession session = req.getSession();
			session.removeAttribute("MemberInfo");
			session.removeAttribute("id");
			session.invalidate();// ��������
			url ="/five/index.do";
			forward(req, resp, url);
			
		}
	}
}
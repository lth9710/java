package com.fiveTing;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.board.BoardDTO;
import com.join.MemberDTO;

public class FiveTingDAO {


	private Connection conn;

	public FiveTingDAO(Connection conn) {
		this.conn = conn;
	}



	public int insertData(ChatDTO dto){

		int result=0;
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql="insert into chat(id,content,created,subnum) ";
			//나중에 senderid와 receiver id 로 고쳐서 수정
			sql+="values (?,?,sysdate,CCC.NEXTVAL)";


			pstmt = conn.prepareStatement(sql);


			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getContent());
			result = pstmt.executeUpdate();

			pstmt.close();


		} catch (Exception e) {
			System.out.println(e.toString());

		}
		return result;

	}



	//채팅 dto값(id,내용,날짜 가져오기)
	public List<ChatDTO> getList(){

		List<ChatDTO> lists = new ArrayList<ChatDTO>();

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "select id,content,to_char(created,'YYYY-MM-DD:HH24:MM:SS') created,subnum ";
			sql+="from Chat order by subnum";

			pstmt=conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while(rs.next()){

				ChatDTO dto = new ChatDTO();

				dto.setId(rs.getString("id"));
				dto.setContent(rs.getString("content"));
				dto.setCreated(rs.getString("created"));

				lists.add(dto);
			}
			pstmt.close();
			rs.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return lists;

	}





	//채팅의 개수알아보는메소드
	public int getDataCount() {

		int dataCount = 0;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {

			sql = "select nvl(count(*),0) from chat";

			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dataCount = rs.getInt(1);
			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dataCount;
	}



	/*// 준 숫자 사이의 rownum에 해당하는 데이터가져오기
	public List<ChatDTO> getLists(int start, int end) {

		List<ChatDTO> lists = new ArrayList<ChatDTO>();

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {

			sql = "select * from (";
			sql += "select rownum rnum, data.* from (";
			sql += "select id,content,to_char(created, 'YYYY-MM-DD HH24:MM:SS') created from chat ";
			sql += "order by created) data) ";
			sql += "where rnum >= ? and rnum <= ?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, start);
			pstmt.setInt(2, end);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				ChatDTO dto = new ChatDTO();

				dto.setId(rs.getString("id"));
				dto.setContent(rs.getString("content"));
				dto.setCreated(rs.getString("created"));

				lists.add(dto);

			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return lists;

	}
	 */






	//기능 <매칭신청버튼>

	public void getMatchingList(String senderId,String receiverId){

		PreparedStatement pstmt = null;
		int result = 0;
		String sql;

		try {

			sql = "insert into follow(senderId,created,receiverId,ACCEPT) values (?,sysdate,?,0) "; 

			pstmt=conn.prepareStatement(sql);

			pstmt.setString(1, senderId);
			pstmt.setString(2, receiverId);

			result=pstmt.executeUpdate();


		} catch (Exception e) {
			System.out.println(e.toString());
		}


	}


	//매칭닫기버튼 누를시 실행될 follow delete sql문

	public void delMatchingList(String senderId,String receiverId){

		PreparedStatement pstmt = null;
		int result = 0;
		String sql;


		try {

			sql = "delete follow where senderId=? and receiverId=? "; 

			pstmt=conn.prepareStatement(sql);

			pstmt.setString(1, senderId);
			pstmt.setString(2, receiverId);

			result=pstmt.executeUpdate();


		} catch (Exception e) {
			System.out.println(e.toString());
		}




	}



	//내 아이디에 해당하는 데이터가져오기 ( 자기아이디에 해당하는만큼의 매칭버튼을 가져오기위함)
	public List<FollowDTO> getMyFollow(String myId){

		List<FollowDTO> followLists = new ArrayList<FollowDTO>();

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "select senderId,receiverId,to_char(created,'YYYY-MM-DD:HH24:MM:SS') created ";
			sql+="from follow where receiverId=? order by created";

			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, myId);

			rs = pstmt.executeQuery();

			while(rs.next()){

				FollowDTO dto = new FollowDTO();

				dto.setSenderId(rs.getString("senderId"));
				dto.setReceiverId(rs.getString("receiverId"));
				dto.setCreated(rs.getString("created"));

				followLists.add(dto);
			}
			pstmt.close();
			rs.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return followLists;

	}


	//senderId와 receiverId에 해당하는 채팅만 가져오기
	public List<ChatDTO> getChatList(String chatId , String receiverId){

		List<ChatDTO> lists = new ArrayList<ChatDTO>();

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "select id,content,to_char(created,'YYYY-MM-DD:HH24:MM:SS') created,subnum ";
			sql+="from Chat where id=? or id=?	order by subnum";

			pstmt=conn.prepareStatement(sql);


			pstmt.setString(1, chatId);
			pstmt.setString(2, receiverId);


			rs = pstmt.executeQuery();

			while(rs.next()){

				ChatDTO dto = new ChatDTO();

				dto.setId(rs.getString("id"));
				dto.setContent(rs.getString("content"));
				dto.setCreated(rs.getString("created"));
				dto.setSubnum(rs.getInt("subnum"));
				lists.add(dto);
			}
			pstmt.close();
			rs.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return lists;

	}



	//정아 dao 복사붙여넣기부분
	//num의 max값 반환 메소드
	public int getMaxNum(){

		int maxNum = 0;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "select nvl(max(num),0) from reviewart";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if(rs.next()){
				maxNum = rs.getInt(1);
			}
			rs.close();
			pstmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return maxNum;
	}

	//입력
	public int insertData(ReviewArtDTO dto){

		int result = 0;
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "insert into reviewart (num,id,name,content,";
			sql+= "created,subject,picture,hitCount) ";
			sql+= "values (?,?,?,?,sysdate,?,?,0)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getId());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getSubject());
			pstmt.setString(6, dto.getPicture());

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public int insertData2(ReviewArtDTO dto){
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "insert into reviewart (num,id,name,content,";
			sql+= "created,picture,subject,hitCount) ";
			sql+= "values (?,?,?,?,sysdate,'없음',?,0)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getId());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getSubject());
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	//전체데이터 출력	
	public List<ReviewArtDTO> getReviewLists(int start, int end, String searchKey, String searchValue) {

		List<ReviewArtDTO> lists = new ArrayList<ReviewArtDTO>();

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {

			searchValue = "%" + searchValue + "%";

			sql = "select * from (";
			sql+= "select rownum rnum, data.* from (";
			sql+= "select num, id, name, content, to_char(created, 'YYYY-MM-DD') created,";
			sql+= "subject, picture, hitCount ";
			sql+= "from reviewart where " + searchKey + " like ? ";
			sql+= "order by num desc) data) ";
			sql+= "where rnum >= ? and rnum <= ?"; 

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, searchValue);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				ReviewArtDTO dto = new ReviewArtDTO();

				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setContent(rs.getString("content"));
				dto.setCreated(rs.getString("created"));
				dto.setSubject(rs.getString("subject"));
				dto.setPicture(rs.getString("picture"));
				dto.setHitCount(rs.getInt("hitCount"));
				lists.add(dto);

			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return lists;

	}

	// 전체 데이터 갯수
	public int getDataCount(String searchKey, String searchValue) {

		int dataCount = 0;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {

			searchValue = "%" + searchValue + "%";

			sql = "select nvl(count(*),0) from reviewart ";
			sql+= "where "+searchKey+" like ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchValue);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dataCount = rs.getInt(1);
			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return dataCount;
	}

	// 한개의 데이터 읽기
	public ReviewArtDTO getReadData(int num) {

		ReviewArtDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "select num,id,name,content,to_char(created, 'YYYY-MM-DD') created,";
			sql += "subject,picture,hitCount ";
			sql += "from reviewart where num=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new ReviewArtDTO();

				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setContent(rs.getString("content"));
				dto.setCreated(rs.getString("created"));
				dto.setSubject(rs.getString("subject"));
				dto.setPicture(rs.getString("picture"));
				dto.setHitCount(rs.getInt("hitCount"));

			}
			rs.close();
			pstmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	// 조회수 증가
	public int updatehitCount(int num) {
		int result = 0;

		PreparedStatement pstmt = null;
		String sql;

		try {

			sql = "update reviewart set hitCount=hitCount+1 ";
			sql += "where num=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, num);

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	// 수정
	public int updateData(ReviewArtDTO dto) {
		int result = 0;

		PreparedStatement pstmt = null;
		String sql;

		try {

			sql = "update reviewart set content=?,";
			sql+= "subject=?, name=?,picture=? where num=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getContent());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getPicture());
			pstmt.setInt(5, dto.getNum());//오류로 예상되는부분 2

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public int updateData2(ReviewArtDTO dto) {
		int result = 0;

		PreparedStatement pstmt = null;
		String sql;

		try {

			sql = "update reviewart set content=?,";
			sql+= "subject=?, name=? where num=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getContent());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getName());
			pstmt.setInt(4, dto.getNum());//오류로 예상되는부분 2

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	// 삭제
	public void deleteData(int num){
		int result = 0;

		
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "delete reviewart where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			result = pstmt.executeUpdate();

			pstmt.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	}


	//정아 dao 복사붙여넣기부분 끝


	public String getSysDate() { // 현재 시간을가져오는 기능

		PreparedStatement pstmt = null;
		String sql;
		ResultSet rs = null;
		String sysdate = null;

		try {
			sql = "select to_char(sysdate,'YYYY-MM-DD:HH24:MM:DD') from dual ";
			pstmt = conn.prepareStatement(sql);

			rs =  pstmt.executeQuery();

			sysdate = rs.getString(1);
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}return sysdate;
	}


	public ReviewArtDTO getReadData(String userId){//아이디를가지고 데이터가져오기

		ReviewArtDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql="select * ";
			sql+="from custominfo where Id=?";

			pstmt=conn.prepareStatement(sql);

			pstmt.setString(1, userId);

			rs = pstmt.executeQuery();


			if(rs.next()){

				dto = new ReviewArtDTO();

				dto.setId(rs.getString("Id"));
				dto.setName(rs.getString("Name"));
			}

			rs.close();
			pstmt.close();


		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	public ReviewArtDTO getReviewReadData(int num){

		ReviewArtDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;


		try {
			sql="select num,id,name,content,created,subject,";
			sql+="hitcount,picture ";
			sql+="from reviewart where num=?";


			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, num);

			rs=pstmt.executeQuery();

			if(rs.next()){
				dto = new ReviewArtDTO();

				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setContent(rs.getString("content"));
				dto.setSubject(rs.getString("subject"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setCreated(rs.getString("created"));
				dto.setPicture(rs.getString("picture"));


			}

			rs.close();
			pstmt.close();


		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;



	}
//기현이형 dao 복사부분
	
	public int insertMemberData(CustomInfoDTO dto) {
		// Height int에서 string 수정
		// 회원가입시 score 0점 설정

		int result = 0;

		PreparedStatement pstmt = null;
		String sql;

		try {

			sql = "insert into CUSTOMINFO ";
			sql += "(name, gender, age, job, address, id, pwd, height, body,";
			sql += "tel, content, picture, score) ";
			sql += "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getGender());// 남,여
			pstmt.setInt(3, dto.getAge());
			pstmt.setString(4, dto.getJob());
			pstmt.setString(5, dto.getAddress());
			pstmt.setString(6, dto.getId());
			pstmt.setString(7, dto.getPwd());
			pstmt.setString(8, dto.getHeight());
			pstmt.setString(9, dto.getBody());
			pstmt.setString(10, dto.getTel());
			pstmt.setString(11, dto.getContent());
			pstmt.setString(12, dto.getPicture());
			pstmt.setInt(13, dto.getScore());// 외모점수 0

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;

	}

	/** 한명의 데이터 조회 */
	public CustomInfoDTO getReadMemberData(String id) {

		CustomInfoDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "select name, gender, age, job, address, id, pwd, height, body,";
			sql += "tel, content, picture, score ";
			sql += "from CUSTOMINFO where id=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				dto = new CustomInfoDTO();

				dto.setName(rs.getString("name"));
				dto.setGender(rs.getString("gender"));
				dto.setAge(Integer.parseInt(rs.getString("age")));
				dto.setJob(rs.getString("job"));
				dto.setAddress(rs.getString("address"));
				dto.setId(rs.getString("id"));
				dto.setPwd(rs.getString("pwd"));
				dto.setHeight(rs.getString("height"));
				dto.setBody(rs.getString("body"));
				dto.setTel(rs.getString("tel"));
				dto.setContent(rs.getString("content"));
				dto.setPicture(rs.getString("picture"));
				dto.setScore(Integer.parseInt(rs.getString("score")));
			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;

	}

	/** 회원정보삭제 */
	public int deleteMemberData(String id) {

		int result = 0;

		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "delete CUSTOMINFO where id=?";
			// id와 pwd 일치하면 삭제

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, id);

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;

	}

	/** 회원정보수정 */
	public int updateMemberData(CustomInfoDTO dto) {

		int result = 0;
		PreparedStatement pstmt = null;
		String sql;

		try {

			sql = "update CUSTOMINFO set pwd=?, job=?, address=?,";
			sql += "height=?, body=?, tel=?, content=?, picture=? ";
			sql += "where id=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getPwd());
			pstmt.setString(2, dto.getJob());
			pstmt.setString(3, dto.getAddress());
			pstmt.setString(4, dto.getHeight());
			pstmt.setString(5, dto.getBody());
			pstmt.setString(6, dto.getTel());
			pstmt.setString(7, dto.getContent());
			pstmt.setString(8, dto.getPicture());
			pstmt.setString(9, dto.getId());

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	/** 회원정보수정 */
	public int updateMemberData2(CustomInfoDTO dto) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "update CUSTOMINFO set pwd=?, job=?, address=?,";
			sql += "height=?, body=?, tel=?, content=? ";
			sql += "where id=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getPwd());
			pstmt.setString(2, dto.getJob());
			pstmt.setString(3, dto.getAddress());
			pstmt.setString(4, dto.getHeight());
			pstmt.setString(5, dto.getBody());
			pstmt.setString(6, dto.getTel());
			pstmt.setString(7, dto.getContent());
			pstmt.setString(8, dto.getId());
			
			System.out.println(dto.getJob());
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	
public int updateMemberData3(CustomInfoDTO dto) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "update CUSTOMINFO set pwd=?, job=?, address=?,";
			sql += "tel=?, content=? ";
			sql += "where id=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getPwd());
			pstmt.setString(2, dto.getJob());
			pstmt.setString(3, dto.getAddress());
			pstmt.setString(4, dto.getTel());
			pstmt.setString(5, dto.getContent());
			pstmt.setString(6, dto.getId());
			
			System.out.println(dto.getJob());
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	/** 아이디 검색 */
	public int searchId(String id) {

		CustomInfoDTO dto;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		int num = 0;
		try {
			sql = "select id from custominfo where id=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, id);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				num = 1;

			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return num;
	}

	/** 신청한 사람 ID 조회 */
	public List<FollowDTO> followData(String id) {
		//follow table receiveId(매칭신청받은사람)= 매칭 신청한 아이디 조회
			
			List<FollowDTO> fdto = new ArrayList<FollowDTO>();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql;
			
			try {
				
				sql = "SELECT DISTINCT(senderid), receiverid,created, accept ";
				sql+= "FROM FOLLOW ";
				sql+= "where receiverid=? order by created desc";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, id);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					
					FollowDTO dto = new FollowDTO();
					
					dto.setSenderId(rs.getString("senderId"));
					dto.setCreated(rs.getString("created"));
					dto.setReceiverId(rs.getString("receiverId"));
					dto.setAccept(rs.getInt("accept"));


					fdto.add(dto);

				}
				
				pstmt.close();
				rs.close();
				
				
			} catch (Exception e) {
				System.out.println(e.toString());
			}
			return fdto;
		
		}
	// /////////////////// PROFILE //////////////////
	/** [profile]한개의 프로필 데이터 읽기(getReadData) */
	public CustomInfoDTO getReadProfile(String id) {

		CustomInfoDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "select name,gender,age,job,address,id,";
			sql += "pwd,height,body,tel,content,picture,score ";
			sql += "from custominfo where id=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new CustomInfoDTO();

				dto.setName(rs.getString("name"));
				dto.setGender(rs.getString("gender"));
				dto.setAge(rs.getInt("age"));
				dto.setJob(rs.getString("job"));
				dto.setAddress(rs.getString("address"));
				dto.setId(rs.getString("id"));
				dto.setPwd(rs.getString("pwd"));
				dto.setHeight(rs.getString("height"));
				dto.setBody(rs.getString("body"));
				dto.setTel(rs.getString("tel"));
				dto.setContent(rs.getString("content"));
				dto.setPicture(rs.getString("picture"));
				dto.setScore(rs.getInt("score"));
			}
			rs.close();
			pstmt.close();

		} catch (Exception e) {

		}

		return dto;
	}

	/** [profile]회원의 외모점수 부여하기. */
	public int updateScore(String id, int receivedScore) {
		int result = 0;

		PreparedStatement pstmt = null;
		String sql;

		CustomInfoDTO dto = null;

		try {

			dto = getReadProfile(id);

			int score = dto.getScore();

			sql = "update custominfo set score=? ";
			sql += "where id=?";

			pstmt = conn.prepareStatement(sql);

			// 5점과 5점을 받는다면

			score = (score + receivedScore) / 2;

			pstmt.setInt(1, score);
			pstmt.setString(2, id);

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	// //////////RESTAURANT//////////

	/** [Restaurant] 전체데이터 출력 */
	public List<RestaurantDTO> getLists(int start, int end) {

		List<RestaurantDTO> lists = new ArrayList<RestaurantDTO>();

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {

			sql = "select * from (";
			sql += "select rownum rnum, data.* from (";
			sql += "select num,name,content,homepage,picture,address,tel from restaurant ";
			sql += "order by num asc) data) ";
			sql += "where rnum >= ? and rnum <= ?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, start);
			pstmt.setInt(2, end);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				RestaurantDTO dto = new RestaurantDTO();

				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setContent(rs.getString("content"));
				dto.setHomepage(rs.getString("homepage"));
				dto.setPicture(rs.getString("picture"));
				dto.setAddress(rs.getString("address"));
				dto.setTel(rs.getString("tel"));

				lists.add(dto);

			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return lists;

	}

	/** [Restaurant] num의 max값 반환 */
	public int getMaxNumRes() {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		int result = 0;

		try {
			sql = "select nvl(max(num), 0) from restaurant";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
			}

			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	/** [Restaurant] 입력 */
	public int insertDataRes(RestaurantDTO dto) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql;

		try {
			sql = "insert into restaurant (num,name,content,picture,homepage,address,tel ) ";
			sql += "values (?, ?, ?, ?, ?, ?, ?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPicture());
			pstmt.setString(5, dto.getHomepage());
			pstmt.setString(6, dto.getAddress());
			pstmt.setString(7, dto.getTel());

			result = pstmt.executeUpdate();

			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	/** [Restaurant]한 개의 레스토랑 데이터 읽기 */
	public RestaurantDTO getReadRes(int num) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		RestaurantDTO res_dto = null;
		String sql;

		try {
			sql = "select num,name,content,picture,homepage,address,tel from restaurant where num=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				res_dto = new RestaurantDTO();

				res_dto.setNum(rs.getInt("num"));
				res_dto.setName(rs.getString("name"));
				res_dto.setContent(rs.getString("content"));
				res_dto.setHomepage(rs.getString("homepage"));
				res_dto.setPicture(rs.getString("picture"));
				res_dto.setAddress(rs.getString("address"));
				res_dto.setTel(rs.getString("tel"));
			}

			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return res_dto;
	}

	/** [Restaurant] DB 삭제 */
	public int deleteResData(int num) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "delete restaurant where num=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, num);

			result = pstmt.executeUpdate();

			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	/** [Restaurant] 전체 데이터 갯수 */
	public int getDataCountRes() {

		int dataCount = 0;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {

			sql = "select nvl(count(*),0) from restaurant";

			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dataCount = rs.getInt(1);
			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dataCount;
	}

	// //////////DATEPLACE//////////
	/** [Dateplace] 전체데이터 출력 */
	public List<DatePlaceDTO> getListsDatePlace(int start, int end) {

		List<DatePlaceDTO> lists = new ArrayList<DatePlaceDTO>();

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {

			sql = "select * from (";
			sql += "select rownum rnum, data.* from (";
			sql += "select num,name,content,homepage,picture,address,tel from dateplace ";
			sql += "order by num asc) data) ";
			sql += "where rnum >= ? and rnum <= ?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, start);
			pstmt.setInt(2, end);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				DatePlaceDTO dto = new DatePlaceDTO();

				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setContent(rs.getString("content"));
				dto.setHomepage(rs.getString("homepage"));
				dto.setPicture(rs.getString("picture"));
				dto.setAddress(rs.getString("address"));
				dto.setTel(rs.getString("tel"));

				lists.add(dto);

			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return lists;

	}

	/** [Dateplace] num의 max값 반환 */
	public int getMaxNumDatePlace() {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		int result = 0;

		try {
			sql = "select nvl(max(num), 0) from dateplace";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
			}

			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	/** [Dateplace] 입력 */
	public int insertDataDatePlace(DatePlaceDTO dto) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql;

		try {
			sql = "insert into dateplace (num,name,content,picture,homepage,address,tel ) ";
			sql += "values (?, ?, ?, ?, ?, ?, ?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPicture());
			pstmt.setString(5, dto.getHomepage());
			pstmt.setString(6, dto.getAddress());
			pstmt.setString(7, dto.getTel());

			result = pstmt.executeUpdate();

			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	/** [Dateplace]한 개의 레스토랑 데이터 읽기 */
	public DatePlaceDTO getReadDatePlace(int num) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		DatePlaceDTO date_dto = null;
		String sql;

		try {
			sql = "select num,name,content,picture,homepage,address,tel from dateplace where num=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				date_dto = new DatePlaceDTO();

				date_dto.setNum(rs.getInt("num"));
				date_dto.setName(rs.getString("name"));
				date_dto.setContent(rs.getString("content"));
				date_dto.setHomepage(rs.getString("homepage"));
				date_dto.setPicture(rs.getString("picture"));
				date_dto.setAddress(rs.getString("address"));
				date_dto.setTel(rs.getString("tel"));
			}

			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return date_dto;
	}

	/** [Dateplace] DB 삭제 */
	public int deleteDatePlaceData(int num) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "delete dateplace where num=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, num);

			result = pstmt.executeUpdate();

			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	/** [Dateplace] 전체 데이터 갯수 */
	public int getDataCountDatePlace() {

		int dataCount = 0;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {

			sql = "select nvl(count(*),0) from dateplace";

			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dataCount = rs.getInt(1);
			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dataCount;
	}
	
	
	/** [profile] 전체데이터 출력 */
	public List<CustomInfoDTO> getListsCustomInfo(int start, int end) {

		List<CustomInfoDTO> lists = new ArrayList<CustomInfoDTO>();
		CustomInfoDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {

			sql = "select * from (";
			sql += "select rownum rnum, data.* from (";
			sql += "select name,gender,age,job,address,id,";
			sql += "pwd,height,body,tel,content,picture,score from custominfo) data) ";
			sql += "where rnum >= ? and rnum <= ?";
			
			
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, start);
			pstmt.setInt(2, end);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				dto = new CustomInfoDTO();

				dto.setName(rs.getString("name"));
				dto.setGender(rs.getString("gender"));
				dto.setAge(rs.getInt("age"));
				dto.setJob(rs.getString("job"));
				dto.setAddress(rs.getString("address"));
				dto.setId(rs.getString("id"));
				dto.setPwd(rs.getString("pwd"));
				dto.setHeight(rs.getString("height"));
				dto.setBody(rs.getString("body"));
				dto.setTel(rs.getString("tel"));
				dto.setContent(rs.getString("content"));
				dto.setPicture(rs.getString("picture"));
				dto.setScore(rs.getInt("score"));

				lists.add(dto);

			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return lists;

	}

	/** [profile] 전체 데이터 갯수 */
	public int getDataCountCustomInfo() {

		int dataCount = 0;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {

			sql = "select nvl(count(*),0) from custominfo";

			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dataCount = rs.getInt(1);
			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dataCount;
	}

	
	
	public void updateAccept(String senderId,String receiverId){

		PreparedStatement pstmt = null;
		int result = 0;
		String sql;

		try {

			sql = "update follow set ACCEPT=1 WHERE senderId=? and receiverId=?"; 

			pstmt=conn.prepareStatement(sql);

			pstmt.setString(1, senderId);
			pstmt.setString(2, receiverId);

			result=pstmt.executeUpdate();


		} catch (Exception e) {
			System.out.println(e.toString());
		}


	}
	
	public int surveyInsertData(String reason) {

		int result = 0;

		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "insert into survey(reason) ";
			sql += "values(?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, reason);

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;

	}

	
}
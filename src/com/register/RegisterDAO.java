package com.register;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class RegisterDAO {

	//의존성 주입
		private Connection conn;
		
		public RegisterDAO(Connection conn){
			this.conn = conn;
			
			
		}

		
		//1.입력(write.jsp,write_ok.jsp 가 사용함)
		public int insertData(RegisterDTO dto){

			int result = 0;
			
			PreparedStatement pstmt = null;
			String sql;
			
			try {
				
				sql = "insert into naver(userName,userId,users,userPwd,sel1,";
				sql+= "ans2,email1,sel2,tel1,tel2,tel3,check1,check2) ";
				sql+= "values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
				
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, dto.getUserName());
				pstmt.setString(2, dto.getUserId());
				pstmt.setString(3, dto.getUsers());
				pstmt.setString(4, dto.getUserPwd());
				pstmt.setString(5, dto.getSel1());
				pstmt.setString(6, dto.getAns2());
				pstmt.setString(7, dto.getEmail1());
				pstmt.setString(8, dto.getSel2());
				pstmt.setString(9, dto.getTel1());
				pstmt.setString(10, dto.getTel2());
				pstmt.setString(11, dto.getTel3());
				pstmt.setString(12, dto.getCheck1());
				pstmt.setString(13, dto.getCheck2());
				
				result = pstmt.executeUpdate();
				
				pstmt.close();
				
				
				
			} catch (Exception e) {
				try {pstmt.close();} catch (Exception e2) {}				
				try {DBConn.close();} catch (Exception e2) {}
				
				
			
			}
			
			return result;
		}
		
		
		
		//2.데이터 가져오기(list.jsp)
		public List<RegisterDTO> getList(){
			
			List<RegisterDTO> lists = new ArrayList<RegisterDTO>();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql;
			
			try {
				
				sql="select userName,userId,users,userPwd,sel1,";
				sql+="ans2,email1,sel2,tel1,tel2,tel3,check1,check2 ";
				sql+= "from naver";
			
				
				pstmt = conn.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					
					RegisterDTO dto = new RegisterDTO();
					
					dto.setUserName(rs.getString("userName"));
					dto.setUserId(rs.getString("userId"));
					dto.setUsers(rs.getString("users"));
					dto.setUserPwd(rs.getString("userPwd"));
					dto.setSel1(rs.getString("sel1"));
					dto.setAns2(rs.getString("ans2"));
					dto.setEmail1(rs.getString("email1"));
					dto.setSel2(rs.getString("sel2"));
					dto.setTel1(rs.getString("tel1"));
					dto.setTel2(rs.getString("tel2"));
					dto.setTel3(rs.getString("tel3"));
					dto.setCheck1(rs.getString("check1"));
					dto.setCheck2(rs.getString("check2"));
					
					
					lists.add(dto);
				
				}
				
				pstmt.close();
				rs.close();
				
				
				
				
			} catch (Exception e) {
				System.out.println(e.toString());
			}
			return lists;
		}
		
		//3. 클릭했을때 데이터 읽어오기(수정할 데이터 가져오기)
		public RegisterDTO getReadData(String userId){
			
			RegisterDTO dto = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql;
			
			try {

				sql="select userName,userId,users,userPwd,sel1,";
				sql+="ans2,email1,sel2,tel1,tel2,tel3,check1,check2 ";
				sql+= "from naver where userId=?";
			
			
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, userId);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					dto = new RegisterDTO();
					
					dto.setUserName(rs.getString("userName"));
					dto.setUserId(rs.getString("userId"));
					dto.setUsers(rs.getString("users"));
					dto.setUserPwd(rs.getString("userPwd"));
					dto.setSel1(rs.getString("sel1"));
					dto.setAns2(rs.getString("ans2"));
					dto.setEmail1(rs.getString("email1"));
					dto.setSel2(rs.getString("sel2"));
					dto.setTel1(rs.getString("tel1"));
					dto.setTel2(rs.getString("tel2"));
					dto.setTel3(rs.getString("tel3"));
					dto.setCheck1(rs.getString("check1"));
					dto.setCheck2(rs.getString("check2"));
					
					
				}
				rs.close();
				pstmt.close();
				
			} catch (Exception e) {
				System.out.println(e.toString());
			}
			return dto;
		}
		
		
		//수정(update_ok.jsp)
		public int updateData(RegisterDTO dto){
			
			int result = 0;
			
			PreparedStatement pstmt = null;
			String sql;
			
			try {
				
				sql="update naver set users=?,userPwd=?,sel1=?,";
				sql+="ans2=?,email1=?,sel2=?,tel1=?,tel2=?,tel3=?";
				sql+=",check1=?,check2=?";
				sql+="where userId=?";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, dto.getUsers());
				pstmt.setString(2, dto.getUserPwd());
				pstmt.setString(3, dto.getSel1());
				pstmt.setString(4, dto.getAns2());
				pstmt.setString(5, dto.getEmail1());
				pstmt.setString(6, dto.getSel2());
				pstmt.setString(7, dto.getTel1());
				pstmt.setString(8, dto.getTel2());
				pstmt.setString(9, dto.getTel3());
				pstmt.setString(10, dto.getCheck1());
				pstmt.setString(11, dto.getCheck2());
				pstmt.setString(12, dto.getUserId());
				
				result = pstmt.executeUpdate();
				
				pstmt.close();
				
			} catch (Exception e) {
				System.out.println(e.toString());
			
			}
			
			return result;
		}
		
		//삭제(delete_ok.jsp)
		
		public int deleteData(String UserId){
			
			int result =0;
			
			PreparedStatement pstmt = null;
			String sql;
			
			try {
				sql = "delete naver where userId=?";
			
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, UserId);
				
				result = pstmt.executeUpdate();
				
				pstmt.close();
				
				
						
						
				
			} catch (Exception e) {
				System.out.println(e.toString());
			}
			
			return result;
		}
		
		
		
		//검색
		
		
		
		
		
		

	
	
	
	
	
	
	
	
	
	
	
	
}

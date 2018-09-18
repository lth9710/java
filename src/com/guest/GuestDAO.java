package com.guest;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class GuestDAO {

	private Connection conn;

	public GuestDAO(Connection conn) {
		this.conn = conn;
	}

	// num의 마지막 번호
	public int getMaxNum() {

		int maxNum = 0;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {

			sql = "select nvl(max(num),0) from guest";

			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				maxNum = rs.getInt(1);
			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return maxNum;
	}

	// 입력
	public int insertData(GuestDTO dto) {

		int result = 0;

		PreparedStatement pstmt = null;
		String sql;

		try {

			sql = "insert into guest (num, name, email, homepage, content, created, ipaddr) ";
			sql += "values (?, ?, ?, ?, ?, sysdate, ?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getEmail());
			pstmt.setString(4, dto.getHomepage());
			pstmt.setString(5, dto.getContent());
			pstmt.setString(6, dto.getIpAddr());

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;

	}

	//전체데이터 출력
	public List<GuestDTO> getLists(int start, int end) {
		
		List<GuestDTO> lists = new ArrayList<GuestDTO>();
			
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
			try {
				
				sql = "select * from (";
				sql += "select rownum rnum, data.* from (";
				sql += "select num,name,email,homepage,content,to_char(created, 'YYYY-MM-DD HH24:MM:SS') created, ipaddr from guest ";
				sql += "order by num desc) data) ";
				sql += "where rnum >= ? and rnum <= ?";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					
					GuestDTO dto = new GuestDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setHomepage(rs.getString("homepage"));
				dto.setContent(rs.getString("content"));
				dto.setCreated(rs.getString("created"));
				dto.setIpAddr(rs.getString("ipAddr"));
					
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
	public int getDataCount() {

		int dataCount = 0;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			
			sql = "select nvl(count(*),0) from guest";

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

	// 한개의 데이터 읽기
	public GuestDTO getReadData(int num) {

		GuestDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "select num,name,email,homepage,content,created,ipaddr ";
			sql += "from guest where num=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new GuestDTO();

				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setHomepage(rs.getString("homepage"));
				dto.setContent(rs.getString("content"));
				dto.setCreated(rs.getString("created"));
				dto.setIpAddr(rs.getString("ipAddr"));
				

			}
			rs.close();
			pstmt.close();

		} catch (Exception e) {

		}

		return dto;
	}

	
	// 삭제
	public int deleteData(int num){
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "delete guest where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			result = pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
			
		}
		
		return result;
	}
	
	
}

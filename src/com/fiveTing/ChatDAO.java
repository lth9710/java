package com.fiveTing;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fileTest.FileTestDTO;
import com.guest.GuestDTO;

public class ChatDAO {

	private Connection conn;

	public ChatDAO(Connection conn){
		this.conn=conn;
	}

	public int insertData(ChatDTO dto){

		int result=0;
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql="insert into chat(id,content,created,subnum) ";

			sql+="values (?,?,sysdate,BBB.NEXTVAL)";


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




	public List<ChatDTO> getList(){

		List<ChatDTO> lists = new ArrayList<ChatDTO>();

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "select id,content,to_char(created,'YYYY-MM-DD:HH24:MM:SS') created,subnum ";
			sql+="from Chat order by subnum desc";

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

	public List<ChatDTO> getMyList(String id){

		List<ChatDTO> lists = new ArrayList<ChatDTO>();

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "select id,content,to_char(created,'YYYY-MM-DD:HH24:MM:SS') created ";
			sql+="from Chat where id=? order by created";

			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
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

	
}

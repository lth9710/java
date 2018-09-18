package com.fiveTing;

public class ChatDTO {

	private String id;
	private String content;
	private String created;
	private int subnum;
	
	
	public int getSubnum() {
		return subnum;
	}
	public void setSubnum(int subnum) {
		this.subnum = subnum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}

	
	
	
	
}

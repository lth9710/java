package com.fiveTing;

public class CustomInfoDTO {
	
	private String name;
	private String gender;
	private int age;
	private String job;
	private String address;
	private String id;
	private String pwd;
	private String height;
	private String body;
	private String tel;
	private String content;
	private String picture;
	private int score;

	//follow table Ãß°¡
	private String SenderId;
	private String Created;
	private String ReceiveId;
	

	public String getHeight() {
		return height;
	}
	public void setHeight(String height) {
		this.height = height;
	}
	public String getSenderId() {
		return SenderId;
	}
	public void setSenderId(String senderId) {
		SenderId = senderId;
	}
	public String getCreated() {
		return Created;
	}
	public void setCreated(String created) {
		Created = created;
	}
	public String getReceiveId() {
		return ReceiveId;
	}
	public void setReceiveId(String receiveId) {
		ReceiveId = receiveId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
		if(this.score>80){
			this.score = 80;
		}else if(this.score<0){
			this.score = 0;
		}
	}
	
	
	
	
}

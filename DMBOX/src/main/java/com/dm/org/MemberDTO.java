package com.dm.org;

public class MemberDTO {
	private String id;
	private String pw;
	private String name;
	private String address;
	private String tel;
	private String gender;
	private String email;
	private String mail_send_agree;
	
	public MemberDTO(String id, String pw, String name, String address, String tel, String gender, String email) {
		super();
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.address = address;
		this.tel = tel;
		this.gender = gender;
		this.email = email;
	}
	public MemberDTO() {
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMail_send_agree() {
		return mail_send_agree;
	}
	public void setMail_send_agree(String mail_send_agree) {
		this.mail_send_agree = mail_send_agree;
	}
}

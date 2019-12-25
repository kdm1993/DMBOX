package com.dm.org;

import lombok.Data;

@Data
public class MemberDTO {
	private String id;
	private String pw;
	private String name;
	private String postcode;
	private String roadAddress;
	private String jibunAddress;
	private String otherAddress;
	private String tel;
	private String gender;
	private String email;
	private String emailYn;
	private String smsYn;
	private String joinDate;
	private String AuthState;
	private String AuthKey;
}

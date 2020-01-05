package com.dm.org;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Test {

	public static void main(String[] args) throws Exception {
		
		String host = "smtp.naver.com";
		final String user = "aodns114";
		final String password = "aodnsehdals114!";
		String title = "DM BOX 로그인 인증 메일입니다.";
		String content = "";
		Properties props = new Properties();

		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", 465);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");

		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			String un = user;
			String pw = password;

			protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
				return new javax.mail.PasswordAuthentication(un, pw);
			}
		});
		try {
			MimeMessage msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(user, "DM BOX"));
			InternetAddress address = new InternetAddress();
			address = new InternetAddress("kdm1993@naver.com");
			msg.addRecipient(Message.RecipientType.TO, address);
			msg.setSubject(title, "UTF-8");
			msg.setContent(content, "text/html; charset=UTF-8");
			Transport.send(msg);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

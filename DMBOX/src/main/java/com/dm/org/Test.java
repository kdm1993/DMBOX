package com.dm.org;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.activation.DataHandler;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.util.ByteArrayDataSource;

import org.apache.ibatis.session.SqlSession;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;

public class Test {

	public static void main(String[] args) throws Exception {
		String host = "imap.gmail.com";
		final String user = "aodns113";
		final String password = "aodnsehdals114!";
		String title = "DM BOX 로그인 인증 메일입니다.";
		String content = "<div style=\"width: 100%; height:500px; background: #282828; "
				+ "color: white;\"><div style=\"text-align:center;\"><h2><p style=\""
				+ "padding: 0em 0em;text-transform: uppercase;text-decoration: none;"
				+ "font-size: 2.5em;color: #fff;font-weight: bold;\" rel=\"noreferrer "
				+ "noopener\" target=\"_blank\"><span style=\"padding: 3em 0em; text-"
				+ "transform: uppercase; text-decoration: none; font-size: 2.5em; color: "
				+ "rgb(255, 255, 255); font-weight: bold;\">DM</span><span style=\"padding:"
				+ " 3em 0em; text-transform: uppercase; text-decoration: none; font-size: "
				+ "2.5em; color: rgb(188, 20, 20); font-weight: bold;\">BOX</span></p><p "
				+ "style=\"padding: 0em 0em;text-transform: uppercase;text-decoration: none;"
				+ "font-size: 2.5em;color: #fff;font-weight: bold;\" rel=\"noreferrer "
				+ "noopener\" target=\"_blank\"><b style=\"font-size: 10pt;\"><span "
				+ "style=\"font-size: 18pt;\"><br></span></b></p><p style=\"padding: 0em;"
				+ " text-transform: uppercase; text-decoration: none; color: rgb"
				+ "(255, 255, 255); font-weight: bold;\" rel=\"noreferrer noopener\" "
				+ "target=\"_blank\"><span style=\"font-size: 36pt;\"><a href=\""
				+ "http://dmcafe.co.kr/EmailAuth?id="
				+ "target=\"_blank\" style=\"cursor: pointer; white-space: pre;\" "
				+ "rel=\"noreferrer noopener\">이메일 인증</a><span></span></span></p></h2>"
				+ "</div></div>\r\n" + 
				"\r\n" + 
				"\r\n" + 
				"";
		
		Properties prop = System.getProperties();
        prop.put("mail.smtp.starttls.enable", "true");
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.port", "587");
        
        Authenticator auth = new MailAuth();
        
        Session session = Session.getDefaultInstance(prop, auth);
        
        MimeMessage msg = new MimeMessage(session);
    
        try {
            msg.setSentDate(new Date());
            
            msg.setFrom(new InternetAddress(user, "DM BOX"));
            InternetAddress to = new InternetAddress("kdm1993@naver.com");         
            msg.setRecipient(Message.RecipientType.TO, to);            
            msg.setSubject(title, "UTF-8");            
            msg.setDataHandler(new DataHandler(new ByteArrayDataSource(content, "text/html;charset=UTF-8")));
            
            Transport.send(msg);
            
        } catch(AddressException ae) {            
            System.out.println("AddressException : " + ae.getMessage());           
        } catch(MessagingException me) {            
            System.out.println("MessagingException : " + me.getMessage());
        } catch(UnsupportedEncodingException e) {
            System.out.println("UnsupportedEncodingException : " + e.getMessage());			
        }
	}
}

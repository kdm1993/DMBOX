package com.dm.org;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.ibatis.session.SqlSession;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;

public class Test {

	public static void main(String[] args) throws Exception {
		
		try {
			Document doc = Jsoup.connect("https://bbs.ruliweb.com/av/board/300013/read/2692966?")
					.userAgent("Chrome")
					.timeout(20000).get();
			Element body = doc.body();
			
			System.out.println(body.select(".id:nth-child(2)"));
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}

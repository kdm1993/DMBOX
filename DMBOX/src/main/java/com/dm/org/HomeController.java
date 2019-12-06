package com.dm.org;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	public static StringBuilder sb;
	
	private static ArrayList<BoxOfficeDTO> movielist = new ArrayList<BoxOfficeDTO>();
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	SqlSession sql;

	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String come(Model model, HttpServletRequest request) {
		
		if(movielist.size() == 0) {
			Runnable run = new Runnable() {
				public void run() {
					while(true) {
						try {
							Document doc = Jsoup.connect("http://www.maxmovie.com/Chart/Rank/List").get();
							Elements body = doc.select(".ptb");
							
							ArrayList<BoxOfficeDTO> list = new ArrayList<BoxOfficeDTO>();
					
							List<String> grade = new ArrayList<String>();
							List<String> ticketing = new ArrayList<String>();
							List<String> width_poster = new ArrayList<String>();
							List<String> height_poster = new ArrayList<String>();
							List<String> movie_eng_name = new ArrayList<String>();
							
							for(int x=0; x<body.select("a").size(); x+=4) {
								Document doc2 = Jsoup.connect("http://www.maxmovie.com"+body.select("a").get(x).attr("href")).get();
								Elements body2 = doc2.select(".mvbgg");
								
								width_poster.add(body2.attr("style").replace("background: url('", "").replace("') no-repeat", ""));
								height_poster.add(doc2.select(".mspost").select("img").attr("src"));
								
								body2 = doc2.select(".nmvtx");
								movie_eng_name.add(body2.text());
								
							}
							for(int x=1; x<body.select("em").size(); x+=3) {	
								grade.add(body.select("em").get(x).text());
							}
							
							for(int x=0; x<body.select("em").size(); x+=3) {
								ticketing.add(body.select("strong").get(x).text());
							}
							
							
							for(int x=0; x<body.select("img").not("[alt=예매하기]").not("[alt=상세보기]").size(); x++) {
								BoxOfficeDTO bo = new BoxOfficeDTO();
								bo.setWidth_poster(width_poster.get(x));
								bo.setHeight_poster(height_poster.get(x));
								bo.setMovie_name(body.select("img").not("[alt=예매하기]").not("[alt=상세보기]").get(x).attr("alt"));
								bo.setGrade(grade.get(x));
								bo.setTicketing(ticketing.get(x));
								bo.setMovie_eng_name(movie_eng_name.get(x));
								
								list.add(bo);
							}
							movielist = list;
							Thread.sleep(3600000);
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
					
				}
			};
			Thread t = new Thread(run);
			
			t.start();
		}
		
		return "come";
	}
	
	@RequestMapping(value = "/Home", method = RequestMethod.GET)
	public String home(Model model, HttpServletRequest request) {
		
		String key = "69b70fa8443964c77dcc9ddc43bded19";
		
		Calendar date = new GregorianCalendar();
		date.add(Calendar.DATE, -1);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String targetDt = sdf.format(date.getTime());
		
		try {
			/*
			URL url = new URL("http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key="
					+ key + "&targetDt=" + targetDt);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setConnectTimeout(5000);
			con.setReadTimeout(5000);
			con.setRequestMethod("GET");
			con.setDoOutput(false);

			StringBuilder sb = new StringBuilder();
			if (con.getResponseCode() == HttpURLConnection.HTTP_OK) {
				
				BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
				String line;
				while ((line = br.readLine()) != null) {
					sb.append(line).append("\n");
				}
				br.close();
				
			} else {
				System.out.println(con.getResponseMessage());
			}
			
			JSONParser jsonParser = new JSONParser();
	        JSONObject jsonObject = (JSONObject)jsonParser.parse(sb.toString());
	        JSONObject json = (JSONObject)jsonObject.get("boxOfficeResult");
	        JSONArray array = (JSONArray)json.get("dailyBoxOfficeList");
	        ArrayList<BoxOfficeDTO> list = new ArrayList<BoxOfficeDTO>();
	        
	        for(int i=0; i<array.size(); i++){
	            JSONObject row = (JSONObject)array.get(i);
	            String movieCd = (String)row.get("movieCd");
	            String movieNm = (String)row.get("movieNm");
	            String rank = (String)row.get("rank");
	            BoxOfficeDTO bo = new BoxOfficeDTO();
	            bo.setMovieNm(movieNm);
	            bo.setMovieCd(movieCd);
	            bo.setRank(rank);

	            list.add(bo);
	        }
	        
	        request.setAttribute("list", list);
			 */
			request.setAttribute("list", movielist);
			
		} catch (Exception e) {
			e.printStackTrace();
		}	
		if(movielist.size() != 0) {
			return "index";			
		} else {
			return "come";
		}
	}

	@RequestMapping(value = "/Logined", method = RequestMethod.GET)
	public String Logined(Model model, HttpServletRequest request) {
		return "Logined";
	}
	
	@RequestMapping(value = "/JoinPage", method = RequestMethod.GET)
	public String JoinPage(Model model, HttpServletRequest request) {
		return "Joinpage";
	}

	@RequestMapping(value = "/Login_Check", method = RequestMethod.POST)
	@ResponseBody
	public String Login_Check(Model model, HttpServletRequest request, MemberDTO mbdto2) {

		MemberDTO mbdto = (MemberDTO) sql.selectOne("member.login", mbdto2);
		if (mbdto != null) {
			HttpSession session = request.getSession(true);
			session.setAttribute("user", mbdto);
			session.setMaxInactiveInterval(9999);

			return "1";
		} else {
			return "0";
		}
	}
	
	@RequestMapping(value = "/Join_Check", method = RequestMethod.POST)
	@ResponseBody
	public String Join_Check(Model model, HttpServletRequest request) {
		if(request.getParameter("userID") != null) {
			if(((MemberDTO) sql.selectOne("member.id_check", request.getParameter("userID"))) != null) {
				return "0";
			} else {
				return "1";
			}			
		} else if(request.getParameter("userEmail") != null) {
			if(((MemberDTO) sql.selectOne("member.email_check", request.getParameter("userEmail"))) != null) {
				return "0";
			} else {
				return "1";
			}		
		} else if(request.getParameter("userPhone") != null) {
			if(((MemberDTO) sql.selectOne("member.phone_check", request.getParameter("userPhone"))) != null) {
				return "0";
			} else {
				return "1";
			}		
		} else {
			return "1";
		}
	}

	@RequestMapping(value = "/Logout", method = RequestMethod.GET)
	public String Logout(Model model, HttpServletRequest request) {

		HttpSession session = request.getSession(false);
		session.invalidate();

		return "come";
	}

	@RequestMapping(value = "/Send_Mail", method = RequestMethod.GET)
	public String Send_Mail(Model model, HttpServletRequest request) {
		
		return "Send_Mail";
	}

	@RequestMapping(value = "/Service", method = RequestMethod.GET)
	public String Service(Model model, HttpServletRequest request) {

		String clientId = "S6G1FEe39f_eEOMNA58_";// 애플리케이션 클라이언트 아이디값";
		String clientSecret = "tfFbyN5NS0";// 애플리케이션 클라이언트 시크릿값";\

		int display = 5; // 검색결과갯수. 최대100개
		try {
			String text = URLEncoder.encode("조커", "utf-8");
			String apiURL = "https://openapi.naver.com/v1/search/movie.json?query=" + text + "&display=" + display
					+ "&";

			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("X-Naver-Client-Id", clientId);
			con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if (responseCode == 200) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			sb = new StringBuilder();
			String line;

			while ((line = br.readLine()) != null) {
				sb.append(line + "\n");
			}
			br.close();
			con.disconnect();
			System.out.println(sb);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "Service";
	}

	@RequestMapping(value = "/Memberlist", method = RequestMethod.GET)
	public String Memberlist(Model model, HttpServletRequest request) {

		List<MemberDTO> list = sql.selectList("member.selectlist");
		model.addAttribute("list", list);

		return "Memberlist";
	}

	@RequestMapping(value = "/Send", method = RequestMethod.POST)
	public String Send(Model model, HttpServletRequest request) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String host = "smtp.naver.com";
		final String user = "aodns114";
		final String password = "xptmxm123";
		String title = request.getParameter("title");
		String content = request.getParameter("textAreaContent");

		List<MemberDTO> list = sql.selectList("member.member_agree");

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
			InternetAddress[] address = new InternetAddress[list.size()];
			for (int x = 0; x < list.size(); x++) {
				address[x] = new InternetAddress(list.get(x).getEmail());
			}
			msg.addRecipients(Message.RecipientType.TO, address);
			msg.setSubject(title, "UTF-8");
			msg.setContent(content, "text/html; charset=UTF-8");
			Transport.send(msg);
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("member", list);

		return "Send_Mail_clear";
	}
}

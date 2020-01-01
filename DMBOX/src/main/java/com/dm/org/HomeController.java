package com.dm.org;

import java.awt.Desktop;
import java.awt.Window;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.sun.mail.iap.Response;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	public static StringBuilder sb;
	private static ArrayList<BoxOfficeDTO> movielist = new ArrayList<BoxOfficeDTO>();
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;
	
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

	@Autowired
	SqlSession sql;

	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String come(Model model, HttpServletRequest request, HttpServletResponse response) {
		
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
		
		Cookie cookie = new Cookie("Tap_menu", "0");
		response.addCookie(cookie);
		
		return "come";
	}
	
	@RequestMapping(value = "/Home", method = RequestMethod.GET)
	public String home(Model model, HttpServletRequest request) {
		request.setAttribute("list", movielist);

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
	
	@RequestMapping(value = "/NaverLogin", method = {RequestMethod.GET, RequestMethod.POST})
	public String NaverLogin(Model model, HttpServletRequest request, HttpSession session) {
		
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		//https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
		//redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
		request.setAttribute("url", naverAuthUrl);
		
		return "Logined"; 
	}
	
	@RequestMapping(value = "/callback", method = RequestMethod.GET)
	public String callback(Model model, HttpServletRequest request, HttpSession session, @RequestParam String code, @RequestParam String state) throws IOException, ParseException {
		
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		apiResult = naverLoginBO.getUserProfile(oauthToken);
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;
		JSONObject response_obj = (JSONObject)jsonObj.get("response");
		//response의 nickname값 파싱
		String name = (String)response_obj.get("name");
		session.setAttribute("naveruser", name);
		session.setMaxInactiveInterval(100);
		model.addAttribute("result", apiResult);
		
		return "come";
	}
	
	@RequestMapping(value = "/JoinPage", method = RequestMethod.GET)
	public String JoinPage(Model model, HttpServletRequest request) {
		return "Joinpage";
	}

	@RequestMapping(value = "/Login_Check", method = RequestMethod.POST)
	@ResponseBody
	public int Login_Check(Model model, HttpServletRequest request, MemberDTO mbdto2, HttpSession session) {

		MemberDTO mbdto = (MemberDTO) sql.selectOne("member.login", mbdto2);
		
		if (mbdto != null) {
			session.setAttribute("dmuser", mbdto.getName());
			session.setAttribute("userID", mbdto.getId());
			session.setMaxInactiveInterval(100);

			return 1;
		} else {
			return 0;
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
	
	@RequestMapping(value = "/Join_clear", method = RequestMethod.POST)
	public String Join_clear(Model model, HttpServletRequest request) {
		
		long curr = System.currentTimeMillis();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String datetime = sdf.format(new Date(curr));
		
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String id = request.getParameter("id");
		String pw = request.getParameter("password");
		String name = request.getParameter("name");
		String pc = request.getParameter("postcode");
		String radr = request.getParameter("roadAddress");
		String jiadr = request.getParameter("jibunAddress");
		String oadr = request.getParameter("otheraddr");
		String email = request.getParameter("email");
		String tel = request.getParameter("tel");
		String gender = request.getParameter("gender");
		String emailYn = request.getParameter("emailYn");
		String smsYn = request.getParameter("smsYn");
		String joinDate = datetime;
		
		MemberDTO member = new MemberDTO();
		
		member.setId(id);
		member.setPw(pw);
		member.setName(name);
		member.setPostcode(pc);
		member.setRoadAddress(radr);
		member.setJibunAddress(jiadr);
		member.setOtherAddress(oadr);
		member.setEmail(email);
		member.setTel(tel);
		member.setGender(gender);
		member.setEmailYn(emailYn);
		member.setSmsYn(smsYn);
		member.setJoinDate(joinDate);
		member.setAuthState("0");
		member.setAuthKey("111111");
		
		sql.insert("member.join", member);
		
		return "come";
	}

	@RequestMapping(value = "/Service", method = RequestMethod.GET)
	public String Service(Model model, HttpServletRequest request) {

		String clientId = "S6G1FEe39f_eEOMNA58_";// 애플리케이션 클라이언트 아이디값";
		String clientSecret = "tfFbyN5NS0";// 애플리케이션 클라이언트 시크릿값";\
		String search_text = request.getParameter("search_text");
		int total = 0;
		String index = request.getParameter("index");
		String page = request.getParameter("page");
		
		if(index == null) {
			index = "0";
		}
		if(page == null) {
			page = "0";
		}
		if(search_text == null) {
			search_text = "";
		}
		ArrayList<MovieDTO> ms = new ArrayList<MovieDTO>();
		int display = 15; // 검색결과갯수. 최대 100개
		int start = Integer.parseInt(index)*15+1+(Integer.parseInt(page)*150); // 검색시작위치. 최대 1000
		start = start > 985 ? 985 : start;
		
		try {
			if(!search_text.equals("")) {
				String text = URLEncoder.encode(search_text, "utf-8");
				String apiURL = "https://openapi.naver.com/v1/search/movie.json?query=" + text + "&display=" + display
						+ "&start=" + start;

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
				JSONParser parser = new JSONParser();
				Object obj = parser.parse(sb.toString());
				JSONObject jsonObj = (JSONObject) obj;
				JSONArray jsonArr = (JSONArray) jsonObj.get("items");
				total = Integer.parseInt(String.valueOf(jsonObj.get("total")));
				total = total > 1000 ? 1000 : total;
				
				for(int x=0; x<jsonArr.size(); x++) {
					JSONObject jsonObj2 = (JSONObject) jsonArr.get(x);
					
					String title = (String) jsonObj2.get("title");
					String director = (String) jsonObj2.get("director");
					String sub_title = (String) jsonObj2.get("subtitle");
					String img = (String) jsonObj2.get("image");
					String date = (String) jsonObj2.get("pubDate");
					String rating = (String) jsonObj2.get("userRating");
					
					title = title.replace("<b>", "");
					title = title.replace("</b>", "");
					img = img.replace("'\'", "");
					if(img.isEmpty() == true) {
						img = request.getContextPath()+"/resources/images/poster_default.gif";
					}
					if(director.isEmpty() != true) {
						director = director.substring(0, director.length()-1);					
					} else if(director.isEmpty() == true) {
						director = "알수없음";
					}
					
					MovieDTO mvdto = new MovieDTO();
					
					mvdto.setTitle(title);
					mvdto.setSubtitle(sub_title);
					mvdto.setDirector(director);
					mvdto.setImg(img);
					mvdto.setDate(date);
					mvdto.setRating(rating);
					ms.add(mvdto);
				}
			}	
				} catch (Exception e) {
					e.printStackTrace();
				}
		request.setAttribute("searchlist", ms);
		request.setAttribute("total", Integer.toString(total));
		request.setAttribute("search_text", search_text);
		request.setAttribute("page", page);

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

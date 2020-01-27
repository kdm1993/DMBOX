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
import org.jsoup.nodes.Element;
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

	static int start = 0;
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
	
	private void AuthSendMail(String id, String str, String email) {
		String host = "smtp.naver.com";
		final String user = "aodns114";
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
				+ "http://dmcafe.co.kr/EmailAuth?id="+id+"&authkey="+str+"\" "
				+ "target=\"_blank\" style=\"cursor: pointer; white-space: pre;\" "
				+ "rel=\"noreferrer noopener\">이메일 인증</a><span></span></span></p></h2>"
				+ "</div></div>\r\n" + 
				"\r\n" + 
				"\r\n" + 
				"";
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
			address = new InternetAddress(email);
			msg.addRecipient(Message.RecipientType.TO, address);
			msg.setSubject(title, "UTF-8");
			msg.setContent(content, "text/html; charset=UTF-8");
			Transport.send(msg);
		} catch (Exception e) {
			e.printStackTrace();
		}
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

		if(start == 0) {
			Runnable run = new Runnable() {
				int y = 0;
				int x = 2663492;

				public void run() {
					
					System.out.println("실행 시작");

					while(true) {
						try {
							Document doc = Jsoup.connect("https://bbs.ruliweb.com/av/board/300013/read/"+x+"?")
									.userAgent("Chrome")
									.timeout(20000).get();
							Element body = doc.body();
							
							if(body.select("p .nick").text().equals("") == false) {
								FreeBoardDTO fbdto = new FreeBoardDTO();
								ReplyDTO redto = new ReplyDTO();
								
								String post_writer = body.select("p .nick").text();
								String post_title = body.select(".subject_text").text();
								String post_content = body.select(".view_content").toString().replaceAll("src=\"", "src=\"https:");
								int view_idx = body.select(".user_info p:nth-child(5)").not(".like").text().indexOf("조회");
								int reply_count = Integer.parseInt(body.select(".comment_count_wrapper .reply_count").text());
								String post_view = body.select(".user_info p:nth-child(5)").not(".like").text().substring(view_idx+3);
								Date date = new SimpleDateFormat("yyyy.MM.dd (HH:mm:ss)").parse(body.select(".regdate").text()); //String to date
								SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss"); //new format
								String post_date = sdf.format(date);
								
								fbdto.setContent(post_content);
								fbdto.setRegdate(post_date);
								fbdto.setTitle(post_title);
								fbdto.setView(post_view);
								fbdto.setWriter(post_writer);
								
								for(int k=1; k<=reply_count; k++) {
									if(body.select(".comment_element:nth-child("+ k +")").not(".best").select(".nick a strong").text().equals("") == false) {
										String content = body.select(".comment_element:nth-child("+ k +")").not(".best").select(".text").text();
										String writer = body.select(".comment_element:nth-child("+ k +")").not(".best").select(".nick a strong").text();
										String parent = body.select(".comment_element:nth-child("+ k +")").not(".best").select(".p_nick").text();
										String date2 = body.select(".comment_element:nth-child("+ k +")").not(".best").select(".time").text();
										String depth = "1";
										String post_idx = Integer.toString(x);
										String reply_idx = Integer.toString(k);
										
										if(parent.equals("")) {
										} else {
											depth = "2";
										}
										
										redto.setContent(content);
										redto.setDepth(depth);
										redto.setParent(parent);
										redto.setPost_idx(post_idx);
										redto.setRegdate(date2);
										redto.setReply_idx(reply_idx);
										redto.setWriter(writer);
										
										sql.insert("reply.reply_insert", redto);										
									}
								}
								
								sql.insert("freeboard.post_insert2", fbdto);
								
								y = y+1;
								
								if(y % 10 == 0) {
									System.out.println(y+"회 진행중");
								}
							}
							x++;
							
							Thread.sleep(4000);
						} catch(Exception e) {
							e.printStackTrace();
						}
					}
				}
			};
			Thread t = new Thread(run);
			
			t.start();
			start = 1;
		}
		
		return "index";
	}

	@RequestMapping(value = "/Logined", method = RequestMethod.GET)
	public String Logined(Model model, HttpServletRequest request) {
		return "Logined";
	}
	
	@RequestMapping(value = "/Freeboard", method = RequestMethod.GET)
	public String Freeboard(Model model, HttpServletRequest request) {
		return "Freeboard";
	}
	
	@RequestMapping(value = "/FreeboardWrite", method = RequestMethod.GET)
	public String FreeboardWrite(Model model, HttpServletRequest request) {
		return "FreeboardWrite";
	}
	
	@RequestMapping(value = "/FreeboardWriteSend", method = RequestMethod.POST)
	public String FreeboardWriteSend(Model model, HttpServletRequest request) {
		
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		FreeBoardDTO fbdto = new FreeBoardDTO();
		SimpleDateFormat format = new SimpleDateFormat ( "yyyy/MM/dd HH:mm:ss");
		String format_time = format.format (System.currentTimeMillis());
		
		fbdto.setTitle(request.getParameter("title"));
		fbdto.setContent(request.getParameter("textAreaContent"));
		fbdto.setRegdate(format_time);
		fbdto.setModdate(format_time);
		fbdto.setWriter("작성자");
		
		sql.insert("freeboard.post_insert", fbdto);
		
		return "Freeboard";
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
	public String Login_Check(Model model, HttpServletRequest request, HttpSession session) {

		MemberDTO mbdto2 = new MemberDTO();
		mbdto2.setId(request.getParameter("id"));
		mbdto2.setPw(request.getParameter("password"));
		MemberDTO mbdto = (MemberDTO) sql.selectOne("member.login", mbdto2);
		
		if (mbdto != null) {
			if(mbdto.getAuthState().equals("0")) {
				
				request.setAttribute("id", mbdto.getId());
				request.setAttribute("email", mbdto.getEmail());
				
				return "EmailAuthRoom";
				
			} else if(mbdto.getAuthState().equals("1")) {
				session.setAttribute("dmuser", mbdto.getName());
				session.setAttribute("userID", mbdto.getId());
				session.setMaxInactiveInterval(100);
				
				return "come";
			}
		}
		
		request.setAttribute("state", 0);
		
		return "Logined";
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
	
	@RequestMapping(value = "/EmailAuth", method = RequestMethod.GET)
	public String EmailAuth(Model model, HttpServletRequest request) {
		
		String id = request.getParameter("id");
		String authkey = request.getParameter("authkey");
		String result = "0";
		
		MemberDTO mbdto = (MemberDTO) sql.selectOne("member.id_check", id);
		
		if(mbdto.getAuthKey().equals(authkey)) {
			result = "1";
			mbdto.setAuthState("1");
			sql.update("member.auth_change", mbdto);
		}
		
		request.setAttribute("result", result);
		
		return "EmailAuth";
	}
	
	@RequestMapping(value = "/EmailAuthRoom", method = RequestMethod.GET)
	public String EmailAuthRoom(Model model, HttpServletRequest request) {
		
		return "EmailAuthRoom";
	}
	
	@RequestMapping(value = "/Join_clear", method = RequestMethod.POST)
	public String Join_clear(Model model, HttpServletRequest request) {
		
		long curr = System.currentTimeMillis();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String datetime = sdf.format(new Date(curr));
		String str = "";
		char y;
		
		for(int x=0; x<10; x++) {
			y = (char)((int)(Math.random()*43)+48);
			
			if(y == ':' || y == ';' || y == '>' || y == '=' || y == '<' || y == '?' || y == '@') {
				x--;
			} else {
				str += String.valueOf(y);
			}
		}
		
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
		member.setAuthKey(str);
		
		sql.insert("member.join", member);
		request.setAttribute("email", email);
		
		AuthSendMail(id, str, email);
		
		return "JoinClear";
	}
	
	@RequestMapping(value = "/ReAuthMail", method = RequestMethod.GET)
	public String ReAuthMail(Model model, HttpServletRequest request) {
		
		String id = request.getParameter("id");
		String email = request.getParameter("email");
		MemberDTO mbdto = (MemberDTO) sql.selectOne("member.id_check", id);
		
		AuthSendMail(id, mbdto.getAuthKey(), email);
		
		request.setAttribute("email", email);
		
		return "JoinClear";
	}
	
	@RequestMapping(value = "/ChangeAuthMail", method = RequestMethod.GET)
	public String ChangeAuthMail(Model model, HttpServletRequest request) {
		
		String id = request.getParameter("id");
		String email = request.getParameter("email");
		MemberDTO mbdto = (MemberDTO) sql.selectOne("member.id_check", id);
		mbdto.setEmail(email);
		sql.update("member.email_change", mbdto);
		
		AuthSendMail(id, mbdto.getAuthKey(), email);
		
		request.setAttribute("email", email);
		
		return "JoinClear";
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
		final String password = "aodnsehdals114!";
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

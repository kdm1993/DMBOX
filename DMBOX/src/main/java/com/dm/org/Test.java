package com.dm.org;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

public class Test {
	
	public static StringBuilder sb;
	
	public static void main(String[] args) throws Exception {
		String clientId = "S6G1FEe39f_eEOMNA58_";// 애플리케이션 클라이언트 아이디값";
		String clientSecret = "tfFbyN5NS0";// 애플리케이션 클라이언트 시크릿값";\
		String total = "0";

		ArrayList<MovieDTO> ms = new ArrayList<MovieDTO>();
		int display = 15; // 검색결과갯수. 최대 100개

		try {
				String text = URLEncoder.encode("1", "utf-8");
				String apiURL = "https://openapi.naver.com/v1/search/movie.json?query=1&display=15&start=85";

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
				total = String.valueOf(jsonObj.get("total"));
				
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
					System.out.println(mvdto.getTitle());
				}
				} catch (Exception e) {
					e.printStackTrace();
				}
		
	}
}

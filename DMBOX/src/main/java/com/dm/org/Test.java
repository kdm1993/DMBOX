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
		ArrayList<MovieDTO> ms = new ArrayList<MovieDTO>();
		/*
		int display = 100; // 검색결과갯수. 최대100개
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
			JSONParser parser = new JSONParser();
			Object obj = parser.parse(sb.toString());
			JSONObject jsonObj = (JSONObject) obj;
			JSONArray jsonArr = (JSONArray) jsonObj.get("items");
			
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
				director = director.substring(0, director.length()-1);
				
				System.out.println("제목 : " + title);
				System.out.println("영어제목 : " + sub_title);
				System.out.println("감독 : " + director);
				System.out.println("이미지 : " + img);
				System.out.println("제작년도 : " + date);
				System.out.println("평점 : " + rating);
				System.out.println("---------------------");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		
		
	}
}

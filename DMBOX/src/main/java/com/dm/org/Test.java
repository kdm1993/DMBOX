package com.dm.org;

import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

public class Test {
	public static void main(String[] args) throws Exception {
		Document doc = Jsoup.connect("http://www.megabox.co.kr/?menuId=movie-showing").get();
		Elements body = doc.select(".thumb flip");
		System.out.println(doc);
		System.out.println("완료");
		
		/*		
		ArrayList<BoxOfficeDTO> list = new ArrayList<BoxOfficeDTO>();

		List<String> grade = new ArrayList<String>();
		List<String> ticketing = new ArrayList<String>();
		List<String> width_poster = new ArrayList<String>();
		List<String> height_poster = new ArrayList<String>();
		List<String> movie_eng_name = new ArrayList<String>();
		
		for(int x=0; x<body.select("a").size(); x+=4) {
			Document doc2 = Jsoup.connect("http://www.maxmovie.com"+body.select("a").get(x).attr("href")).get();
			Elements body2 = doc2.select(".nmvtx");
			System.out.println(body2.text());
			
			width_poster.add(body2.attr("style").replace("background: url('", "").replace("') no-repeat", ""));
			height_poster.add(doc2.select(".mspost").select("img").attr("src"));
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
			
			list.add(bo);
		}
		*/
	}
}

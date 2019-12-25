package com.dm.org;

import lombok.Data;

@Data
public class BoxOfficeDTO {
	private String movie_name;
	private String width_poster;
	private String height_poster;
	private String grade;
	private String ticketing;
	private String movie_eng_name;
}

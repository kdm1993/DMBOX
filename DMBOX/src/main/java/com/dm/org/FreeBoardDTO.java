package com.dm.org;

import lombok.Data;

@Data
public class FreeBoardDTO {

	private int idx;
	private String title;
	private String content;
	private String regdate;
	private String moddate;
	private String writer;
	private String view;
	private String state;
	private String reply_count;
}

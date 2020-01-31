package com.dm.org;

import lombok.Data;

@Data
public class ReplyDTO {
	
	private String content;
	private String regdate;
	private String moddate;
	private String writer;
	private int post_idx;
	private int reply_idx;
	private int depth;
	private int parent;
	private String state;
}

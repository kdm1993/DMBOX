package com.dm.org;

import lombok.Data;

@Data
public class ReplyDTO {
	
	private String content;
	private String regdate;
	private String moddate;
	private String writer;
	private String post_idx;
	private String reply_idx;
	private String depth;
	private String parent;
	private String state;
}

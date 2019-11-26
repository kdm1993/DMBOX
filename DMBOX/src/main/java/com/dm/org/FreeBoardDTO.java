package com.dm.org;

public class FreeBoardDTO {

	private int idx;
	private String title;
	private String content;
	private String regdate;
	private String moddate;
	private String writer;
	private int view;
	
	// �깮�꽦�옄 toString getter setter
	
	public FreeBoardDTO(int idx, String title, String content, String regdate, String moddate, String writer, int view) {
		super();
		this.idx = idx;
		this.title = title;
		this.content = content;
		this.regdate = regdate;
		this.moddate = moddate;
		this.writer = writer;
		this.view = view;
	}

	public FreeBoardDTO() {
	}

	@Override
	public String toString() {
		return "FreeBoardDTO [idx=" + idx + ", title=" + title + ", content=" + content + ", regdate=" + regdate
				+ ", moddate=" + moddate + ", writer=" + writer + "]";
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRedate() {
		return regdate;
	}

	public void setRedate(String regdate) {
		this.regdate = regdate;
	}

	public String getModdate() {
		return moddate;
	}

	public void setModdate(String moddate) {
		this.moddate = moddate;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}
	public int getView() {
		return view;
	}

	public void setView(int view) {
		this.view = view;
	}
	
	
	
}

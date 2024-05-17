package kr.or.ddit.groupware.vo;

import lombok.Data;

@Data
public class NewsItemVO {

	private String title;
	private String originallink;
	private String link;
	private String description;
	private String pubDate;
	private int estbsNo;
}

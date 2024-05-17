package kr.or.ddit.groupware.vo;

import lombok.Data;

@Data
public class OrganizationTreeVO {
	private String id;
	private String parent;
	private String text;
}

package kr.or.ddit.groupware.vo;

import java.util.Date;

import lombok.Data;

@Data
public class EmpAuthorityVO {
	private int authorNo;
	private int emplNo;
	private String authorNm;
	private String useYn;
	private Date rgsde;
	private int register;
	private Date updde;
	private int updusr;
}

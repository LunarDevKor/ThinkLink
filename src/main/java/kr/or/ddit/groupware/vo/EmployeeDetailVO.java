package kr.or.ddit.groupware.vo;

import java.util.Date;

import lombok.Data;

@Data
public class EmployeeDetailVO {
	private int emplDetailNo;
	private int emplNo;
	private String bankNm;
	private String bankAcnutno;	
	private String accountDpstr;
	private String empAnnual;
	private Date rgsde;
	private int register;
	private Date updde;
	private int updusr;
}

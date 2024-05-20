package kr.or.ddit.groupware.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ApprovalRfrncVO {
	private int aprovlRfrncNo;
	private int aprovlNo;
	private int rfrncerNo;
	private String rfrncerNm;
	private String rfrncerDeptNm;
	private Date rfrncConfirmDt;
	private String rfrncConfirmDtToString;
}

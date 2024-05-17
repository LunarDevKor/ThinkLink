package kr.or.ddit.groupware.vo;

import java.util.Date;

import lombok.Data;

@Data
public class SanctionerVO {
	private int sanctnerNo;
	private int approverNo;
	private String approverNm;
	private int aprovlNo;
	private String aprovlCn;
	private int sanctnerOrdr;
	private Date sanctnerDt;
	private String sanctnerDtToString;
	private String sanctnerSttusCode;
	private String sanctnerSttusNm;
	private String sanctnerMemo;
	
	private String emplProflPhoto;
	private String deptNm;
	private String clsfNm;
	
	private String type;
}
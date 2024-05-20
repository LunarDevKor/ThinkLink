package kr.or.ddit.groupware.vo;

import java.util.Date;

import lombok.Data;

@Data
public class DriveFolderVO {
	private int fldrNo;
	private int upperFldrNo;
	private int emplNo;
	private String fldrNm;
	private String fldrPath;
	private String fldrType;
	private String delYn;
	
	private String deptCode;
	
	private int fldrRegister;
	private Date fldrRgsde;
	private int fldrUpdusr;
	private Date fldrUpdde;
}

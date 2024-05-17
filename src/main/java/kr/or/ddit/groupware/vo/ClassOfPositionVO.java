package kr.or.ddit.groupware.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ClassOfPositionVO {
	 private int clsfCode;
	 private String clsfNm;
	 private int clsfLevel;
	 private String useYn;
	 private Date rgsde;
	 private int register;
	 private Date updde;
	 private int updusr;
}

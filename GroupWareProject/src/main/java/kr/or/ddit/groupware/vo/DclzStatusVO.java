package kr.or.ddit.groupware.vo;

import java.time.LocalDate;
import java.util.Date;

import lombok.Data;

@Data
public class DclzStatusVO {
	private int dclzNo;
	private int emplNo;
	private Date attendDt;
	private Date lvffcDt;
	private String attendDtString;
	private String lvffcDtString;
	

	private int dclzPartclrNo;
	private Date beginDt;
	private Date endDt;
	private String dclzTypeCode;
	private String dclzNm;

	private LocalDate firstDay;
	private LocalDate lastDay;
	private Date date;
	private String defaultTime;
	private String overTime;
	private String nightTime;
	
	private String holidayTime;
	private String emplNm;
	private String deptNm;
	private String clsfNm;
	

}

package kr.or.ddit.groupware.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ScheduleVO {
	private int schdulNo;
	private int schdulGroupNo;
	private String schdulNm;
	private Date schdulBgnde;
	private Date schdulEndde;
	private String schdulCn;
	private String schdulFontColor = "FFFFFF";
	private String schdulBgrnColor;
	private String schdulPlace;
	private int register;
	private String alldayYn;
	private String schdulGroupNm;
	private String schdulTypeCode;
	private String psitnCode;
	private List<EmployeeVO> attendeeList;
}

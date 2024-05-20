package kr.or.ddit.groupware.vo;

import java.util.Date;
import lombok.Data;

@Data
public class PrjctSchdulVO {
	private int schdulNo;
	private int prjctNo;
	private String prjctColor;
	private String prjctNm;
	private String schdulNm;
	private Date schdulBgnde;
	private Date schdulEndde;
	private String schdulBgnDateStr;
	private String schdulBgnTimeStr;
	private String schdulEndDateStr;
	private String schdulEndTimeStr;
	private String schdulPlace;
	private String alldayYn;
}

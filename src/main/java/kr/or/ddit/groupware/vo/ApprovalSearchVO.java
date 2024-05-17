package kr.or.ddit.groupware.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ApprovalSearchVO {
	private String emplNm;
	private String aprovlNm;
	private String[] aprovlSttusCode;
	private String aprovlSttusCodeString;
	private String deptNm;
	private String docNm;
	private Date submitDt;
	private Date closDt;
	
	
	public void setAprovlSttusCode(String[] aprovlSttusCode) {
		this.aprovlSttusCodeString = "";
		
		for(int i = 0; i < aprovlSttusCode.length; i++) {
		    this.aprovlSttusCodeString += aprovlSttusCode[i];
		    if(i < aprovlSttusCode.length - 1) {
		        this.aprovlSttusCodeString += ",";
		    }
		}
		
		this.aprovlSttusCode = aprovlSttusCode;
	}
}

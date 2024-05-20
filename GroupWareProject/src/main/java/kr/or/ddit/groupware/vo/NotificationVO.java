package kr.or.ddit.groupware.vo;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

@Data
public class NotificationVO {
	private int ntcnNo;
	private int ntcnRecp;
	private String ntcnTypeCode;
	private String ntcnContent;
	private String ntcnUrl;
	private String ntcnReadDt;
	private String ntcnDt;
	private String ntcnSendYn;
	@JsonIgnore
	private LocalDateTime localDt;
	
	private String type;
}

package kr.or.ddit.groupware.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class LogVO {
	private int logNo;
	private int emplNo;
	private int fileNo;
	private String fileName;
	private String logCn;
	private Date logDt;
	private String logDtToString;
	private int downloadCnt;
}

package kr.or.ddit.groupware.vo;

import java.util.Date;
import lombok.Data;

@Data
public class TaskVO {
	
	private int taskNo;
	private int upperTaskNo;
	private int prjctNo;
	private String prjctNm;
	private int emplNo;
	private String emplNm;
	private String taskNm;
	private String taskCn;
	private int taskProgrs;
	private String taskImprtnc;
	private String taskPriort;
	private int taskRegister;
	private Date taskRgsde;
	private Date taskBeginDt;
	private Date taskEndDt;
	private Date taskLastUpdde;
	private String taskBeginDtStr;
	private String taskEndDtStr;
	private String taskLastUpddeStr;
	private int atchFileGroupNo;
	private String prjctColor;
	
	// 통계 관련 필드 추가
	private String taskType;
	private int count;
	private double rate;
}

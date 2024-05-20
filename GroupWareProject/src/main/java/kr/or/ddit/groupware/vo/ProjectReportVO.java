package kr.or.ddit.groupware.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ProjectReportVO {
	private int prjctReprtNo;
	private int prjctNo;
	private int emplNo;
	private String emplNm;
	private String prjctReprtNm;
	private String prjctReprtCn;
	private Date prjctReprtRgdde;
	private Date prjctReprtTargetDate;
	private String prjctReprtTargetDateString;
	private int atchFileGrpNo;
	private String prjctReprtWd;
	private List<MultipartFile> files;
	private EmployeeVO empl;
}

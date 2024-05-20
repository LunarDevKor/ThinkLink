package kr.or.ddit.groupware.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class AttachFileGroupVO {
	private int atchFileGroupNo;
	private String delYn;
	private int register;
	private Date rgsde;
	private int updusr;
	private Date updde;
	
	private List<AttachFileVO> attachFileList;

}

package kr.or.ddit.groupware.vo;

import java.util.List;

import lombok.Data;

@Data
public class MemoVO {
	private int memoNo;
	private int emplNo;
	private String memoCn;
	private String memoImprtncYn;
	private String memoDelYn;
	private Integer atchFileGrpupNo;
	private String imgFilePath;
	private String memoDt;
	private List<AttachFileVO> attachFileList; // 첨부 파일 목록 필드 추가
	
}

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
public class AttachFileVO {
	private int atchFileNo;
	private int atchFileGroupNo;
	private String atchFileNm;
	private String atchFileOrnlFileNm;
	private long atchFileSize;
	private String atchFileFancysize;
	private String atchFileExtsn;
	private Date atchFileDate;
	private String atchFilePath;
}

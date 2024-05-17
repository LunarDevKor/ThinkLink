package kr.or.ddit.groupware.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class DriveVO {
	private int fileNo;
	private int emplNo;
	private String fileNm;
	private String orgnlFilename;
	private long fileSize;
	private String fileFancysize;
	private String fileMimeType;
	private String fileExtsn;
	private String filePath;
	private int fileDwldCo;
	private String delYn;
	  
	private int fileRegister;
	private Date fileRgsde;
	private String fileRgsdeToString;
	private int fileUpdusr;
	private Date fileUpdde;
	private String fileUpddeToString;
	
	private int upperFldrNo;
	private String fldrType;
	private String deptCode;
	List<MultipartFile> files;
}

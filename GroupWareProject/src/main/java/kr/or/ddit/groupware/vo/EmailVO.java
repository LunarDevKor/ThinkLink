package kr.or.ddit.groupware.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class EmailVO {
	private int emailNo;
	private int emplNo;
	private int senderNo; //emailReceptionVO와 emplNo가 중복되어 만듦
	private int receiverNo;
	private String emailNm;
	private String emailCn;
	private String emailImprtncYn;
	private String emailDelYn;
	private String emailStatusCode;
	private Date emailRgdde;
	private Date emailTrnsmis;
	private int atchFileGroupNo;
	
	private int receptionCount; // 받는사람, 참조 개수
	private int receptionReadCount; // 받는사람, 참조 읽은 개수
	private Integer[] delFileNo; // 삭제할 파일 배열
	private String receiverNm;
	private String senderNm;
	private String atchFileOrnlFileNm;
	private String deptNm;
	
	private EmailReceptionVO emailReceptionVO;
	private EmployeeVO senderVO;
	private EmployeeVO receiverVO;
	private EmployeeVO employeeVO;
	
	private List<MultipartFile> files;
}

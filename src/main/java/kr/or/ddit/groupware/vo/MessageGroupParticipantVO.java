package kr.or.ddit.groupware.vo;

import lombok.Data;

@Data
public class MessageGroupParticipantVO {
	private int mssagPrtcpntNo;
	private int emplNo;
	private int mssagGroupNo;
	private String mssagGroupNm;
	private int mssagLastRead;
	private String mssagCn;
	private String emplNm;
	private String emplProflPhoto;
	private String estbsCn;
	private String clsfCode;
	private String deptCode;
	private String msgRgsde;
}

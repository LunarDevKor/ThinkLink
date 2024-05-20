package kr.or.ddit.groupware.vo;

import java.time.LocalDate;
import java.util.List;

import lombok.Data;
@Data
public class BoardVO {

	List<AnswerVO> answerList;
	
	private int bbscttNo;	// 시퀀스
	private int bbsNo;		//카테고리 번호
	private String bbsNm;		// 카테고리 명
	private int emplNo;		// 작성자 번호
	private String emplNm;		// 작성자
	private String bbscttTitle;	// 게시글 제목
	private String bbscttCn;	// 게시글 내용
	private int bbscttRdcnt;	// 게시글 조회
	private String imprtncYn;	// 중요공지 여부
	private String delYn;		// 삭제여부
	private int atchFileGrpNo;  //
	private LocalDate rgsde;	//최초등록일
	private int register;		//최초등록자
	private LocalDate updde;	//최종수정일
	private int updusr;			//최종수정자
	private int answerCount; 	//댓글 수
	private Integer[] delAttachFileNo;
	private int rowNum; //랭킹
	
	private String emplProflPhoto; //프로필 사진
	
	// 통계 필드
	private String hourOfDay;
	private int count;
}

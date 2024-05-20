package kr.or.ddit.groupware.vo;

import java.sql.Date;

import lombok.Data;
@Data
public class AnswerVO {

	private int answerNo;		// 댓글번호
	private int upperAnswerNo;	// 부모댓글번호
	private int emplNo;		//작성자
	private int bbscttNo;	//게시글번호
	private String answerDp;	//0댓글  1대댓글
	private String answerNm;	//작성자 이름
	private String replyCn;	//댓글내용
	private String delYn;	//삭제유무
	private String answerDelYn;	//삭제유무
	private Date answerRgsde;	//댓글작성일
	private Date answerUpdde;	//수정일
	private int answerCount; 	//댓글 수
	private int boardEmplNo;	// 게시글 작성자 번호
	private String clsfNm;	// 게시글 작성자 직급
	
	private String emplProflPhoto;
}

package kr.or.ddit.groupware.mapper.answer;

import java.util.List;

import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.AnswerVO;

public interface IAnswerMapper {

	public void insertAnswer(AnswerVO answerVO);
	
	public List<AnswerVO> selectAnswer(int bbscttNo);

	public int updateAnswer(AnswerVO answerVO);

	public int deleteAnswer(AnswerVO answerVO);

	
	
	
	
	public void insertAnswer2(AnswerVO answerVO);

	public List<AnswerVO> selectReply(int upperAnswerNo);

	public int updateReply(AnswerVO answerVO);

	public int deleteReply(AnswerVO answerVO);

	public AnswerVO getBoardWriter(AnswerVO answerVO, int bbscttNo, int emplNo);

	public List<AnswerVO> getBoardWriters(AnswerVO answerVO);

	public AnswerVO getBoardWriter(AnswerVO answerVO);
}

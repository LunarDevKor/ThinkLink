package kr.or.ddit.groupware.service.answer;

import java.util.List;

import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.AnswerVO;

public interface IAnswerService {

	public void insertAnswer(AnswerVO answerVO);

	public List<AnswerVO>selectAnswer(int bbscttNo);

	public String updateAnswer(AnswerVO answerVO);

	public String deleteAnswer(AnswerVO answerVO);

	
	
	
	
	public void insertAnswer2(AnswerVO answerVO);

	public List<AnswerVO> selectReply(int upperAnswerNo);

	public String updateReply(AnswerVO answerVO);

	public String deleteReply(AnswerVO answerVO);
}

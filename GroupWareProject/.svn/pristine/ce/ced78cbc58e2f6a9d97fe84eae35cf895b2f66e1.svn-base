package kr.or.ddit.groupware.service.answer;

import java.time.LocalDateTime;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.groupware.mapper.answer.IAnswerMapper;
import kr.or.ddit.groupware.mapper.notification.INotificationMapper;
import kr.or.ddit.groupware.util.NotificationUtil;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.AnswerVO;
import kr.or.ddit.groupware.vo.BoardVO;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.NotificationVO;

@Service
public class AnswerServiceImpl implements IAnswerService {

	@Inject
	private IAnswerMapper answerMapper;
	
	@Inject
	private NotificationUtil noti;
	
	@Inject
	private INotificationMapper notificationMapper;

	@Override
	public void insertAnswer(AnswerVO answerVO) {
		 answerMapper.insertAnswer(answerVO);
		 
		 AnswerVO answerVO2 = answerMapper.getBoardWriter(answerVO);
		 System.out.println(">>"+answerVO2);
		 
		 NotificationVO notificationVO = new NotificationVO();
		 
		 
		 // target => 게시물 작성자 
		 // 게시물 작성자는 = board 안에 작성자?
		 
		 String content = "[댓글]"
				 .concat(answerVO2.getAnswerNm() + " " + answerVO2.getClsfNm())
				 .concat("'님이 작성한'")
				 .concat(answerVO2.getReplyCn() + "'이(가) 도착했습니다!'");
		 	
			notificationVO.setNtcnRecp(answerVO2.getBoardEmplNo());
			notificationVO.setNtcnTypeCode("N106"); // 받은메일
			notificationVO.setNtcnContent(content);
			notificationVO.setNtcnUrl("/board/detail?bbscttNo=" + answerVO2.getBbscttNo()+"#answerList");
			notificationVO.setLocalDt(LocalDateTime.now());
			
			notificationMapper.insertNotification(notificationVO);
			noti.sendNoti(answerVO2.getBoardEmplNo());
			
			
	}
	
	

	@Override
	public List<AnswerVO> selectAnswer(int bbscttNo) {
		return answerMapper.selectAnswer(bbscttNo);
	}



	@Override
	public String updateAnswer(AnswerVO answerVO) {
		int status = answerMapper.updateAnswer(answerVO);
		return status > 0 ? Result.OK.toString() : Result.FAILED.toString();
	}



	@Override
	public String deleteAnswer(AnswerVO answerVO) {
		int status = answerMapper.deleteAnswer(answerVO);
		return status > 0 ? Result.OK.toString() : Result.FAILED.toString();
	}


	
	
	
	

	@Override
	public void insertAnswer2(AnswerVO answerVO) {
		answerMapper.insertAnswer2(answerVO);
		
	}



	@Override
	public List<AnswerVO> selectReply(int upperAnswerNo) {
		return answerMapper.selectReply(upperAnswerNo);
	}



	@Override
	public String updateReply(AnswerVO answerVO) {
		int status = answerMapper.updateReply(answerVO);
		return status > 0 ? Result.OK.toString() : Result.FAILED.toString();
	}



	@Override
	public String deleteReply(AnswerVO answerVO) {
		int status = answerMapper.deleteReply(answerVO);
		return status > 0 ? Result.OK.toString() : Result.FAILED.toString();
	}
}

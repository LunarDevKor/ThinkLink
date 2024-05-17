package kr.or.ddit.groupware.service.mail;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.groupware.mapper.employee.IEmployeeMapper;
import kr.or.ddit.groupware.mapper.mail.IMailMapper;
import kr.or.ddit.groupware.mapper.notification.INotificationMapper;
import kr.or.ddit.groupware.util.NotificationUtil;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.EmailReceptionVO;
import kr.or.ddit.groupware.vo.EmailVO;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.NotificationVO;
import kr.or.ddit.groupware.vo.PaginationInfoVO;

/**
 * 메일 서비스 구현체
 * 
 * @author <strong>최소희</strong>
 * @version 1.0
 * @see MailServiceImpl
 */
@Service
public class MailServiceImpl implements IMailService {

	@Inject
	private IMailMapper mapper;

	@Inject
	private INotificationMapper notificationMapper;

	@Inject
	private NotificationUtil noti;
	
	@Inject
	private IEmployeeMapper employeeMapper;

	@Override
	public EmailVO selectEmail(int emailNo) {
		return mapper.selectEmail(emailNo);
	}

	@Override
	public Result deleteEmail(int emailNo) {
		Result result = null;
		int status = mapper.deleteEmail(emailNo);
		if (status > 0) {
			result = Result.OK;
		}
		else {
			result = Result.FAILED;
		}
		return result;
	}

	@Override
	public Result deleteReception(EmailReceptionVO emailReceptionVO) {
		Result result = null;
		int status = mapper.deleteReception(emailReceptionVO);
		if (status > 0) {
			result = Result.OK;
		}
		else {
			result = Result.FAILED;
		}
		return result;
	}

	@Override
	public int selectEmailCount(PaginationInfoVO<EmailVO> pagingVO) {
		return mapper.selectEmailCount(pagingVO);
	}

	@Override
	public List<EmailVO> selectEmailList(PaginationInfoVO<EmailVO> pagingVO) {
		return mapper.selectEmailList(pagingVO);
	}

	@Override
	public int selectNoReadCount(int emplNo) {
		return mapper.selectNoReadCount(emplNo);
	}

	@Override
	public Result readEmail(EmailReceptionVO emailReceptionVO) {
		Result result = null;
		int status = mapper.readEmail(emailReceptionVO);
		if (status > 0) {
			result = Result.OK;
		}
		else {
			result = Result.FAILED;
		}
		return result;
	}

	@Override
	public Result importantEmail(int emailNo) {
		Result result = null;
		int status = mapper.importantEmail(emailNo);
		if (status > 0) {
			result = Result.OK;
		}
		else {
			result = Result.FAILED;
		}
		return result;
	}

	@Override
	public Result importantReception(EmailReceptionVO emailReceptionVO) {
		Result result = null;
		int status = mapper.importantReception(emailReceptionVO);
		if (status > 0) {
			result = Result.OK;
		}
		else {
			result = Result.FAILED;
		}
		return result;
	}

	@Override
	public int selectSentCount(PaginationInfoVO<EmailVO> pagingVO) {
		return mapper.selectSentCount(pagingVO);
	}

	@Override
	public List<EmailVO> selectSentList(PaginationInfoVO<EmailVO> pagingVO) {
		return mapper.selectSentList(pagingVO);
	}

	@Override
	public List<EmailReceptionVO> selectReceptionList(int emailNo) {
		return mapper.selectReceptionList(emailNo);
	}

	@Override
	public List<EmailVO> selectNoReadList(PaginationInfoVO<EmailVO> pagingVO) {
		return mapper.selectNoReadList(pagingVO);
	}

	@Override
	public int selectImportantCount(PaginationInfoVO<EmailVO> pagingVO) {
		return mapper.selectImportantCount(pagingVO);
	}

	@Override
	public List<EmailVO> selectImportantList(PaginationInfoVO<EmailVO> pagingVO) {
		return mapper.selectImportantList(pagingVO);
	}

	@Override
	public int selectImportantNoReadCount(int emplNo) {
		return mapper.selectImportantNoReadCount(emplNo);
	}

	@Override
	public int selectToMeCount(PaginationInfoVO<EmailVO> pagingVO) {
		return mapper.selectToMeCount(pagingVO);
	}

	@Override
	public List<EmailVO> selectToMeList(PaginationInfoVO<EmailVO> pagingVO) {
		return mapper.selectToMeList(pagingVO);
	}

	@Override
	public int selectToMeNoReadCount(int emplNo) {
		return mapper.selectToMeNoReadCount(emplNo);
	}

	@Override
	public int selectReservationCount(int emplNo) {
		return mapper.selectReservationCount(emplNo);
	}

	@Override
	public List<EmailVO> selectReservationList(PaginationInfoVO<EmailVO> pagingVO) {
		return mapper.selectReservationList(pagingVO);
	}

	@Override
	public int selectDraftCount(PaginationInfoVO<EmailVO> pagingVO) {
		return mapper.selectDraftCount(pagingVO);
	}

	@Override
	public List<EmailVO> selectDraftList(PaginationInfoVO<EmailVO> pagingVO) {
		return mapper.selectDraftList(pagingVO);
	}

	@Override
	public Result insertEmail(EmailVO emailVO, int[] receiverArray, int[] ccArray) {
		Result result = null;

		int status = mapper.insertEmail(emailVO);

		if (status > 0) {

			EmailReceptionVO emailReceptionVO = new EmailReceptionVO();

			emailReceptionVO.setEmailNo(emailVO.getEmailNo());

			if (receiverArray != null && receiverArray.length > 0) {
				for (int i = 0; i < receiverArray.length; i++) {

					emailReceptionVO.setEmplNo(receiverArray[i]);
					emailReceptionVO.setEmailRecptnRecpTypeCode("E201");
					mapper.insertReception(emailReceptionVO);
					
					if(!emailVO.getEmailStatusCode().equals("E103")) { // 임시메일이 아닐 때
						// 알림 시작
						String content = "[메일 도착]"
								.concat(emailVO.getSenderVO().getDeptNm() + " " + emailVO.getSenderVO().getEmplNm()
										+ " " + emailVO.getSenderVO().getClsfNm())
								.concat("-'").concat(emailVO.getEmailNm() + "'");
						NotificationVO notificationVO = new NotificationVO();
						notificationVO.setNtcnRecp(receiverArray[i]);
						notificationVO.setNtcnTypeCode("N108"); // 받은메일
						notificationVO.setNtcnContent(content);
						notificationVO.setNtcnUrl("/mail/detail?emailNo=" + emailVO.getEmailNo() + "&where=inbox");
						
						if (emailVO.getEmailStatusCode().equals("E101")) { // 메일발송 알림보내기
							
							notificationVO.setLocalDt(LocalDateTime.now());
							notificationMapper.insertNotification(notificationVO);
							noti.sendNoti(receiverArray[i]);
						}
						
						if (emailVO.getEmailStatusCode().equals("E102")) { // 예약메일 알림보내기
							// Date 객체를 LocalDateTime 객체로 바꾸기
							LocalDateTime emailTrnsmis = emailVO.getEmailTrnsmis().toInstant()
									.atZone(ZoneId.systemDefault()).toLocalDateTime();
							notificationVO.setLocalDt(emailTrnsmis);
							notificationMapper.insertNotification(notificationVO);
							
							EmployeeVO receiverVo = employeeMapper.selectEmployee(receiverArray[i]);
							
							// 보낸 사람에게 예약메일 발송 알림
							NotificationVO senderNotificationVO = new NotificationVO();
							String senderContent = "[예약 메일 발송]'"
									.concat(receiverVo.getDeptNm() + " " + receiverVo.getEmplNm()+ " " + receiverVo.getClassOfPositionVO().getClsfNm())
									.concat("'님께 '")
									.concat(emailVO.getEmailNm() + "'이(가) 발송되었습니다.");
							senderNotificationVO.setNtcnRecp(emailVO.getEmplNo());
							senderNotificationVO.setNtcnTypeCode("N110"); // 예약메일 발송
							senderNotificationVO.setNtcnContent(senderContent);
							senderNotificationVO.setNtcnUrl("/mail/detail?emailNo=" + emailVO.getEmailNo() + "&where=sent");
							senderNotificationVO.setLocalDt(emailTrnsmis);
							notificationMapper.insertNotification(senderNotificationVO);
						}
						//얄림 끝
					}
				}
			}

			if (ccArray != null && ccArray.length > 0) {
				for (int i = 0; i < ccArray.length; i++) {
					emailReceptionVO.setEmplNo(ccArray[i]);
					emailReceptionVO.setEmailRecptnRecpTypeCode("E202");
					mapper.insertReception(emailReceptionVO);
					
					if(!emailVO.getEmailStatusCode().equals("E103")) { // 임시메일이 아닐 때
						// 알림 시작
						String content = "[메일 참조]"
								.concat(emailVO.getSenderVO().getDeptNm() + " " + emailVO.getSenderVO().getEmplNm()
										+ " " + emailVO.getSenderVO().getClsfNm())
								.concat("-'").concat(emailVO.getEmailNm() + "'");
						NotificationVO notificationVO = new NotificationVO();
						notificationVO.setNtcnRecp(ccArray[i]);
						notificationVO.setNtcnTypeCode("N109"); // 받은메일
						notificationVO.setNtcnContent(content);
						notificationVO.setNtcnUrl("/mail/detail?emailNo=" + emailVO.getEmailNo() + "&where=inbox");
						
						if (emailVO.getEmailStatusCode().equals("E101")) { // 메일발송 알림보내기
							
							notificationVO.setLocalDt(ZonedDateTime.now(ZoneId.of("Asia/Seoul")).toLocalDateTime());
							notificationMapper.insertNotification(notificationVO);
							noti.sendNoti(ccArray[i]);
							
						}
						
						if (emailVO.getEmailStatusCode().equals("E102")) { // 예약메일 알림보내기
							
							EmployeeVO ccVo = employeeMapper.selectEmployee(ccArray[i]);
							
							// Date 객체를 LocalDateTime 객체로 바꾸기
							LocalDateTime emailTrnsmis = emailVO.getEmailTrnsmis().toInstant()
									.atZone(ZoneId.systemDefault()).toLocalDateTime();
							notificationVO.setLocalDt(emailTrnsmis);
							notificationMapper.insertNotification(notificationVO);
							
							// 보낸 사람에게 예약메일 발송 알림
							NotificationVO senderNotificationVO = new NotificationVO();
							String senderContent = "[예약 메일 발송]'"
									.concat(ccVo.getDeptNm() + " " + ccVo.getEmplNm()+ " " + ccVo.getClassOfPositionVO().getClsfNm())
									.concat("'님께 '")
									.concat(emailVO.getEmailNm() + "'이(가) 발송되었습니다.");
							senderNotificationVO.setNtcnRecp(emailVO.getEmplNo());
							senderNotificationVO.setNtcnTypeCode("N110"); // 예약메일 발송
							senderNotificationVO.setNtcnContent(senderContent);
							senderNotificationVO.setNtcnUrl("/mail/detail?emailNo=" + emailVO.getEmailNo() + "&where=sent");
							senderNotificationVO.setLocalDt(emailTrnsmis);
							notificationMapper.insertNotification(senderNotificationVO);
						}
						//얄림 끝
					}
				}
			}
			result = Result.OK;
		}
		else {
			result = Result.FAILED;
		}
		return result;
	}

	@Override
	public Result updateEmail(EmailVO emailVO, int[] receiverArray, int[] ccArray) {
		Result result = null;

		int status = mapper.updateEmail(emailVO);

		if (status > 0) {

			// 진짜 데이터 날리기
			mapper.deleteReceptionList(emailVO.getEmailNo());

			// 다시 인서트하기
			EmailReceptionVO emailReceptionVO = new EmailReceptionVO();

			emailReceptionVO.setEmailNo(emailVO.getEmailNo());

			if (receiverArray != null && receiverArray.length > 0) {
				for (int i = 0; i < receiverArray.length; i++) {
					emailReceptionVO.setEmplNo(receiverArray[i]);
					emailReceptionVO.setEmailRecptnRecpTypeCode("E201");
					mapper.insertReception(emailReceptionVO);
				}
			}

			if (ccArray != null && ccArray.length > 0) {
				for (int i = 0; i < ccArray.length; i++) {
					emailReceptionVO.setEmplNo(ccArray[i]);
					emailReceptionVO.setEmailRecptnRecpTypeCode("E202");
					mapper.insertReception(emailReceptionVO);
				}
			}
			result = Result.OK;
		}
		else {
			result = Result.FAILED;
		}
		return result;
	}

	@Override
	public EmailReceptionVO selectReceptionOne(int emailNo) {
		return mapper.selectReceptionOne(emailNo);
	}

	@Override
	public Result existReception(EmailReceptionVO emailReceptionVO) {
		Result result = null;
		int status = mapper.existReception(emailReceptionVO);
		if (status > 0) {
			result = Result.OK;
		}
		else {
			result = Result.FAILED;
		}
		return result;
	}

	@Override
	public Result unimportantReception(EmailReceptionVO emailReceptionVO) {
		Result result = null;
		int status = mapper.unimportantReception(emailReceptionVO);
		if (status > 0) {
			result = Result.OK;
		}
		else {
			result = Result.FAILED;
		}
		return result;
	}

	@Override
	public Result unimportantEmail(int emailNo) {
		Result result = null;
		int status = mapper.unimportantEmail(emailNo);
		if (status > 0) {
			result = Result.OK;
		}
		else {
			result = Result.FAILED;
		}
		return result;
	}

	@Override
	public Result recoverReception(EmailReceptionVO emailReceptionVO) {
		Result result = null;
		int status = mapper.recoverReception(emailReceptionVO);
		if (status > 0) {
			result = Result.OK;
		}
		else {
			result = Result.FAILED;
		}
		return result;
	}

	@Override
	public Result recoverEmail(int emailNo) {
		Result result = null;
		int status = mapper.recoverEmail(emailNo);
		if (status > 0) {
			result = Result.OK;
		}
		else {
			result = Result.FAILED;
		}
		return result;
	}

	@Override
	public Result clearReception(EmailReceptionVO emailReceptionVO) {
		Result result = null;
		int status = mapper.clearReception(emailReceptionVO);
		if (status > 0) {
			result = Result.OK;
		}
		else {
			result = Result.FAILED;
		}
		return result;
	}

	@Override
	public Result clearEmail(int emailNo) {
		Result result = null;
		int status = mapper.clearEmail(emailNo);
		if (status > 0) {
			result = Result.OK;
		}
		else {
			result = Result.FAILED;
		}
		return result;
	}

	@Override
	public int selectTrashCount(PaginationInfoVO<EmailVO> pagingVO) {
		return mapper.selectTrashCount(pagingVO);
	}

	@Override
	public List<EmailVO> selectTrashList(PaginationInfoVO<EmailVO> pagingVO) {
		return mapper.selectTrashList(pagingVO);
	}

	@Override
	public int selectTrashNoReadCount(int emplNo) {
		return mapper.selectTrashNoReadCount(emplNo);
	}

	@Override
	public int receptionCount(int emailNo) {
		return mapper.receptionCount(emailNo);
	}

	@Override
	public int receptionReadCount(int emailNo) {
		return mapper.receptionReadCount(emailNo);
	}

	@Override
	public List<EmailVO> mainEmailList(int emplNo) {
		return mapper.mainEmailList(emplNo);
	}

	@Override
	public List<EmailVO> mainSentList(int emplNo) {
		return mapper.mainSentList(emplNo);
	}

	@Override
	public List<EmailVO> mainNoReadList(int emplNo) {
		return mapper.mainNoReadList(emplNo);
	}

	@Override
	public List<EmailVO> mainImportantList(int emplNo) {
		return mapper.mainImportantList(emplNo);
	}

	@Override
	public int selectSearchCount(PaginationInfoVO<EmailVO> pagingVO) {
		return mapper.selectSearchCount(pagingVO);
	}

	@Override
	public List<EmailVO> selectSearchList(PaginationInfoVO<EmailVO> pagingVO) {
		return mapper.selectSearchList(pagingVO);
	}

	@Override
	public List<EmailVO> selectAllEmailList() {
		return mapper.selectAllEmailList();
	}

	@Override
	public int deptCount(String deptCode) {
		return mapper.deptCount(deptCode);
	}

	@Override
	public List<Map<String, Integer>> timeCount() {
		return mapper.timeCount();
	}

	@Override
	public List<Map<String, Integer>> dayOfWeekCount() {
		return mapper.dayOfWeekCount();
	}
}

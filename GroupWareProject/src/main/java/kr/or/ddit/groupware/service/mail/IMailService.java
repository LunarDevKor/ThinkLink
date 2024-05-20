package kr.or.ddit.groupware.service.mail;

import java.util.List;
import java.util.Map;

import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.BoardVO;
import kr.or.ddit.groupware.vo.EmailReceptionVO;
import kr.or.ddit.groupware.vo.EmailVO;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.PaginationInfoVO;

/**
 * 메일 서비스 인터페이스
 * @author <strong>최소희</strong>
 * @version 1.0
 * @see IMailService
 */
public interface IMailService {
	public EmailVO selectEmail(int emailNo);
	public Result deleteEmail(int emailNo);
	public Result deleteReception(EmailReceptionVO emailReceptionVO);
	public int selectEmailCount(PaginationInfoVO<EmailVO> pagingVO);
	public List<EmailVO> selectEmailList(PaginationInfoVO<EmailVO> pagingVO);
	public int selectNoReadCount(int emplNo);
	public Result readEmail(EmailReceptionVO emailReceptionVO);
	public Result importantEmail(int emailNo);
	public Result importantReception(EmailReceptionVO emailReceptionVO);
	public int selectSentCount(PaginationInfoVO<EmailVO> pagingVO);
	public List<EmailVO> selectSentList(PaginationInfoVO<EmailVO> pagingVO);
	public List<EmailReceptionVO> selectReceptionList(int emailNo);
	public List<EmailVO> selectNoReadList(PaginationInfoVO<EmailVO> pagingVO);
	public int selectImportantCount(PaginationInfoVO<EmailVO> pagingVO);
	public List<EmailVO> selectImportantList(PaginationInfoVO<EmailVO> pagingVO);
	public int selectImportantNoReadCount(int emplNo);
	public int selectToMeCount(PaginationInfoVO<EmailVO> pagingVO);
	public List<EmailVO> selectToMeList(PaginationInfoVO<EmailVO> pagingVO);
	public int selectToMeNoReadCount(int emplNo);
	public int selectReservationCount(int emplNo);
	public List<EmailVO> selectReservationList(PaginationInfoVO<EmailVO> pagingVO);
	public int selectDraftCount(PaginationInfoVO<EmailVO> pagingVO);
	public List<EmailVO> selectDraftList(PaginationInfoVO<EmailVO> pagingVO);
	public Result insertEmail(EmailVO emailVO, int[] recieverArray, int[] ccArray);
	public Result updateEmail(EmailVO emailVO, int[] receiverArray, int[] ccArray);
	public EmailReceptionVO selectReceptionOne(int emailNo);
	public Result existReception(EmailReceptionVO emailReceptionVO);
	public Result unimportantReception(EmailReceptionVO emailReceptionVO);
	public Result unimportantEmail(int emailNo);
	public Result recoverReception(EmailReceptionVO emailReceptionVO);
	public Result recoverEmail(int emailNo);
	public Result clearReception(EmailReceptionVO emailReceptionVO);
	public Result clearEmail(int emailNo);
	public int selectTrashCount(PaginationInfoVO<EmailVO> pagingVO);
	public List<EmailVO> selectTrashList(PaginationInfoVO<EmailVO> pagingVO);
	public int selectTrashNoReadCount(int emplNo);
	public int receptionCount(int emailNo);
	public int receptionReadCount(int emailNo);
	public List<EmailVO> mainEmailList(int emplNo);
	public List<EmailVO> mainSentList(int emplNo);
	public List<EmailVO> mainNoReadList(int emplNo);
	public List<EmailVO> mainImportantList(int emplNo);
	public int selectSearchCount(PaginationInfoVO<EmailVO> pagingVO);
	public List<EmailVO> selectSearchList(PaginationInfoVO<EmailVO> pagingVO);
	public List<EmailVO> selectAllEmailList();
	public int deptCount(String deptCode);
	public List<Map<String, Integer>> timeCount();
	public List<Map<String, Integer>> dayOfWeekCount();
}

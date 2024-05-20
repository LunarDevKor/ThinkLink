package kr.or.ddit.groupware.mapper.mail;

import java.util.List;
import java.util.Map;

import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.BoardVO;
import kr.or.ddit.groupware.vo.EmailReceptionVO;
import kr.or.ddit.groupware.vo.EmailVO;
import kr.or.ddit.groupware.vo.PaginationInfoVO;

/**
 * 메일 SQL Mapper
 * @author 최소희
 * @version 1.0
 * @see IMailMapper
 */
public interface IMailMapper {
	public EmailVO selectEmail(int emailNo);
	public int deleteEmail(int emailNo);
	public int deleteReception(EmailReceptionVO emailReceptionVO);
	public int selectEmailCount(PaginationInfoVO<EmailVO> pagingVO);
	public List<EmailVO> selectEmailList(PaginationInfoVO<EmailVO> pagingVO);
	public int selectNoReadCount(int emplNo);
	public int readEmail(EmailReceptionVO emailReceptionVO);
	public int importantEmail(int emailNo);
	public int importantReception(EmailReceptionVO emailReceptionVO);
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
	public int insertEmail(EmailVO emailVO);
	public void insertReception(EmailReceptionVO emailReceptionVO);
	public int updateEmail(EmailVO emailVO);
	public void deleteReceptionList(int emailNo);
	public EmailReceptionVO selectReceptionOne(int emailNo);
	public int existReception(EmailReceptionVO emailReceptionVO);
	public int unimportantReception(EmailReceptionVO emailReceptionVO);
	public int unimportantEmail(int emailNo);
	public int recoverReception(EmailReceptionVO emailReceptionVO);
	public int recoverEmail(int emailNo);
	public int clearReception(EmailReceptionVO emailReceptionVO);
	public int clearEmail(int emailNo);
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

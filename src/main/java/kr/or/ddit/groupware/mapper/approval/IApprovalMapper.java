package kr.or.ddit.groupware.mapper.approval;

import java.util.List;
import java.util.Map;

import kr.or.ddit.groupware.vo.ApprovalRfrncVO;
import kr.or.ddit.groupware.vo.ApprovalSearchVO;
import kr.or.ddit.groupware.vo.ApprovalVO;
import kr.or.ddit.groupware.vo.DocBookmarkVO;
import kr.or.ddit.groupware.vo.DocumentsVO;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.OrganizationTreeVO;
import kr.or.ddit.groupware.vo.SanctionerBookmarkGroupVO;
import kr.or.ddit.groupware.vo.SanctionerBookmarkRefVO;
import kr.or.ddit.groupware.vo.SanctionerBookmarkVO;
import kr.or.ddit.groupware.vo.SanctionerVO;

/**
 * 전자결재 SQL Mapper
 * @author 이명문
 * @version 1.0
 * @see IApprovalMapper
 */
public interface IApprovalMapper {

	List<ApprovalVO> selectDraftList(ApprovalVO approvalVO);

	List<OrganizationTreeVO> selectOragnTree();

	int insertSanctionerGroup(SanctionerBookmarkGroupVO vo);

	int insertSanctioner(SanctionerBookmarkVO vo);

	List<SanctionerBookmarkGroupVO> selectMyLine(SanctionerBookmarkGroupVO vo);

	int deleteMyLine(SanctionerBookmarkGroupVO vo);

	int deleteMyLineGroup(SanctionerBookmarkGroupVO vo);

	int insertApproval(ApprovalVO approvalVO);

	void insertSanctioners(SanctionerVO sanctionerVO);

	ApprovalVO selectApprovalDocument(int aprovlNo);

	List<ApprovalVO> selectApprovalList(SanctionerVO sanctionerVO);

	int confirmApproval(SanctionerVO sanctionerVO);

	int nextApprovalUpdate(SanctionerVO sanctionerVO);

	void finishApprovalDocument(int aprovlNo);

	void insertApprovalRfrnc(ApprovalRfrncVO approvalRfrncVO);

	List<ApprovalRfrncVO> selectApprovalRfrncer(int aprovlNo);

	int returnApproval(Map<String, String> param);

	int returnSanctioner(Map<String, String> param);

	void allApprovalCancel(Map<String, String> param);

	int holdSanctioner(Map<String, String> param);

	void readRfrncDocument(ApprovalRfrncVO approvalRfrncVO);

	int insertReferencer(SanctionerBookmarkRefVO sanctionerBookmarkRefVO);

	List<SanctionerBookmarkGroupVO> selectMyGroup(SanctionerBookmarkGroupVO vo);

	int deleteMyGroup(SanctionerBookmarkGroupVO vo);

	int reapplyApproval(ApprovalVO approvalVO);

	void deleteSanctioner(int aprovlNo);

	void deleteReferencer(int aprovlNo);

	int cancelApprovalDraft(int aprovlNo);
	
	int cancelApproval(SanctionerVO sanctionerVO);

	void nextApprovalStatusUpdate(SanctionerVO sanctionerVO);

	int approvalArbitrary(SanctionerVO sanctionerVO);

	List<ApprovalVO> selectMainApproval(ApprovalVO approvalVO);

	List<ApprovalVO> selectMainInprogress(ApprovalVO approvalVO);

	List<ApprovalVO> selectMainComplete(ApprovalVO approvalVO);

	List<Map<String, Object>> myDocumentsCount(int emplNo);

	List<ApprovalVO> selectApproveList(ApprovalVO approvalVO);

	int isExistDocument(DocBookmarkVO docBookmarkVO);

	int documentsBookmark(DocBookmarkVO docBookmarkVO);

	List<DocumentsVO> getDocumentsBookmark(int emplNo);

	int documentBookmarkDelete(DocBookmarkVO docBookmarkVO);

	int signEdit(EmployeeVO employeeVO);

	void approvalConfrimConetentUpdate(SanctionerVO sanctionerVO);

	List<ApprovalVO> adminApprovalList();

	List<ApprovalVO> approvalSearch(ApprovalSearchVO approvalSearchVO);

	List<ApprovalVO> getAllApprovalStat(ApprovalVO approvalVO);

	List<ApprovalVO> getReturnApprovalChartData(ApprovalVO approvalVO);

	List<ApprovalVO> getSanctionerChartData(ApprovalVO approvalVO);

	List<ApprovalVO> getSanctionerTimeChartData(ApprovalVO approvalVO);


}

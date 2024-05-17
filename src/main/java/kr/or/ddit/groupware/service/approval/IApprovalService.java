package kr.or.ddit.groupware.service.approval;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.ApprovalSearchVO;
import kr.or.ddit.groupware.vo.ApprovalVO;
import kr.or.ddit.groupware.vo.DocBookmarkVO;
import kr.or.ddit.groupware.vo.DocumentsVO;
import kr.or.ddit.groupware.vo.OrganizationTreeVO;
import kr.or.ddit.groupware.vo.SanctionerBookmarkGroupVO;
import kr.or.ddit.groupware.vo.SanctionerBookmarkRefVO;
import kr.or.ddit.groupware.vo.SanctionerBookmarkVO;
import kr.or.ddit.groupware.vo.SanctionerVO;

/**
 * 전자 결재 서비스 인터페이스
 * @author <strong>이명문</strong>
 * @version 1.0
 * @date : 2024. 4. 15
 * @see IApprovalService
 */
public interface IApprovalService {

	List<ApprovalVO> selectDraftList(ApprovalVO approvalVO);

	List<OrganizationTreeVO> selectOragnTree();

	int insertSanctionerGroup(SanctionerBookmarkGroupVO vo);

	Result insertSanctioner(SanctionerBookmarkVO[] bookmarkList);
	
	List<SanctionerBookmarkGroupVO> selectMyLine(SanctionerBookmarkGroupVO vo);

	Result deleteMyLine(SanctionerBookmarkGroupVO vo);

	int insertApproval(ApprovalVO approvalVO);

	ApprovalVO selectApprovalDocument(int aprovlNo);

	List<ApprovalVO> selectApprovalList(SanctionerVO sanctionerVO);

	Result confirmApproval(SanctionerVO sanctionerVO);

	Result returnApproval(Map<String, String> param);

	Result holdSanctioner(Map<String, String> param);

	Result insertReferencer(SanctionerBookmarkRefVO[] refList);

	List<SanctionerBookmarkGroupVO> selectMyGroup(SanctionerBookmarkGroupVO vo);

	Result deleteMyGroup(SanctionerBookmarkGroupVO vo);

	int reapplyApproval(ApprovalVO approvalVO);

	Result cancelApprovalDraft(int aprovlNo);

	Result cancelApproval(SanctionerVO sanctionerVO);

	List<ApprovalVO> selectMainApproval(ApprovalVO approvalVO);

	List<ApprovalVO> selectMainInprogress(ApprovalVO approvalVO);

	List<ApprovalVO> selectMainComplete(ApprovalVO approvalVO);

	List<Map<String, Object>> myDocumentsCount(int emplNo);

	Result documentsBookMark(DocBookmarkVO docBookmarkVO);

	List<DocumentsVO> getDocumentsBookmark(int emplNo);

	Result documentBookmarkDelete(DocBookmarkVO docBookmarkVO);

	Result signEdit(MultipartFile file);

	List<ApprovalVO> adminApprovalList();

	List<ApprovalVO> approvalSearch(ApprovalSearchVO approvalSearchVO);

	List<ApprovalVO> getAllApprovalStat(ApprovalVO approvalVO);

	List<ApprovalVO> getReturnApprovalChartData(ApprovalVO approvalVO);

	List<ApprovalVO> getSanctionerChartData(ApprovalVO approvalVO);

	List<ApprovalVO> getSanctionerTimeChartData(ApprovalVO approvalVO);


}

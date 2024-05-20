package kr.or.ddit.groupware.controller.approval;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.groupware.controller.common.CommonAbstractImpl;
import kr.or.ddit.groupware.service.approval.IApprovalService;
import kr.or.ddit.groupware.service.documents.IDocumentsService;
import kr.or.ddit.groupware.vo.ApprovalSearchVO;
import kr.or.ddit.groupware.vo.ApprovalVO;
import kr.or.ddit.groupware.vo.DocumentsVO;

@Controller
@RequestMapping("/admin/approval")
public class AdminApprovalController extends CommonAbstractImpl {
	
	@Inject
	private IApprovalService approvalService;
	
	@Inject
	private IDocumentsService documentsService;

	/**
	 * @method : approvalMain
	 * @auther : <strong>이명문</strong>
	 * @param  : 
	 * @return : 
	 * @date : 2024. 5. 7
	 */
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("")
	public String adminApprovalMain(Model model) throws Exception {
		List<ApprovalVO> approvalList = approvalService.adminApprovalList();
		List<DocumentsVO> documentsList = documentsService.selectDocumentsList();
		model.addAttribute("approvalList", mapper.writeValueAsString(approvalList));
		model.addAttribute("documentsList", documentsList);
		return "admin/approval/approval_admin";
	}
	
	
	/**
	 * @method : approvalSearch
	 * @auther : <strong>이명문</strong>
	 * @param  : 
	 * @return : 
	 * @date : 2024. 5. 7
	 */
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping("/search")
	public @ResponseBody List<ApprovalVO> approvalSearch(@RequestBody ApprovalSearchVO approvalSearchVO) {
		System.out.println("#### >>" + approvalSearchVO);
		List<ApprovalVO> approvalList = approvalService.approvalSearch(approvalSearchVO);
		return approvalList;
	}
	
	/**
	 * @method : approvalStat
	 * @auther : <strong>이명문</strong>
	 * @param  : 
	 * @return : 
	 * @throws Exception 
	 * @date : 2024. 5. 9
	 */
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/stat")
	public String approvalStat() throws Exception {
		return "admin/approval/approval_statistics";
	}
	
	/**
	 * @method : approvalStat
	 * @auther : <strong>이명문</strong>
	 * @param  : 
	 * @return : 
	 * @throws Exception 
	 * @date : 2024. 5. 11
	 */
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/countstat")
	public @ResponseBody List<ApprovalVO> approvalCountStat(ApprovalVO approvalVO) {
		return approvalService.getAllApprovalStat(approvalVO);
	}
	
	/**
	 * @method : approvalStat
	 * @auther : <strong>이명문</strong>
	 * @param  : 
	 * @return : 
	 * @throws Exception 
	 * @date : 2024. 5. 11
	 */
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/returnstat")
	public @ResponseBody List<ApprovalVO> approvalReturnStat(ApprovalVO approvalVO) {
		return approvalService.getReturnApprovalChartData(approvalVO);
	}
	
	/**
	 * @method : sacntionerStat
	 * @auther : <strong>이명문</strong>
	 * @param  : 
	 * @return : 
	 * @date : 2024. 5. 11
	 */
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/sancstat")
	public @ResponseBody List<ApprovalVO> sacntionerStat(ApprovalVO approvalVO) {
		return approvalService.getSanctionerChartData(approvalVO);
	}
	
	/**
	 * @method : sacntionerTimeStat
	 * @auther : <strong>이명문</strong>
	 * @param  : 
	 * @return : 
	 * @date : 2024. 5. 11
	 */
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/sanctimestat")
	public @ResponseBody List<ApprovalVO> sacntionerTimeStat(ApprovalVO approvalVO) {
		return approvalService.getSanctionerTimeChartData(approvalVO);
	}
	
	
	
}

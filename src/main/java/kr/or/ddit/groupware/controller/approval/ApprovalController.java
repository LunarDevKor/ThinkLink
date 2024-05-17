package kr.or.ddit.groupware.controller.approval;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.groupware.mapper.conn.ILoginMapper;
import kr.or.ddit.groupware.service.approval.IApprovalService;
import kr.or.ddit.groupware.service.attach.IAttachFileService;
import kr.or.ddit.groupware.service.documents.IDocumentsService;
import kr.or.ddit.groupware.service.employee.IEmployeeService;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.ApprovalVO;
import kr.or.ddit.groupware.vo.AttachFileGroupVO;
import kr.or.ddit.groupware.vo.CustomUser;
import kr.or.ddit.groupware.vo.DocBookmarkVO;
import kr.or.ddit.groupware.vo.DocumentsVO;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.OrganizationTreeVO;
import kr.or.ddit.groupware.vo.SanctionerBookmarkGroupVO;
import kr.or.ddit.groupware.vo.SanctionerBookmarkRefVO;
import kr.or.ddit.groupware.vo.SanctionerBookmarkVO;
import kr.or.ddit.groupware.vo.SanctionerVO;

/**
 * 전자결재 컨트롤러
 * 
 * @author <strong>이명문</strong>
 * @version 1.0
 * @see ApprovalController
 */
@Controller
@RequestMapping("/approval")
public class ApprovalController {

	@Inject
	private IApprovalService approvalService;
	
	@Inject
	private IEmployeeService employeeService;
	
	@Inject
	private IDocumentsService documentService;
	
	@Inject
	private IAttachFileService attachFileService;
	
	@Inject
	private ILoginMapper loginMapper;
	
	ObjectMapper mapper = new ObjectMapper();

	/**
	 * @method : approvalMain
	 * @auther : <strong>이명문</strong>
	 * @param  : model - 메인에 보여줄 리스트
	 * @return : approval/approvalmain
	 * @date : 2024. 4. 15
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("")
	public String approvalMain(Model model) {
		ApprovalVO approvalVO = new ApprovalVO();
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		approvalVO.setEmplNo(user.getEmployeeVO().getEmplNo());
		
		List<ApprovalVO> approvalList = approvalService.selectMainApproval(approvalVO);
		List<ApprovalVO> inprogressList = approvalService.selectMainInprogress(approvalVO);
		List<ApprovalVO> completeList = approvalService.selectMainComplete(approvalVO);
		
		model.addAttribute("approvalList", approvalList);
		model.addAttribute("inprogressList", inprogressList);
		model.addAttribute("completeList", completeList);
		
		return "approval/approvalmain";
	}

	/**
	 * @method : approvalForm
	 * @auther : <strong>이명문</strong>
	 * @param  : aprovlNo - 재기안 시 필요한 기안 번호
	 * @param  : model - 기안 정보
	 * @return : approval/approvalform
	 * @throws Exception 
	 * @date : 2024. 4. 15
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping(value = "/form", produces = MediaType.APPLICATION_JSON_VALUE)
	public String approvalForm(String aprovlNo, Model model, int docNo) throws Exception {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		
		if(aprovlNo != null && !aprovlNo.trim().equals("")) {
			ApprovalVO approvalVO = approvalService.selectApprovalDocument(Integer.parseInt(aprovlNo));
			model.addAttribute("approvalVO", approvalVO);
			model.addAttribute("status", "r");
		}
		
		DocumentsVO documentsVO = documentService.selectOneDoc(docNo);
		
		model.addAttribute("documentsVO", documentsVO);
		model.addAttribute("docNo", documentsVO.getDocNo());
		
		String userValue = mapper.writeValueAsString(userVO);
		model.addAttribute("userValue", userValue);
		
		return "approval/approvalform";
	}

	/**
	 * @method : approvalList
	 * @auther : <strong>이명문</strong>
	 * @param  : type - 타입으로 어떠한 리스트인지 구분
	 * @param  : model - 결재 리스트
	 * @return : approval/approvallist
	 * @date : 2024. 4. 15
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/list/{type}")
	public String approvalList(@PathVariable String type, Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		SanctionerVO sanctionerVO = new SanctionerVO();
		sanctionerVO.setApproverNo(customUser.getEmployeeVO().getEmplNo());
		sanctionerVO.setType(type);
		
		List<ApprovalVO> approvalList = approvalService.selectApprovalList(sanctionerVO);
		model.addAttribute("approvalList", approvalList);
		return "approval/approvallist";
	}
	
	
	/**
	 * @method : approvalDocumentsCount
	 * @auther : <strong>이명문</strong>
	 * @param  : emplNo - 사원번호
	 * @return : 대기 문서 갯수 카운팅한 JSON 데이터
	 * @date : 2024. 4. 23
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@ResponseBody
	@GetMapping("/listcount")
	public String approvalDocumentsCount(int emplNo) throws Exception {
		List<Map<String,Object>> countlist = approvalService.myDocumentsCount(emplNo);
		return mapper.writeValueAsString(countlist);
	}
	
	
	/**
	 * @method : approvalDocument
	 * @auther : <strong>이명문</strong>
	 * @param  : aprovlNo - 선택할 결재 번호
	 * @param  : model - 결재 상세 정보
	 * @return : approval/approvaldetail
	 * @date : 2024. 4. 16
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/document/{aprovlNo}")
	public String approvalDocument(@PathVariable int aprovlNo, Model model) {
		ApprovalVO approvalVO = approvalService.selectApprovalDocument(aprovlNo);
		if(approvalVO != null) {
			if(approvalVO.getAtchFileGroupNo() != null) {
				AttachFileGroupVO attachFileGroupVO = attachFileService.getAttachFileGroup(approvalVO.getAtchFileGroupNo());
				model.addAttribute("attachFileGroupVO", attachFileGroupVO);
			}
			
			model.addAttribute("approvalVO", approvalVO);
		}
		return "approval/approvaldetail";
	}
	
	/**
	 * @method : approvalDocList
	 * @auther : <strong>이명문</strong>
	 * @param  : type - 리스트 1차 구분
	 * @param  : subType - 리스트 2차 구분(일부 필요)
	 * @param  : model - 해당 리스트 정보
	 * @return : approval/approvaldraftlist
	 * @date : 2024. 4. 16
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/doclist/draft/{type}")
	public String approvalDocList(@PathVariable String type, String subType, Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		ApprovalVO approvalVO = new ApprovalVO();
		approvalVO.setEmplNo(customUser.getEmployeeVO().getEmplNo());
		approvalVO.setType(type);
		approvalVO.setSubType(subType);
		
		List<ApprovalVO> approvalList = approvalService.selectDraftList(approvalVO);
		model.addAttribute("approvalList", approvalList);
		model.addAttribute("type", type);
		
		return "approval/approvaldraftlist";
	}
	
	/**
	 * @method : confirmApproval
	 * @auther : <strong>이명문</strong>
	 * @param  : sanctionerVO - 결재 정보
	 * @return : Enum을 사용한 결과 반환
	 * @date : 2024. 4. 17
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/confirm")
	public ResponseEntity<String> confirmApproval(@RequestBody SanctionerVO sanctionerVO) {
		Result result = approvalService.confirmApproval(sanctionerVO);
		return result.equals(Result.OK) ?  ResponseEntity.status(HttpStatus.OK).body(result.toString()) :
			ResponseEntity.status(HttpStatus.BAD_REQUEST).body(result.toString());
	}
	
	/**
	 * @method : returnApproval
	 * @auther : <strong>이명문</strong>
	 * @param  : param - 기안 반려 처리
	 * @return : Enum을 사용한 결과 반환
	 * @date : 2024. 4. 17
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/return")
	public ResponseEntity<String> returnApproval(@RequestParam Map<String,String> param) {
		Result result = approvalService.returnApproval(param);
		return result.equals(Result.OK) ?  ResponseEntity.status(HttpStatus.OK).body(result.toString()) :
			ResponseEntity.status(HttpStatus.BAD_REQUEST).body(result.toString());
	}
	
	/**
	 * @method : holdSanctioner
	 * @auther : <strong>이명문</strong>
	 * @param  : param - 기안 보류 처리
	 * @return : Enum을 사용한 결과 반환
	 * @date : 2024. 4. 17
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/hold")
	public ResponseEntity<String> holdSanctioner(@RequestParam Map<String,String> param) {
		Result result = approvalService.holdSanctioner(param);
		return result.equals(Result.OK) ?  ResponseEntity.status(HttpStatus.OK).body(result.toString()) :
			ResponseEntity.status(HttpStatus.BAD_REQUEST).body(result.toString());
	}

	/**
	 * @method : approvalInsert
	 * @auther : <strong>이명문</strong>
	 * @param  : approvalVO - 기안 문서 정보
	 * @return : result - 기안 번호
	 * @date : 2024. 4. 18
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/insert")
	public ResponseEntity<String> approvalInsert(ApprovalVO approvalVO) {
		String type = approvalVO.getType();
		int result;
		
//		if(approvalVO.getAprovlNo() != 0) {
//			result = approvalService.reapplyApproval(approvalVO);
//			return ResponseEntity.status(HttpStatus.OK).body(String.valueOf(result));
//		}
		
		if(type == null || type.trim().equals("")) {
			result = approvalService.insertApproval(approvalVO);
		}else {
			result = approvalService.reapplyApproval(approvalVO);
		}
		
		return result > 0 ?  ResponseEntity.status(HttpStatus.OK).body(String.valueOf(result)) :
			ResponseEntity.status(HttpStatus.BAD_REQUEST).body(String.valueOf(result));
	}
	
	/**
	 * @method : approvalDraftCancel
	 * @auther : <strong>이명문</strong>
	 * @param  : aprovlNo - 기안 번호
	 * @return : result - 상신 취소 결과
	 * @date : 2024. 4. 22
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/draft/cancel/{aprovlNo}")
	public ResponseEntity<String> approvalDraftCancel(@PathVariable int aprovlNo) {
		Result result = approvalService.cancelApprovalDraft(aprovlNo);
		return result.equals(Result.OK) ?  ResponseEntity.status(HttpStatus.OK).body(result.toString()) :
			ResponseEntity.status(HttpStatus.BAD_REQUEST).body(result.toString());
	}
	
	/**
	 * @method : approvalCancel
	 * @auther : <strong>이명문</strong>
	 * @param  : sanctionerVO - 결재 정보
	 * @return : result - 결재 취소 결과
	 * @date : 2024. 4. 19
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/cancel")
	public ResponseEntity<String> approvalCancel(SanctionerVO sanctionerVO) {
		Result result = approvalService.cancelApproval(sanctionerVO);
		return result.equals(Result.OK) ?  ResponseEntity.status(HttpStatus.OK).body(result.toString()) :
			ResponseEntity.status(HttpStatus.BAD_REQUEST).body(result.toString());
	}
	
	/**
	 * @method : insertSanctionerGroup
	 * @auther : <strong>이명문</strong>
	 * @param  : sanctionerBookmarGroupVO - 즐겨찾기 그룹 정보
	 * @return : 생성한 북마크 그룹 번호
	 * @date : 2024. 4. 20
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@ResponseBody
	@PostMapping(value = "/sanctioner/insertgroup", produces = "text/plain; charset=UTF-8")
	public String insertSanctionerGroup(@RequestBody SanctionerBookmarkGroupVO vo) throws Exception {
		approvalService.insertSanctionerGroup(vo);
		return String.valueOf(vo.getSanctnerBkmkNo());
	}
	
	/**
	 * @method : insertSanctioner
	 * @auther : <strong>이명문</strong>
	 * @param  : bookmarkList - 즐겨찾기에 추가할 인원 정보
	 * @return : Enum을 사용한 결과 반환
	 * @date : 2024. 4. 20
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/sanctioner/insert")
	public ResponseEntity<String> insertSanctioner(@RequestBody SanctionerBookmarkVO[] bookmarkList) throws Exception {
		Result result = approvalService.insertSanctioner(bookmarkList);
		return ResponseEntity.ok(result.toString());
	}
	
	/**
	 * @method : insertReferencer
	 * @auther : <strong>이명문</strong>
	 * @param  : refList - 참조 즐겨찾기에 추가할 인원 정보
	 * @return : Enum을 사용한 결과 반환
	 * @date : 2024. 4. 20
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/sanctioner/refinsert")
	public ResponseEntity<String> insertReferencer(@RequestBody SanctionerBookmarkRefVO[] refList) throws Exception {
		Result result = approvalService.insertReferencer(refList);
		return ResponseEntity.ok(result.toString());
	}
	
	/**
	 * @method : selectMyLine
	 * @auther : <strong>이명문</strong>
	 * @param  : sanctionerBookmarGroupVO - 즐겨찾기 정보
	 * @return : JSON 타입으로 변환한 즐겨찾기 정보
	 * @date : 2024. 4. 21
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@ResponseBody
	@GetMapping(value = "/senctioner/myline", produces = MediaType.APPLICATION_JSON_VALUE)
	public String selectMyLine(SanctionerBookmarkGroupVO vo) throws Exception {
		List<SanctionerBookmarkGroupVO> groupList = approvalService.selectMyLine(vo);
		return mapper.writeValueAsString(groupList);
	}
	
	/**
	 * @method : selectMyGroup
	 * @auther : <strong>이명문</strong>
	 * @param  : sanctionerBookmarGroupVO - 참조 즐겨찾기 정보
	 * @return : JSON 타입으로 변환한 참조 즐겨찾기 정보
	 * @date : 2024. 4. 21
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@ResponseBody
	@GetMapping(value = "/senctioner/mygroup", produces = MediaType.APPLICATION_JSON_VALUE)
	public String selectMyGroup(SanctionerBookmarkGroupVO vo) throws Exception {
		List<SanctionerBookmarkGroupVO> groupList = approvalService.selectMyGroup(vo);
		return mapper.writeValueAsString(groupList);
	}
	
	/**
	 * @method : deleteMyLine
	 * @auther : <strong>이명문</strong>
	 * @param  : sanctionerBookmarGroupVO - 삭제할 즐겨찾기 정보
	 * @return : Enum을 사용한 결과 반환
	 * @date : 2024. 4. 22
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@ResponseBody
	@PostMapping(value = "/senctioner/delete", produces = "text/plain; charset=UTF-8")
	public String deleteMyLine(@RequestBody SanctionerBookmarkGroupVO vo) {
		Result result = approvalService.deleteMyLine(vo);
		return result.toString();
	}
	
	/**
	 * @method : deleteMyGroup
	 * @auther : <strong>이명문</strong>
	 * @param  : sanctionerBookmarGroupVO - 삭제할 즐겨찾기 그룹 정보
	 * @return : Enum을 사용한 결과 반환
	 * @date : 2024. 4. 22
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@ResponseBody
	@PostMapping(value = "/senctioner/refdelete", produces = "text/plain; charset=UTF-8")
	public String deleteMyGroup(@RequestBody SanctionerBookmarkGroupVO vo) {
		Result result = approvalService.deleteMyGroup(vo);
		return result.toString();
	}
	
	/**
	 * @method : selcetOragnTree
	 * @auther : <strong>이명문</strong>
	 * @return : 조직도 생성에 필요한 부서 정보 
	 * @date : 2024. 4. 19
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping(value = "/organtree", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> selcetOragnTree() throws Exception {
		List<OrganizationTreeVO> organList = approvalService.selectOragnTree();
		return ResponseEntity.ok(mapper.writeValueAsString(organList));
	}
	
	/**
	 * @method : selectEmpList
	 * @auther : <strong>이명문</strong>
	 * @return : 조직도 생성에 필요한 사원 정보 
	 * @date : 2024. 4. 19
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping(value = "/emplist", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> selectEmpList() throws Exception {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<EmployeeVO> empList = employeeService.selectAllEmplExceptMe(user.getEmployeeVO().getEmplNo());
		return ResponseEntity.ok(mapper.writeValueAsString(empList));
	}
	
	/**
	 * @method : documentsBookMark
	 * @auther : <strong>이명문</strong>
	 * @param  : 
	 * @return : 
	 * @date : 2024. 4. 30
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/docbookmark", produces = "text/plain; charset=UTF-8")
	public ResponseEntity<String> documentsBookMark(DocBookmarkVO docBookmarkVO) {
		Result result = approvalService.documentsBookMark(docBookmarkVO);
		return ResponseEntity.ok(result.toString());
	}
	
	/**
	 * @method : getDocumentsBookMark
	 * @auther : <strong>이명문</strong>
	 * @param  : 
	 * @return : 
	 * @throws Exception 
	 * @date : 2024. 4. 30
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping(value = "/doc/bookmark", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> getDocumentsBookMark(int emplNo) throws Exception {
		List<DocumentsVO> documentsList = approvalService.getDocumentsBookmark(emplNo);
		return ResponseEntity.ok(mapper.writeValueAsString(documentsList));
	}
	
	/**
	 * @method : documentBookmarkDelete
	 * @auther : <strong>이명문</strong>
	 * @param  : 
	 * @return : 
	 * @date : 2024. 4. 30
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/doc/del", produces = "text/plain; charset=UTF-8")
	public ResponseEntity<String> documentBookmarkDelete(DocBookmarkVO docBookmarkVO) {
		Result result = approvalService.documentBookmarkDelete(docBookmarkVO);
		return ResponseEntity.ok(result.toString());
	}
	
	/**
	 * @method : optionPage
	 * @auther : <strong>이명문</strong>
	 * @param  : 
	 * @return : 
	 * @date : 2024. 5. 3
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping(value = "/option")
	public String optionPage(Model model) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = loginMapper.readByEmployeeId(user.getEmployeeVO().getEmplId());
		model.addAttribute("employee", employeeVO);
		return "approval/approvaloption";
	}
	
	/**
	 * @method : signEdit
	 * @auther : <strong>이명문</strong>
	 * @param  : 
	 * @return : 
	 * @date : 2024. 5. 3
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/signedit")
	public String signEdit(MultipartFile signFile, Model model) {
		approvalService.signEdit(signFile);
		return "redirect:/approval/option";
	}
}

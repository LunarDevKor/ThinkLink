package kr.or.ddit.groupware.controller.documents;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.groupware.service.documents.IDocumentsService;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.CustomUser;
import kr.or.ddit.groupware.vo.DocumentsVO;
import kr.or.ddit.groupware.vo.EmployeeVO;

@Controller
@RequestMapping("/admin/documents")
public class DocumentsController {

	@Inject
	private IDocumentsService documentsService;
	
	ObjectMapper mapper = new ObjectMapper();
	
	/**
	 * @method : selectDocumentsList
	 * @auther : <strong>이명문</strong>
	 * @return : JSON 형식의 documentsList
	 * @date : 2024. 4. 17
	 */
	@ResponseBody
	@GetMapping(value = "/doclist", produces = MediaType.APPLICATION_JSON_VALUE)
	public String selectDocumentsList() throws Exception {
		List<DocumentsVO> documentsList = documentsService.selectDocumentsList();
		return mapper.writeValueAsString(documentsList);
	}
	
	
	/**
	 * @method : docListView 문서양식 메인 리스트 뷰 
	 * @auther : <strong>이영주</strong>
	 * @param :
	 * @return :
	 * @date : 2024. 4. 22
	 *
	 */
	//@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@GetMapping("/list")
	public String docListView() {
		
		return "admin/documents/documentslist";
	}
	
	/**
	 * @method : selectDocList
	 * @auther : <strong>이영주</strong>
	 * @param :
	 * @return : jstree를 그리기 위한 리스트 
	 * @date : 2024. 4. 22
	 *
	 */
	//@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@ResponseBody
	@GetMapping(value = "/selectdoclist", produces = MediaType.APPLICATION_JSON_VALUE)
	public String selectDocList() throws Exception {
		List<DocumentsVO> docList = documentsService.selectDocList();
		return mapper.writeValueAsString(docList);
	}
	
	/**
	 * @method : selectOneDoc 미리보기 버튼 눌렀을때 실행시킬 비동기 메서드
	 * @auther : <strong>이영주</strong>
	 * @param : docNo
	 * @return : 특정 문서 1개의 VO값   
	 * @date : 2024. 4. 25
	 *
	 */
	//@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@ResponseBody
	@GetMapping(value = "/selectOneDoc", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> selectOneDoc(@RequestParam int docNo) throws Exception {
		DocumentsVO selectOneDoc = documentsService.selectOneDoc(docNo);
		
		String selectOneDocList = mapper.writeValueAsString(selectOneDoc);
		
		return new ResponseEntity<String>(selectOneDocList, HttpStatus.OK);
	}
	/**
	 * @method : insertDocFormView 문서양식 인서트화면출력
	 * @auther : <strong>이영주</strong>
	 * @param : 
	 * @return : 문서양식 인서트 화면 
	 * @date : 2024. 4. 22
	 *
	 */
	//@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@GetMapping("/insertdocform")
	public String insertDocFormView() {
		return "admin/documents/documentsinsert";
	}
	
	
	/**
	 * @method : modifyDocFormView 수정폼
	 * @auther : <strong>이영주</strong>
	 * @param : int docNo 문서시퀀스번호
	 * @return : 수정폼으로 분기처리 된 인서트폼 
	 * @date : 2024. 4. 24
	 *
	 */
	//@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@GetMapping("/modifydocform")
	public String modifyDocFormView(Model model, int docNo) {
		
		DocumentsVO selectOne = documentsService.selectOneDoc(docNo);
		
		model.addAttribute("selectOne", selectOne);
		model.addAttribute("status", "u");
		return "admin/documents/documentsinsert";
	}
	/**
	 * @method : insertDocuments
	 * @auther : <strong>이영주</strong>
	 * @param :
	 * @return :
	 * @date : 2024. 4. 22
	 *
	 */
	//@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@PostMapping("/insertdocform")
	public String insertDocuments(DocumentsVO docVO,Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO(); 
		int emplNo = userVO.getEmplNo();
		
		docVO.setDocRegister(emplNo);					//사원번호
		docVO.setDocTypeCode(docVO.getDocTypeCode());	//분류코드
		docVO.setDocUpdusr(emplNo);
		String goPage = "";
		
		Result result = documentsService.insertDocform(docVO);
		if(result.equals(Result.OK)) {
			goPage = "redirect:list";
		}else {
			goPage = "admin/documents/list"; //바꿔야 
		}
		return goPage;
	}
	
	/**
	 * @method : 문서 수정 post 방식
	 * @auther : <strong>이영주</strong>
	 * @param : model, 수정하는 사원의 번호, 문서 제목, 내용, 사용여부, 분류 
	 * @return : 목록 페이지 
	 * @date : 2024. 4. 24
	 *
	 */
	//@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@PostMapping("/modifydocform")
	public String modifyDocForm(DocumentsVO docVO,Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO(); 
		int emplNo = userVO.getEmplNo();
		
		docVO.setDocUpdusr(emplNo);
		String goPage = "";
		
		Result result = documentsService.updateDocuments(docVO);
		if(result.equals(Result.OK)) {
			goPage = "redirect:list";
		}else {
			goPage = "admin/documents/list"; //바꿔야 
		}
		return goPage;
	}
	
	
	/**
	 * @method : updateDocForm
	 * @auther : <strong>이영주</strong>
	 * @param : 사원번호, docNo, docNm
	 * @return : 업데이트 된 docVO
	 * @date : 2024. 4. 23
	 *
	 */
	//@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@PostMapping(value = "/updateDocForm", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> updateDocForm(@RequestBody DocumentsVO docVO) throws Exception{
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO(); 
		int emplNo = userVO.getEmplNo();
		docVO.setDocUpdusr(emplNo);
		
		Result result = documentsService.updateDocForm(docVO);
		
		String updateVO = mapper.writeValueAsString(docVO);
		
		if(result.equals(Result.OK)) {
			return new ResponseEntity<String>(updateVO,HttpStatus.OK);
		}else {
			return new ResponseEntity<String>("FAILED",HttpStatus.BAD_REQUEST);
		}
		
	}

	/**
	 * @method : delSelectedDoc 문서삭제메서드
	 * @auther : <strong>이영주</strong>
	 * @param : docVO.getDocNo()
	 * @return : OK, FAILED
	 * @date : 2024. 4. 25
	 *
	 */
	//@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@PostMapping(value = "/delSelectedDoc")
	public ResponseEntity<String> delSelectedDoc(@RequestBody DocumentsVO docVO){
		
		int docNo = docVO.getDocNo();
		
		int result = documentsService.delSelectedDoc(docNo);

		if (result > 0) {
			return new ResponseEntity<String>("OK", HttpStatus.OK);
		}
		else {
			return new ResponseEntity<String>("FAILED", HttpStatus.BAD_REQUEST);
		}
	}
	
	/**
	 * @method : documentsStatMain
	 * @auther : <strong>이명문</strong>
	 * @param  : 
	 * @return : 
	 * @date : 2024. 5. 11
	 */
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/stat")
	public String documentsStatMain() {
		return "admin/documents/documents_statistics";
	}
	
	/**
	 * @method : documentsChart
	 * @auther : <strong>이명문</strong>
	 * @param  : 
	 * @return : 
	 * @date : 2024. 5. 11
	 */
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/chart")
	public @ResponseBody List<DocumentsVO> documentsChart(DocumentsVO documentsVO) {
		return documentsService.getDocumentsUsedCountByDept(documentsVO);
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/empchart")
	public @ResponseBody List<DocumentsVO> documentEmpChart(DocumentsVO documentsVO) {
		return documentsService.getDocumentEmployeeChart(documentsVO);
	}
}